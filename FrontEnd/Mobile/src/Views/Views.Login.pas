unit Views.Login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, FMX.Types, FMX.Graphics, FMX.Controls,
  FMX.Forms, FMX.Dialogs, FMX.StdCtrls, Providers.Frames.Base.View, FMX.Layouts, FMX.Objects, FMX.Effects, FMX.Edit,
  FMXLabelEdit, FMX.Controls.Presentation, Services.Login;

type
  TFrmLogin = class(TFrmBaseView)
    retContent: TRectangle;
    retLogin: TRectangle;
    sdwLogin: TShadowEffect;
    lytLogo: TLayout;
    imgLogo: TPath;
    lytBemVindo: TLayout;
    lblBemVindo: TLabel;
    lytContentLogin: TLayout;
    edtUsuario: TLabelEdit;
    btnEntrar: TButton;
    edtSenha: TLabelEdit;
    lytFooter: TLayout;
    lblSolicitarAcesso: TLabel;
    lblRecuperarSenha: TLabel;
    procedure btnEntrarClick(Sender: TObject);
  private
    FService: TServiceLogin;
    procedure GoToMenu;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  end;

implementation

{$R *.fmx}

uses
  Views.Menu, Providers.Aguarde;

{ TFrmLogin }

constructor TFrmLogin.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FService := TServiceLogin.Create(Self);
end;

destructor TFrmLogin.Destroy;
begin
  FreeAndNil(FService);
  inherited;
end;

procedure TFrmLogin.GoToMenu;
var
  LFrmMenu: TFrmMenu;
begin
  LFrmMenu := TFrmMenu.Create(Self.Owner);
  LFrmMenu.Align := TAlignLayout.Contents;
  TLayout(Self.Owner).AddObject(LFrmMenu);
end;

procedure TFrmLogin.btnEntrarClick(Sender: TObject);
begin
  inherited;
  TAguarde.Aguardar(procedure
  begin
    try

      FService.Login(edtUsuario.Text, edtSenha.Text);
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        edtUsuario.SetValue(String.Empty);
        edtSenha.SetValue(String.Empty);
        Self.GoToMenu();
      end);
    except
      on E: Exception do
      begin
        ShowMessage(E.Message);
      end;
    end;
  end);
end;

end.
