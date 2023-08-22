unit Services.Auth;

interface

uses
  System.SysUtils, System.Classes, Providers.Connection, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TServiceAuth = class(TProvidersConnection)
    QryLogin: TFDQuery;
    QryLoginID: TLargeintField;
    QryLoginSENHA: TStringField;
  public
    function PermitirAcesso(AUsuario, ASenha: String): Boolean;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TServiceAuth }

uses
  BCrypt;

function TServiceAuth.PermitirAcesso(AUsuario, ASenha: String): Boolean;
begin
  QryLogin.ParamByName('login').AsString := AUsuario;
  QryLogin.Open;
  if (QryLogin.IsEmpty) then
  begin
    Exit(False);
  end;
  Result := TBCrypt.CompareHash(ASenha, QryLoginSENHA.AsString);
end;

end.
