program App;

uses
  System.StartUpCopy,
  FMX.Forms,
  Inicio in 'Inicio.pas' {FrmCadastro},
  Principal in 'Principal.pas' {FrmPrincipal},
  UDM in 'UDM.pas' {dm},
  USplash in 'USplash.pas' {Splash},
  UOpenURL in 'UOpenURL.pas',
  GPS in 'GPS.pas' {FormGPS},
  Distancia in 'Distancia.pas' {FrmDistancia};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TSplash, Splash);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
