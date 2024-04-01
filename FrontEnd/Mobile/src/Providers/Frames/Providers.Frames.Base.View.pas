unit Providers.Frames.Base.View;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Providers.Frames.Base, FMX.Layouts, Providers.Session;

type
  TFrmBaseView = class(TFrmBase)
    lytContent: TLayout;
  protected
    function Session: TSession;
  public
    procedure DoAfterShow; virtual;
  end;

implementation

{$R *.fmx}

{ TFrmBaseView }

procedure TFrmBaseView.DoAfterShow;
begin
end;

function TFrmBaseView.Session: TSession;
begin
  Result := TSession.GetInstance;
end;

end.
