unit UDM;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,IOUtils;

type
  Tdm = class(TForm)
    FDConnection1: TFDConnection;
    FDQueryLogin: TFDQuery;
    FDQueryLoginidlogin: TIntegerField;
    FDQueryLoginemail: TStringField;
    FDQueryLoginsenha: TStringField;
    FDQueryUsuarioLogin: TFDQuery;
    FDQueryVeiculo: TFDQuery;
    FDQueryVeiculoid: TFDAutoIncField;
    FDQueryVeiculoplaca: TStringField;
    FDQueryVeiculodescricao: TStringField;
    FDQueryVeiculomediag: TBCDField;
    FDQueryVeiculomediae: TBCDField;
    FDQueryVeiculomediad: TBCDField;
    FDQuery1: TFDQuery;
    FDQuery1idlogin: TFDAutoIncField;
    FDQuery1email: TStringField;
    FDQuery1senha: TStringField;
    procedure FDConnection1BeforeConnect(Sender: TObject);
    procedure FDConnection1AfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.fmx}

procedure Tdm.FDConnection1AfterConnect(Sender: TObject);
var
  strSQL: string;
begin
  strSQL:= 'create table IF NOT EXISTS login( '+
  'idlogin integer not null primary key autoincrement,'+
  'email varchar(50),'+
  'senha varchar(100))';
  FDConnection1.ExecSQL(strSQL);


  strSQL := EmptyStr;
  strSQL := 'create table IF NOT EXISTS veiculo('+
  'id integer not null primary key autoincrement,'+
  'placa varchar(7),'+
  'descricao varchar(100),'+
  'mediag numeric(8,2),' +
  'mediae numeric(8,2),' +
  'mediad numeric(8,2))';
  FDConnection1.ExecSQL(strSQL);

  FDQueryLogin.Active:=true;
  FDQueryVeiculo.Active:=true;
end;


procedure Tdm.FDConnection1BeforeConnect(Sender: TObject);
var
strPath: string;
begin
 {$IF DEFINED(iOS) or DEFINED(ANDROID)}
strPath := System.IOUtils.Tpath.Combine(System.IOUtils.Tpath.GetDocumentsPath,
'bd.db');
  {$ENDIF}
   {$IFDEF MSWINDOWS}
    strPath :=System.IOUtils.Tpath.Combine
    ('D:\Users\lmsilva7.UNIVEL\Desktop\DelphiMaster\',
    'bd.db');
    {$ENDIF}
    FDConnection1.Params.Values['UseUnicode'] := 'False';
    FDConnection1.Params.Values['DATABASE'] :=strPath;
end;
end.
