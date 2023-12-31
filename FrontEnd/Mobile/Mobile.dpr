program Mobile;

uses
  System.StartUpCopy,
  FMX.Forms,
  Views.Principal in 'src\Views\Views.Principal.pas' {FrmPrincipal},
  Providers.Session in 'src\Providers\Providers.Session.pas',
  Providers.Models.Token in 'src\Providers\models\Providers.Models.Token.pas',
  Providers.Request.Intf in 'src\Providers\request\Providers.Request.Intf.pas',
  Providers.Request in 'src\Providers\request\Providers.Request.pas',
  Providers.Frames.Base in 'src\Providers\Frames\Providers.Frames.Base.pas' {FrmBase: TFrame},
  Providers.Frames.Base.View in 'src\Providers\Frames\Providers.Frames.Base.View.pas' {FrmBaseView: TFrame},
  Views.Login in 'src\Views\Views.Login.pas' {FrmLogin: TFrame},
  Services.Base in 'src\Services\Services.Base.pas' {ServicesBase: TDataModule},
  Services.Login in 'src\Services\Services.Login.pas' {ServiceLogin: TDataModule},
  Providers.Constants in 'src\Providers\Providers.Constants.pas',
  Views.Menu in 'src\Views\Views.Menu.pas' {FrmMenu: TFrame},
  Views.Home in 'src\Views\Views.Home.pas' {FrmHome: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
