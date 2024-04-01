unit Services.Login;

interface

uses
  System.SysUtils, System.Classes, Services.Base;

type
  TServiceLogin = class(TServicesBase)
  private
    procedure CarregarDadosUsuario(const AUsername: String);
  public
    procedure Login(const AUsername, APassword: String);
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses
  System.JSON, Providers.Request, Providers.Session, System.Generics.Collections;

{$R *.dfm}

{ TServiceLogin }

procedure TServiceLogin.CarregarDadosUsuario(const AUsername: String);
var
  LUser    : TJSONObject;
  LResponse: IResponse;
begin
  LResponse := TRequest.New
    .BaseURL('http://localhost:9000')
    .Resource('usuarios')
    .AddParam('login', AUsername)
    .Get;

  if (LResponse.StatusCode <> 200) then
  begin
    raise Exception.Create(LResponse.JSONValue.GetValue<String>('error'));
  end;

  LUser := TJSONObject(LResponse.JSONValue.GetValue<TJSONArray>('data').Items[0]);

  TSession.GetInstance.User.Id       := LUser.GetValue<Integer>('id');
  TSession.GetInstance.User.Nome     := LUser.GetValue<String>('nome');
  TSession.GetInstance.User.Login    := LUser.GetValue<String>('login');
  TSession.GetInstance.User.Telefone := LUser.GetValue<String>('telefone');
  TSession.GetInstance.User.Sexo     := LUser.GetValue<Integer>('id');
end;

procedure TServiceLogin.Login(const AUsername, APassword: String);
var
  LUsuario : TJSONObject;
  LResponse: IResponse;
begin
  if ((AUsername.Trim.IsEmpty) or (APassword.Trim.IsEmpty)) then
  begin
    raise Exception.Create('Informe o usuário e senha.');
  end;

  LUsuario := TJSONObject.Create;
  LUsuario.AddPair('username', AUsername);
  LUsuario.AddPair('password', APassword);

  LResponse := TRequest.New
    .BaseURL('http://localhost:9001')
    .Resource('login')
    .AddBody(LUsuario)
    .Post;

  if (LResponse.StatusCode <> 200) then
  begin
    raise Exception.Create(LResponse.JSONValue.GetValue<String>('error'));
  end;

  TSession.GetInstance.Token.Access  := LResponse.JSONValue.GetValue<String>('access');
  TSession.GetInstance.Token.Refresh := LResponse.JSONValue.GetValue<String>('refresh');

  Self.CarregarDadosUsuario(AUsername);
end;

end.
