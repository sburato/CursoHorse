unit Services.Base;

interface

uses
  System.SysUtils, System.Classes, Providers.Session;

type
  TServicesBase = class(TDataModule)
  public
    function Session: TSession;
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TServicesBase }

function TServicesBase.Session: TSession;
begin
  Result := TSession.GetInstance;
end;

end.
