unit Views.Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, dxGDIPlusClasses, Services.Login;

type
  TfrmLogin = class(TForm)
    pnlBackground: TPanel;
    imgLogo: TImage;
    lblUsuario: TLabel;
    edtUsuario: TEdit;
    lblSenha: TLabel;
    edtSenha: TEdit;
    btnEntrar: TButton;
    btnCancelar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnEntrarClick(Sender: TObject);
  private
    FService: TServiceLogin;
  end;

implementation

{$R *.dfm}

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  FService := TServiceLogin.Create(Self);
end;

procedure TfrmLogin.FormDestroy(Sender: TObject);
begin
  FService.Free;
end;

procedure TfrmLogin.btnEntrarClick(Sender: TObject);
begin
  FService.Login(edtUsuario.Text, edtSenha.Text);
  Close;
  ModalResult := mrOk;
end;

end.
