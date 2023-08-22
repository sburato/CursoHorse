unit Views.Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TFrmBase = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  end;

var
  FrmBase: TFrmBase;

implementation

{$R *.dfm}

procedure TFrmBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
