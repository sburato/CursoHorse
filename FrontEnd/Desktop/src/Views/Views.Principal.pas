unit Views.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, dxGDIPlusClasses, System.Actions, Vcl.ActnList,
  Vcl.ImgList, Vcl.CategoryButtons, Views.Clientes, Views.Produtos, Views.Usuarios;

type
  TfrmPrincipal = class(TForm)
    pnlToolbar: TPanel;
    imgMenu: TImage;
    lblTitle: TLabel;
    pnlContent: TPanel;
    pnlMenu: TPanel;
    ImageList: TImageList;
    ActionList: TActionList;
    actHome: TAction;
    actClientes: TAction;
    actProdutos: TAction;
    actUsuarios: TAction;
    CategoryButtons: TCategoryButtons;
    procedure FormCreate(Sender: TObject);
    procedure imgMenuClick(Sender: TObject);
    procedure actHomeExecute(Sender: TObject);
    procedure actClientesExecute(Sender: TObject);
    procedure actProdutosExecute(Sender: TObject);
    procedure actUsuariosExecute(Sender: TObject);
  private
    FActiveForm: TForm;
    procedure Login;
    procedure ShowForm(AFormClass: TComponentClass; var AForm);
  end;

implementation

{$R *.dfm}

uses
  Views.Login;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  Self.Login();
end;

procedure TfrmPrincipal.ShowForm(AFormClass: TComponentClass; var AForm);
begin
  if Assigned(FActiveForm) then
  begin
    FActiveForm.Close;
  end;
  Application.CreateForm(AFormClass, AForm);
  TForm(AForm).Parent := pnlContent;
  TForm(AForm).Align := TAlign.alClient;
  TForm(AForm).WindowState := TWindowState.wsMaximized;
  TForm(AForm).Show;
  FActiveForm := TForm(AForm);
end;

procedure TfrmPrincipal.imgMenuClick(Sender: TObject);
const
  TAMANHO_MENU_ABERTO  = 200;
  TAMANHO_MENU_FECHADO = 48;
begin
  if (pnlMenu.Width = TAMANHO_MENU_ABERTO) then
  begin
    pnlMenu.Width := TAMANHO_MENU_FECHADO;
    CategoryButtons.ButtonOptions := CategoryButtons.ButtonOptions - [boShowCaptions];
  end
  else
  begin
    pnlMenu.Width := TAMANHO_MENU_ABERTO;
    CategoryButtons.ButtonOptions := CategoryButtons.ButtonOptions + [boShowCaptions];
  end;
end;

procedure TfrmPrincipal.Login;
var
  LForm: TfrmLogin;
begin
  LForm := TfrmLogin.Create(Self);
  try
    if (LForm.ShowModal <> mrOk) then
    begin
      Application.Terminate;
    end;
  finally
    LForm.Free;
  end;
end;

procedure TfrmPrincipal.actClientesExecute(Sender: TObject);
var
  LForm: TFrmClientes;
begin
  ShowForm(TFrmClientes, LForm);
end;

procedure TfrmPrincipal.actHomeExecute(Sender: TObject);
begin
  ShowMessage('Home');
end;

procedure TfrmPrincipal.actProdutosExecute(Sender: TObject);
var
  LForm: TFrmProdutos;
begin
  ShowForm(TFrmProdutos, LForm);
end;

procedure TfrmPrincipal.actUsuariosExecute(Sender: TObject);
var
  LForm: TfrmUsuarios;
begin
  ShowForm(TfrmUsuarios, LForm);
end;

end.
