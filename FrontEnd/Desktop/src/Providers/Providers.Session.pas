unit Providers.Session;

interface

uses
  Providers.Models.Token;

type
  TSession = class
  private
    FToken: TToken;
    procedure Inicializar;
  public
    destructor Destroy; override;
    class function GetInstance: TSession;
    class function NewInstance: TObject; override;
    property Token: TToken read FToken write FToken;
  end;

var
  Session: TSession;

implementation

{ TSession }

destructor TSession.Destroy;
begin
  FToken.Free;
  inherited;
end;

class function TSession.GetInstance: TSession;
begin
  Result := TSession.Create;
end;

procedure TSession.Inicializar;
begin
  FToken := TToken.Create;
end;

class function TSession.NewInstance: TObject;
begin
  if (Assigned(Session) = False) then
  begin
    Session := TSession(inherited NewInstance);
    Session.Inicializar();
  end;
  Result := Session;
end;

initialization

finalization
  if (Assigned(Session)) then
  begin
    Session.Free;
  end;
end.
