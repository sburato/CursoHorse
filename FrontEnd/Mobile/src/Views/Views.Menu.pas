unit Views.Menu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, FMX.Types, FMX.Graphics, FMX.Controls,
  FMX.Forms, FMX.Dialogs, FMX.StdCtrls, Providers.Frames.Base.View, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation,
  FMX.MultiView;

type
  TFrmMenu = class(TFrmBaseView)
    retHeader: TRectangle;
    imgVoltar: TButton;
    imgMenu: TPath;
    lytActiveForm: TLayout;
    MultiView: TMultiView;
    retContentMultiView: TRectangle;
    btnHome: TButton;
    imgHome: TPath;
    lblHome: TLabel;
    btnPedido: TButton;
    imgPedido: TPath;
    lblPedido: TLabel;
    btnPerfil: TButton;
    imgPerfil: TPath;
    lblPerfil: TLabel;
    LineSeparator: TLine;
    btnLogout: TButton;
    imgLogout: TPath;
    lblLogout: TLabel;
    procedure btnHomeClick(Sender: TObject);
    procedure btnPerfilClick(Sender: TObject);
    procedure btnPedidoClick(Sender: TObject);
  private
    FActiveFrame: TFrmBaseView;
    procedure GoHome;
    procedure ChangeFrame<T: TFrmBaseView>;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  end;

implementation

{$R *.fmx}

uses
  Views.Home, Views.Perfil, Views.Pedido;

{ TFrmMenu }

constructor TFrmMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FActiveFrame := nil;
  Self.GoHome();
end;

destructor TFrmMenu.Destroy;
begin
  if (FActiveFrame <> nil) then
  begin
    lytActiveForm.RemoveObject(FActiveFrame);
    FActiveFrame.DisposeOf;
  end;
  inherited;
end;

procedure TFrmMenu.GoHome;
begin
  Self.ChangeFrame<TFrmHome>;
end;

procedure TFrmMenu.ChangeFrame<T>;
begin
  if (FActiveFrame <> nil) then
  begin
    lytActiveForm.RemoveObject(FActiveFrame);
    FActiveFrame.DisposeOf;
  end;

  FActiveFrame := T.Create(lytActiveForm);
  FActiveFrame.Align := TAlignLayout.Contents;
  lytActiveForm.AddObject(FActiveFrame);
  FActiveFrame.DoAfterShow();

  if (MultiView.IsShowed) then
  begin
    MultiView.HideMaster;
  end;
end;

procedure TFrmMenu.btnHomeClick(Sender: TObject);
begin
  inherited;
  Self.ChangeFrame<TFrmHome>();
end;

procedure TFrmMenu.btnPedidoClick(Sender: TObject);
begin
  inherited;
  Self.ChangeFrame<TFrmPedido>();
end;

procedure TFrmMenu.btnPerfilClick(Sender: TObject);
begin
  inherited;
  Self.ChangeFrame<TFrmPerfil>();
end;

end.
