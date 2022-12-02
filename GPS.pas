unit GPS;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Sensors,
  FMX.TabControl, System.Sensors.Components, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Maps, FMX.Layouts, System.Permissions, FMX.MultiView,
  FMX.Objects;

type
  TFormGPS = class(TForm)
    TabControl1: TTabControl;
    LocationSensor1: TLocationSensor;
    TabItemGPS: TTabItem;
    LayoutFundo: TLayout;
    MapView1: TMapView;
    Switch1: TSwitch;
    Label1: TLabel;
    Label2: TLabel;
    LayoutLatitude: TLayout;
    LayoutLongitude: TLayout;
    Rectangle1: TRectangle;
    Label3: TLabel;
    btn_menu: TButton;
    btn_rota: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Switch1Click(Sender: TObject);
    procedure LocationSensor1LocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
    procedure btn_menuClick(Sender: TObject);
    procedure btn_rotaClick(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormGPS: TFormGPS;

implementation


Uses UDM, Principal, Distancia, Inicio
{$IFDEF ANDROID}
    , Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Os
{$ENDIF}
    ;
{$R *.fmx}


procedure TFormGPS.btn_menuClick(Sender: TObject);
begin
  FrmPrincipal.Show;
end;

procedure TFormGPS.btn_rotaClick(Sender: TObject);
begin
  FrmDistancia:=TFrmDistancia.Create(Application);
  FrmDistancia.Show;
end;

procedure TFormGPS.FormCreate(Sender: TObject);
begin
MapView1.MapType := TMapType.Normal;
end;


procedure TFormGPS.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);

  var
  MyMarker: TMapMarkerDescriptor;
  posicao: TMapCoordinate;
begin
  MapView1.Location := TMapCoordinate.Create(NewLocation.Latitude,
  NewLocation.Longitude);
  posicao.Latitude := NewLocation.Latitude;
  posicao.Longitude := NewLocation.Longitude;
  MyMarker := TmapMarkerDescriptor.Create(posicao, 'Estou aqui');
  MyMarker.Draggable := true;
  MyMarker.Visible := true;
  MyMarker.Snippet := 'EU';
  MapView1.AddMarker(MyMarker);
  Label1.Text := NewLocation.Latitude.ToString().Replace(',','.');
  Label2.Text := NewLocation.Longitude.ToString().Replace(',','.');
end;

procedure TFormGPS.Switch1Click(Sender: TObject);
{$IFDEF ANDROID}
var
  ApermissaoGPS: string;
{$ENDIF}
begin
{$IFDEF ANDROID}
  ApermissaoGPS := JStringToString
    (TJManifest_permission.JavaClass.ACCESS_FINE_LOCATION);

  PermissionsService.RequestPermissions([ApermissaoGPS],
    procedure(const ApermissaoGPS: TArray<string>;
      const AGrantResults: TArray<TPermissionStatus>)
    begin
      if (length(AGrantResults) = 1) and
        (AGrantResults[0] = TPermissionStatus.Granted) then
        LocationSensor1.Active := true
    else
      LocationSensor1.Active := false;

    end);
{$ENDIF}
end;

end.
