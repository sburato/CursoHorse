unit Views.Home;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, Providers.Frames.Base.View, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation;

type
  TFrmHome = class(TFrmBaseView)
    retContent: TRectangle;
    imgLogo: TPath;
    lblVersão: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
