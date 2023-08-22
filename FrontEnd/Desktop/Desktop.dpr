program Desktop;

uses
  Vcl.Forms,
  Views.Principal in 'src\Views\Views.Principal.pas' {frmPrincipal},
  Views.Login in 'src\Views\Views.Login.pas' {frmLogin},
  Services.Login in 'src\Services\Services.Login.pas' {ServiceLogin: TDataModule},
  Providers.Session in 'src\Providers\Providers.Session.pas',
  Providers.Models.Token in 'src\Providers\Models\Providers.Models.Token.pas',
  Views.Base in 'src\Views\Views.Base.pas' {FrmBase},
  Views.Base.Cadastro in 'src\Views\Views.Base.Cadastro.pas' {FrmBaseCadastro},
  Services.Base in 'src\Services\Services.Base.pas' {ServiceBase: TDataModule},
  Services.Base.Cadastro in 'src\Services\Services.Base.Cadastro.pas' {ServiceBaseCadastro: TDataModule},
  Views.Clientes in 'src\Views\Views.Clientes.pas' {FrmClientes},
  Services.Clientes in 'src\Services\Services.Clientes.pas' {ServiceClientes: TDataModule},
  Services.Produtos in 'src\Services\Services.Produtos.pas' {ServiceProdutos: TDataModule},
  Views.Produtos in 'src\Views\Views.Produtos.pas' {FrmProdutos},
  Services.Usuarios in 'src\Services\Services.Usuarios.pas' {ServiceUsuarios: TDataModule},
  Views.Usuarios in 'src\Views\Views.Usuarios.pas' {frmUsuarios};

{$R *.res}

var
  FrmPrincipal: TfrmPrincipal;
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
