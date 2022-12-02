unit Inicio;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Actions,
  FMX.ActnList, FMX.Layouts, FMX.ExtCtrls, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Objects, FMX.Edit, idHashSHA, FMX.TabControl;

type
  TFrmCadastro = class(TForm)
    Layout1: TLayout;
    Image1: TImage;
    LayoutLogin: TLayout;
    Label1: TLabel;
    edt_login: TEdit;
    LayoutSenha: TLayout;
    Label2: TLabel;
    edt_senha: TEdit;
    rect_entrar: TRoundRect;
    Label3: TLabel;
    rect_cadastro: TRoundRect;
    Label4: TLabel;
    TabControl1: TTabControl;
    TabLogin: TTabItem;
    TabCadastro: TTabItem;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Layout2: TLayout;
    Image2: TImage;
    LayoutLoginCadastro: TLayout;
    Label5: TLabel;
    edt_logincadastro: TEdit;
    LayoutSenhaCadastro: TLayout;
    Label6: TLabel;
    edt_senhacadastro: TEdit;
    rect_cadastrar: TRoundRect;
    Label7: TLabel;
    rect_login: TRoundRect;
    ActionList1: TActionList;
    ChangeTabAction1: TChangeTabAction;
    ChangeTabAction2: TChangeTabAction;
    LayoutImage: TLayout;
    Image_avisible: TImage;
    Image_esconde: TImage;
    LayoutImageSenha: TLayout;
    Image_escondesenha: TImage;
    Image_avisiblesenha: TImage;
    LayoutCadastrar: TLayout;
    LayoutLoginn: TLayout;
    LayoutEntrar: TLayout;
    LayoutCadastra: TLayout;
    procedure rect_entrarClick(Sender: TObject);
    procedure rect_cadastrarClick(Sender: TObject);
    procedure rect_loginClick(Sender: TObject);
    procedure rect_cadastroClick(Sender: TObject);
    procedure Image_escondeClick(Sender: TObject);
    procedure Image_avisibleClick(Sender: TObject);
    procedure Image_escondesenhaClick(Sender: TObject);
    procedure Image_avisiblesenhaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    usuariologado: integer;
    function SHA1(AString: string): string;
  end;

var
  FrmCadastro: TFrmCadastro;

implementation

{$R *.fmx}

uses UDM, Principal;

function TFrmCadastro.SHA1(AString: string): string;
var
  SenhaSH1: TIDhASHsha1;
begin
  SenhaSH1 := TIDhASHsha1.Create;
  TRY
    Result := SenhaSH1.HashStringAsHex(AString);
  FINALLY
    SenhaSH1.Free;
  END;
end;

procedure TFrmCadastro.Image_escondeClick(Sender: TObject);
begin
  Image_esconde.Visible := false;
  Image_avisible.Visible := True;
  edt_senha.Password := false;
end;

procedure TFrmCadastro.Image_escondesenhaClick(Sender: TObject);
begin
  Image_escondesenha.Visible := false;
  Image_avisiblesenha.Visible := True;
  edt_senhacadastro.Password := false;
end;

procedure TFrmCadastro.Image_avisibleClick(Sender: TObject);
begin
  Image_esconde.Visible := True;
  Image_avisible.Visible := false;
  edt_senha.Password := True;
end;

procedure TFrmCadastro.Image_avisiblesenhaClick(Sender: TObject);
begin
  Image_escondesenha.Visible := True;
  Image_avisiblesenha.Visible := false;
  edt_senhacadastro.Password := True;
end;

procedure TFrmCadastro.rect_cadastrarClick(Sender: TObject);
begin

  dm.FDQuery1.Close;
  dm.FDQuery1.Open();
  if (edt_logincadastro.text <> EmptyStr) then
  begin
  if (edt_senhacadastro.text <> EmptyStr)
  then
  begin
  dm.FDQuery1.Append;
  dm.FDQuery1email.AsString := edt_logincadastro.text;
  dm.FDQuery1Senha.AsString := SHA1(edt_senhacadastro.text);
  dm.FDQuery1.Post;
  dm.FDConnection1.CommitRetaining;
  ShowMessage('Cadastrado!');
  ChangeTabAction1.Execute;
  end
  else
    begin
      ShowMessage('digite a senha');
    end;

  end
  else
    begin
      ShowMessage('digite o email');
    end;
end;

procedure TFrmCadastro.rect_cadastroClick(Sender: TObject);
begin
  ChangeTabAction2.Execute;
end;

procedure TFrmCadastro.rect_entrarClick(Sender: TObject);
var
  senha: String;
begin
  senha := SHA1(edt_senha.text);
  dm.FDQueryLogin.Close;
  dm.FDQueryLogin.paramByName('pEmail').AsString := edt_login.text;
  dm.FDQueryLogin.Open();
  if not(dm.FDQueryLogin.IsEmpty) and (dm.FDQueryLoginSenha.AsString = senha)
  then
  begin
    if not Assigned(FrmPrincipal) then
      usuariologado := dm.FDQueryLoginidlogin.AsInteger;
    Application.CreateForm(TFrmPrincipal, FrmPrincipal);
    FrmPrincipal.Show();
  end
  else
  begin
    ShowMessage('Login ou senha incorreta');
  end;
end;

procedure TFrmCadastro.rect_loginClick(Sender: TObject);
begin
  ChangeTabAction1.Execute;
end;

end.
