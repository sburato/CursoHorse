program PBusiness;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.JWT,
  Horse.CORS,
  Horse.Logger,
  Horse.Jhonson,
  Horse.OctetStream,
  Horse.HandleException,
  Horse.Logger.Provider.Console,
  Controllers.Pedido in 'src\Controllers\Controllers.Pedido.pas',
  Controllers.Cliente in 'src\Controllers\Controllers.Cliente.pas',
  Controllers.Produto in 'src\Controllers\Controllers.Produto.pas',
  Controllers.Usuario in 'src\Controllers\Controllers.Usuario.pas',
  Controllers.PedidoItem in 'src\Controllers\Controllers.PedidoItem.pas',
  Services.Pedido in 'src\Services\Services.Pedido.pas' {ServicePedido: TDataModule},
  Services.Produto in 'src\Services\Services.Produto.pas' {ServiceProduto: TDataModule},
  Services.Cliente in 'src\Services\Services.Cliente.pas' {ServiceCliente: TDataModule},
  Services.Usuario in 'src\Services\Services.Usuario.pas' {ServiceUsuario: TDataModule},
  Providers.Cadastro in 'src\Providers\Providers.Cadastro.pas' {ProvidersCadastro: TDataModule},
  Services.PedidoItem in 'src\Services\Services.PedidoItem.pas' {ServicePedidoItem: TDataModule},
  Providers.Connection in 'src\Providers\Providers.Connection.pas' {ProvidersConnection: TDataModule};

begin
  THorseLoggerManager.RegisterProvider(THorseLoggerProviderConsole.New());

  THorse
    .Use(CORS)
    .Use(Jhonson())
    .Use(HandleException)
    .Use(OctetStream)
    .Use(HorseJWT('curso-rest-horse'))
    .Use(THorseLoggerManager.HorseCallback());

  Controllers.Produto.Registry();
  Controllers.Cliente.Registry();
  Controllers.Pedido.Registry();
  Controllers.PedidoItem.Registry();
  Controllers.Usuario.Registry();

  THorse.Listen(9000,
    procedure
    begin
      Writeln('O servidor Horse está no ar na porta 9000.');
    end);
end.
