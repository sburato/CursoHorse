unit Services.Login;

interface

uses
  System.SysUtils, System.Classes;

type
  TServiceLogin = class(TDataModule)
  public
    procedure Login(AUsername, APassword: String);
  end;

implementation

uses
  System.JSON, RestRequest4D, Providers.Session;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TServiceLogin }

procedure TServiceLogin.Login(AUsername, APassword: String);
var
  LJSON    : TJSONObject;
  LResponse: IResponse;
begin
  if ((AUsername.Trim = String.Empty) or (APassword.Trim = String.Empty)) then
  begin
    raise Exception.Create('Informe o usuário e senha.');
  end;

  LJSON := TJSONObject.Create;
  LJSON.AddPair('username', AUsername);
  LJSON.AddPair('password', APassword);

  LResponse := TRequest.New
    .BaseURL('http://localhost:9001')
    .Resource('login')
    .AddBody(LJSON)
    .Post;

  if (LResponse.StatusCode <> 200) then
  begin
    raise Exception.Create(LResponse.JSONValue.GetValue<String>('error'));
  end;

  TSession.GetInstance.Token.Access  := LResponse.JSONValue.GetValue<String>('access');
  TSession.GetInstance.Token.Refresh := LResponse.JSONValue.GetValue<String>('refresh');
end;

end.
