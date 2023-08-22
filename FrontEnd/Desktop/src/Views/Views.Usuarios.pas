unit Views.Usuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Views.Base.Cadastro, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.ComCtrls, Services.Usuarios, Vcl.DBCtrls, Vcl.Mask;

type
  TfrmUsuarios = class(TFrmBaseCadastro)
    lblPesquisaNome: TLabel;
    edtPesquisaNome: TEdit;
    lblPesquisaCodigo: TLabel;
    edtPesquisaCodigo: TEdit;
    lblCodigo: TLabel;
    lblNome: TLabel;
    edtCodigo: TDBEdit;
    edtNome: TDBEdit;
    ckbStatus: TDBCheckBox;
    lblLogin: TLabel;
    dbtLogin: TDBEdit;
    lblSenha: TLabel;
    edtSenha: TDBEdit;
    lblTelefone: TLabel;
    edtTelefone: TDBEdit;
    cmbSexo: TComboBox;
    lblSexo: TLabel;
    procedure DsCadastroStateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  protected
    procedure DoBeforeList; override;
  end;

implementation

{$R *.dfm}

{ TfrmUsuarios }

procedure TfrmUsuarios.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TServiceUsuarios.Create(Self);
end;

procedure TfrmUsuarios.FormShow(Sender: TObject);
begin
  inherited;
  edtPesquisaCodigo.SetFocus;
end;

procedure TfrmUsuarios.DoBeforeList;
begin
  inherited;
  FService.Request
    .ClearParams()
    .AddParam('id', edtPesquisaCodigo.Text)
    .AddParam('nome', edtPesquisaNome.Text);
end;

procedure TfrmUsuarios.DsCadastroStateChange(Sender: TObject);
begin
  inherited;
  if (DsCadastro.DataSet.State in dsEditModes) then
  begin
    cmbSexo.ItemIndex := TServiceUsuarios(FService).mtCadastroSEXO.AsInteger;
    edtNome.SetFocus;
  end;
end;

procedure TfrmUsuarios.btnConfirmarClick(Sender: TObject);
begin
  if (DsCadastro.DataSet.State in dsEditModes) then
  begin
    TServiceUsuarios(FService).mtCadastroSEXO.AsInteger := cmbSexo.ItemIndex;
  end;
  inherited;
end;

end.
