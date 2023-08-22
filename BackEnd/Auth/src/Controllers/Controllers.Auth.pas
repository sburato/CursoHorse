unit Controllers.Auth;

interface

procedure Registry;

implementation

uses
  System.SysUtils, System.DateUtils, System.JSON, Horse, Horse.JWT, JOSE.Core.JWT, JOSE.Core.Builder, Services.Auth;

const
  CHAVE = 'curso-rest-horse';

function GetToken(AUsuarioId: String; AExperition: TDateTime): String;
var
  LJWT: TJWT;
begin
  LJWT := TJWT.Create;
  try
    LJWT.Claims.IssuedAt   := Now;
    LJWT.Claims.Expiration := AExperition;
    LJWT.Claims.Subject    := AUsuarioId;
    Result := TJOSE.SHA256CompactToken(CHAVE, LJWT);
  finally
    LJWT.Free;
  end;
end;

procedure EfetuarLogin(Req: THorseRequest; Res: THorseResponse);
var
  LToken   : TJSONObject;
  LSenha   : String;
  LUsuario : String;
  LService : TServiceAuth;
  LConteudo: TJSONObject;
begin
  LConteudo := Req.Body<TJSONObject>;
  if (Assigned(LConteudo) = False) then
  begin
    raise EHorseException.New.Error('Usuário e senha não informados.').Status(THTTPStatus.BadRequest);
  end;
  LUsuario := LConteudo.GetValue('username', String.Empty);
  LSenha   := LConteudo.GetValue('password', String.Empty);
  if (LUsuario = String.Empty) then
  begin
    raise EHorseException.New.Error('Usuário não informado.').Status(THTTPStatus.BadRequest);
  end;
  if (LSenha = String.Empty) then
  begin
    raise EHorseException.New.Error('Senha não informada.').Status(THTTPStatus.BadRequest);
  end;
  LService := TServiceAuth.Create(nil);
  try
    if (LService.PermitirAcesso(LUsuario, LSenha) = False) then
    begin
      raise EHorseException.New.Error('Usuário não autorizado').Status(THTTPStatus.Unauthorized);
    end;
    LToken := TJSONObject.Create;
    LToken.AddPair('access', GetToken(LService.QryLoginID.AsString, IncHour(Now)));
    LToken.AddPair('refresh', GetToken(LService.QryLoginID.AsString, IncMonth(Now)));
    Res.Send(LToken);
  finally
    LService.Free;
  end;
end;

procedure RenovarToken(Req: THorseRequest; Res: THorseResponse);
var
  LSub  : String;
  LToken: String;
begin
  LSub   := Req.Session<TJSONObject>.GetValue('sub').Value;
  LToken := GetToken(LSub, IncHour(Now));
  Res.Send(TJSONObject.Create(TJSONPair.Create('acess', LToken)));
end;

procedure Registry;
begin
  THorse
    .Post('/login',  EfetuarLogin)
    .AddCallback(HorseJWT(CHAVE)).Get('/refresh', RenovarToken);
end;

end.
