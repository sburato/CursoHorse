unit Views.Clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base.Cadastro, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.StdCtrls, Services.Clientes, Vcl.Mask, Vcl.DBCtrls;

type
  TFrmClientes = class(TFrmBaseCadastro)
    lblCodigo: TLabel;
    edtCodigo: TDBEdit;
    lblNome: TLabel;
    edtNome: TDBEdit;
    ckbStatus: TDBCheckBox;
    lblPesquisaCodigo: TLabel;
    edtPesquisaCodigo: TEdit;
    lblPesquisaNome: TLabel;
    edtPesquisaNome: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure DsCadastroStateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  protected
    procedure DoBeforeList; override;
  end;

implementation

{$R *.dfm}

procedure TFrmClientes.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TServiceClientes.Create(Self);
end;

procedure TFrmClientes.FormShow(Sender: TObject);
begin
  inherited;
  edtPesquisaCodigo.SetFocus;
end;

procedure TFrmClientes.DoBeforeList;
begin
  inherited;
  FService.Request
    .ClearParams()
    .AddParam('id', edtPesquisaCodigo.Text)
    .AddParam('nome', edtPesquisaNome.Text);
end;

procedure TFrmClientes.DsCadastroStateChange(Sender: TObject);
begin
  inherited;
  if (DsCadastro.DataSet.State in dsEditModes) then edtNome.SetFocus;
end;

end.
