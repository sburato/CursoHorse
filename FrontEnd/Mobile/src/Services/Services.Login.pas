unit Services.Login;

interface

uses
  System.SysUtils, System.Classes, Services.Base;

type
  TServiceLogin = class(TServicesBase)
  public
    procedure Login(const AUsername, APassword: String);
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses
  System.JSON, Providers.Request, Providers.Session;

{$R *.dfm}

{ TServiceLogin }

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
end;

end.
