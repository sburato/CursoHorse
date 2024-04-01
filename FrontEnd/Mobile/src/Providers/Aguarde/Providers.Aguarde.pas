unit Providers.Aguarde;

interface

uses
  System.SysUtils, System.Classes, FMX.Forms;

type
  TAguarde = class
  public
    class procedure Aguardar(AProc: TProc);
  end;

implementation

{ TAguarde }

uses
  FMX.Types, Providers.Aguarde.Frame;

class procedure TAguarde.Aguardar(AProc: TProc);
var
  LFrame: TFrameAguarde;
begin
  LFrame        := TFrameAguarde.Create(Screen.ActiveForm);
  LFrame.Align  := TAlignLayout.Client;
  LFrame.Parent := Screen.ActiveForm;
  Screen.ActiveForm.AddObject(LFrame);
  LFrame.BringToFront;

  TThread.CreateAnonymousThread(procedure
  begin
    try
      AProc;
    finally
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        LFrame.Owner.RemoveComponent(LFrame);
        LFrame.DisposeOf;
      end);
    end;
  end).Start;
end;

end.
