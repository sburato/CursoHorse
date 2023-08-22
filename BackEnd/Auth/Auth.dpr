program Auth;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  System.SysUtils,
  Horse.HandleException,
  Controllers.Auth in 'src\Controllers\Controllers.Auth.pas',
  Services.Auth in 'src\Services\Services.Auth.pas' {ServiceAuth: TDataModule},
  Providers.Connection in 'src\Providers\Providers.Connection.pas' {ProvidersConnection: TDataModule};

procedure OnListen;
begin
  Writeln(String.Format('O servidor Horse está no ar na porta %d.', [THorse.Port]));
end;

begin
  THorse
    .Use(Jhonson())
    .Use(HandleException);

  Controllers.Auth.Registry();

  THorse.Listen(9001, OnListen);
end.
