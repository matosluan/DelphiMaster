unit Distancia;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, REST.Types,
  FMX.StdCtrls, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.Objects, System.JSON,
  FMX.MultiView, System.Math.Vectors, FMX.Controls3D, FMX.Layers3D, FMX.ListBox;

type
  TFrmDistancia = class(TForm)
    edit_origem: TEdit;
    edit_destino: TEdit;
    lbl_destino: TLabel;
    LayoultPrincipal: TLayout;
    lbl_origem: TLabel;
    lbl_distancia: TLabel;
    lbl_tempo: TLabel;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    rect_calcular: TRectangle;
    Label2: TLabel;
    rect_top: TRectangle;
    Label1: TLabel;
    LayoutOrigem: TLayout;
    LayoutDestino: TLayout;
    LayoutDistanciaTempo: TLayout;
    btn_menu: TButton;
    btn_gps: TButton;
    procedure rect_calcularClick(Sender: TObject);
    procedure btn_menuClick(Sender: TObject);
    procedure btn_gpsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDistancia: TFrmDistancia;

implementation

{$R *.fmx}

Uses UDM, GPS, Principal;

procedure TFrmDistancia.btn_gpsClick(Sender: TObject);
begin
  FormGPS := TFormGPS.Create(Application);
  FormGPS.Show;
end;

procedure TFrmDistancia.btn_menuClick(Sender: TObject);
begin
  FrmPrincipal.Show;
end;

procedure TFrmDistancia.rect_calcularClick(Sender: TObject);
var
  retorno: TJSONObject;
  prows: TJSONPair;
  arrayr: TJSONArray;
  orows: TJSONObject;
  arraye: TJSONArray;
  oelementos: TJSONObject;
  oduracao, odistancia: TJSONObject;

  distancia_str, duracao_str: string;
  distancia_int, duracao_int: integer;
begin
  RESTRequest1.Resource :=
    'json?origins={origem}&destinations={destino}&mode=driving&language=pt-BR&key=AIzaSyAwjnJzF57fQddVy_dL8yTC01Zw7ufVuY8';
  RESTRequest1.Params.AddUrlSegment('origem', edit_origem.Text);
  RESTRequest1.Params.AddUrlSegment('destino', edit_destino.Text);
  RESTRequest1.Execute;

  retorno := RESTRequest1.Response.JSONValue as TJSONObject;

  if retorno.GetValue('status').Value <> 'OK' then
  begin
    showmessage('Ocorreu um erro ao calcular a a viagem.');
    exit;
  end;

  prows := retorno.Get('rows');
  arrayr := prows.JSONValue as TJSONArray;
  orows := arrayr.Items[0] as TJSONObject;
  arraye := orows.GetValue('elements') as TJSONArray;
  oelementos := arraye.Items[0] as TJSONObject;

  odistancia := oelementos.GetValue('distance') as TJSONObject;
  oduracao := oelementos.GetValue('duration') as TJSONObject;

  distancia_str := odistancia.GetValue('text').Value;
  distancia_int := odistancia.GetValue('value').Value.ToInteger;

  duracao_str := oduracao.GetValue('text').Value;
  duracao_int := oduracao.GetValue('value').Value.ToInteger;

  lbl_distancia.Text := 'Distância: ' + distancia_str;
  lbl_tempo.Text := 'Tempo: ' + duracao_str;
end;

end.
