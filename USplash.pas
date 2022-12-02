unit USplash;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, REST.Types,
  FMX.Controls.Presentation, FMX.StdCtrls, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, FMX.Objects, FMX.Layouts, System.JSON;

type
  TSplash = class(TForm)
    LayoutPrincipal: TLayout;
    Image1: TImage;
    LayoutUpdate: TLayout;
    Image_seta: TImage;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    lblversao: TLabel;
    lblatualizar: TLabel;
    rect_atualizar: TRectangle;
    Label3: TLabel;
    LayoutText: TLayout;
    LayoutImage: TLayout;
    LayoutRect: TLayout;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OnFinishUpdate(Sender: TObject);
    procedure rect_atualizarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    versao_app : string;
    versao_server : string;
  end;

var
  Splash: TSplash;

implementation

{$R *.fmx}

uses UOpenURL, Inicio;


procedure TSplash.FormCreate(Sender: TObject);
begin
     versao_app := '1.0';
     versao_server := '0.0';
end;

procedure TSplash.FormShow(Sender: TObject);
var
  t: TThread;
begin
   t:= TThread.CreateAnonymousThread(
    procedure
    var
      JsonObj: TJSONObject;
    begin
      sleep(2000);
      try
        RESTRequest1.Execute;
        except
          on ex: Exception do
          begin
            raise Exception.Create('Erro ao acessar o servidor' + ex.Message);
            exit;
          end;
      end;
      try
          JsonObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes
            (RESTRequest1.Response.JSONValue.ToString), 0) as TJSONObject;

          versao_server := TJSONObject(JsonObj).GetValue('Versao').Value;
      finally
          JsonObj.disposeof;
      end;
    end);

  t.OnTerminate := OnFinishUpdate;
  t.Start;
end;


procedure TSplash.OnFinishUpdate(Sender: TObject);
begin
  if Assigned(TThread(Sender).FatalException) then
  begin
    ShowMessage(Exception(TThread(Sender).FatalException).Message);
    exit;
  end;

      if versao_app > versao_server then
  begin
         LayoutPrincipal.Visible := true;
    LayoutUpdate.Visible := False;
      if not Assigned(FrmCadastro) then
      Application.CreateForm(TFrmCadastro, FrmCadastro);
     FrmCadastro.show();
     FrmCadastro.ChangeTabAction2.Execute;
  end;

  if versao_app < versao_server then
  begin
    LayoutPrincipal.Visible := False;
    LayoutUpdate.Visible := true;

    image_seta.Position.Y := 0;
    image_seta.Opacity := 0.5;
    lblversao.Opacity := 0;
    lblatualizar.Opacity := 0;
    rect_atualizar.Opacity := 0;

    LayoutUpdate.BringToFront;
    LayoutUpdate.AnimateFloat('Margins.Top', 0, 0.8, TAnimationType.InOut,
    TInterpolationType.Circular);

    image_seta.AnimateFloatDelay('Position Y', 50, 0.5, 1, TAnimationType.Out,
    TInterpolationType.Back);
    image_seta.AnimateFloatDelay('Opacity',1, 0.4, 0.9);

    lblversao.AnimateFloatDelay('Opacity',1,0.7,1.3);
    lblatualizar.AnimateFloatDelay('Opacity',1,0.7,1.6);
    rect_atualizar.AnimateFloatDelay('Opacity', 1,0.7,1.9)

  end;

end;

procedure TSplash.rect_atualizarClick(Sender: TObject);
begin
var
  url:string;

  begin
    {$IFDEF ANDROID}
    url := 'https://drive.google.com/file/d/1iCC_xoToM-QPoQRd5S6MRWjt6qnvMVrT/view?usp=sharing';
    {$ELSE}
    url := 'https://drive.google.com/file/d/1iCC_xoToM-QPoQRd5S6MRWjt6qnvMVrT/view?usp=sharing';
    {$ENDIF}
    OpenURL(url, False);
    Application.Terminate;
  end;

end;

end.
