unit Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListBox, FMX.Layouts,
  FMX.Objects, IOUtils, System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ScrollBox,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Bindings.Outputs,
  FMX.Bind.Editors,Data.Bind.Components, Data.Bind.DBScope, System.Actions,
  FMX.ActnList, FMX.MultiView, FireDAC.Stan.Param;

type
  TFrmPrincipal = class(TForm)
    LayoutPrincipal: TLayout;
    TabControl1: TTabControl;
    TabMenu: TTabItem;
    TabCadastroCarro: TTabItem;
    Image1: TImage;
    btnMenu: TButton;
    Label1: TLabel;
    MultiView1: TMultiView;
    Veiculo: TButton;
    Image2: TImage;
    LayoutCadastroCarro: TLayout;
    Image3: TImage;
    LayoutImagem: TLayout;
    LayoutDadosCarro: TLayout;
    Label2: TLabel;
    LayoutPlaca: TLayout;
    LayoutDescricao: TLayout;
    Label3: TLabel;
    LayoutMediaG: TLayout;
    Label4: TLabel;
    LayoutMediaE: TLayout;
    Label5: TLabel;
    LayoutMediaD: TLayout;
    ActionList1: TActionList;
    ChangeTabAction1: TChangeTabAction;
    ChangeTabAction2: TChangeTabAction;
    btn_salvar: TButton;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    btn_limpar: TButton;
    btn_rota: TButton;
    btn_gps: TButton;
    rect_cars: TRectangle;
    edit_placa: TEdit;
    edt_desc: TEdit;
    edt_mediag: TEdit;
    edt_mediad: TEdit;
    edt_mediae: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure VeiculoClick(Sender: TObject);
    procedure btn_salvarClick(Sender: TObject);
    procedure GetVeiculo;
    procedure btn_limparClick(Sender: TObject);
    procedure btn_rotaClick(Sender: TObject);
    procedure btn_gpsClick(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}
uses UDM, Inicio, GPS, Distancia, USplash;

procedure TFrmPrincipal.btn_gpsClick(Sender: TObject);
begin
    FormGPS:=TFormGPS.Create(Application);
     FormGPS.Show;
end;

procedure TFrmPrincipal.btn_limparClick(Sender: TObject);
begin
  edit_placa.Text := '';
  edt_desc.Text := '';
  edt_mediag.Text := '';
  edt_mediad.Text := '';
  edt_mediae.Text := '';
end;

procedure TFrmPrincipal.btn_rotaClick(Sender: TObject);
begin
  FrmDistancia:=TFrmDistancia.Create(Application);
  FrmDistancia.Show;
end;

procedure TFrmPrincipal.btn_salvarClick(Sender: TObject);
begin

  dm.FDQueryVeiculo.Close;
  dm.FDQueryVeiculo.Open();

  dm.FDQueryVeiculo.Append;
  dm.FDQueryVeiculoplaca.AsString := edit_placa.Text;
  dm.FDQueryVeiculodescricao.AsString := edt_desc.Text;
  dm.FDQueryVeiculomediag.AsFloat := edt_mediag.Text.ToDouble();
  dm.FDQueryVeiculomediad.AsFloat := edt_mediad.Text.ToDouble();
  dm.FDQueryVeiculomediae.AsFloat := edt_mediae.Text.ToDouble();
  ShowMessage('Concluido');
  dm.FDQueryVeiculo.Post;

  edit_placa.Text := '';
  edt_desc.Text := '';
  edt_mediag.Text := '';
  edt_mediad.Text := '';
  edt_mediae.Text := '';

end;


procedure TFrmPrincipal.GetVeiculo;
begin
  dm.FDQueryUsuarioLogin.Close;
  dm.FDQueryUsuarioLogin.ParamByName('pidlogin').AsInteger := FrmCadastro.usuariologado;
  dm.FDQueryUsuarioLogin.Open();

  edit_placa.Text := dm.FDQueryVeiculoplaca.AsString;
  edt_desc.Text := dm.FDQueryVeiculodescricao.AsString;
  edt_mediag.Text := dm.FDQueryVeiculomediag.AsFloat.ToString;
  edt_mediae.Text := dm.FDQueryVeiculomediae.AsFloat.ToString;
  edt_mediad.Text := dm.FDQueryVeiculomediad.AsFloat.ToString;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  dm.FDQueryVeiculo.Close;
  dm.FDQueryVeiculo.Open();

  edit_placa.Text := '';
  edt_desc.Text := '';
  edt_mediag.Text := '';
  edt_mediad.Text := '';
  edt_mediae.Text := '';

end;


procedure TFrmPrincipal.VeiculoClick(Sender: TObject);
begin
  changetabaction2.Execute;
  MultiView1.HideMaster();
end;

end.
