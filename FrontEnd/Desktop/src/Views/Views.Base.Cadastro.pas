unit Views.Base.Cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Views.Base, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Data.DB, Services.Base.Cadastro;

type
  TFrmBaseCadastro = class(TFrmBase)
    pnlHeader: TPanel;
    lblTitle: TLabel;
    PageControl: TPageControl;
    tshVisualizar: TTabSheet;
    tshCadastro: TTabSheet;
    pnlVisualizar: TPanel;
    pnlBotoes: TPanel;
    Panel2: TPanel;
    btnPesquisar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnIncluir: TSpeedButton;
    pnlFooter: TPanel;
    pnlFiltros: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    DsPesquisa: TDataSource;
    DBGrid: TDBGrid;
    pnlCadastro: TPanel;
    pnlFooterCadastro: TPanel;
    btnConfirmar: TSpeedButton;
    btnCancelar: TSpeedButton;
    DsCadastro: TDataSource;
    btnPrimeiro: TSpeedButton;
    btnAnterior: TSpeedButton;
    btnUltimo: TSpeedButton;
    btnProximo: TSpeedButton;
    lblPagina: TLabel;
    pnlRegistros: TPanel;
    cmbRegistros: TComboBox;
    lblRegistros: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure DsCadastroStateChange(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGridDblClick(Sender: TObject);
    procedure btnPrimeiroClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnUltimoClick(Sender: TObject);
    procedure cmbRegistrosChange(Sender: TObject);
  private
    procedure ListarRegistros;
    procedure CalcularPaginacao;
    function GetPageLimit: Integer;
  protected
    FService: TServiceBaseCadastro;
    procedure DoBeforeList; virtual;
  end;

implementation

{$R *.dfm}

procedure TFrmBaseCadastro.FormDestroy(Sender: TObject);
begin
  if Assigned(FService) then FService.Free;
  inherited;
end;

procedure TFrmBaseCadastro.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_INSERT: if (tshVisualizar.Visible) then btnIncluir.Click;
    VK_DELETE: if (tshVisualizar.Visible) then btnExcluir.Click;
    VK_F3: if (tshVisualizar.Visible) then btnAlterar.Click;
    VK_F5: if (tshVisualizar.Visible) then btnPesquisar.Click;
    VK_F2: if (tshCadastro.Visible) then btnConfirmar.Click;
    VK_F4: if (tshCadastro.Visible) then btnCancelar.Click;
  end;
end;

procedure TFrmBaseCadastro.FormShow(Sender: TObject);
begin
  inherited;
  DsPesquisa.DataSet := FService.mtPesquisa;
  DsCadastro.DataSet := FService.mtCadastro;
  tshVisualizar.Show;
end;

procedure TFrmBaseCadastro.btnAlterarClick(Sender: TObject);
begin
  inherited;
  FService.Alterar();
end;

procedure TFrmBaseCadastro.btnAnteriorClick(Sender: TObject);
begin
  inherited;
  if (FService.Page = 1) then Exit;
  FService.Page := FService.Page - 1;
  Self.ListarRegistros();
end;

procedure TFrmBaseCadastro.btnCancelarClick(Sender: TObject);
begin
  inherited;
  DsCadastro.DataSet.Cancel;
end;

procedure TFrmBaseCadastro.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  pnlFooterCadastro.SetFocus;
  FService.Salvar();
end;

procedure TFrmBaseCadastro.btnExcluirClick(Sender: TObject);
begin
  inherited;
  FService.Excluir;
end;

procedure TFrmBaseCadastro.btnIncluirClick(Sender: TObject);
begin
  inherited;
  FService.Incluir();
end;

procedure TFrmBaseCadastro.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  Self.ListarRegistros();
end;

procedure TFrmBaseCadastro.btnPrimeiroClick(Sender: TObject);
begin
  inherited;
  if (FService.Page = 1) then Exit;
  FService.Page := 1;
  Self.ListarRegistros();
end;

procedure TFrmBaseCadastro.btnProximoClick(Sender: TObject);
begin
  inherited;
  if (FService.Page = FService.Pages) then Exit;
  FService.Page := FService.Page + 1;
  Self.ListarRegistros();
end;

procedure TFrmBaseCadastro.btnUltimoClick(Sender: TObject);
begin
  inherited;
  if (FService.Page = FService.Pages) then Exit;
  FService.Page := FService.Pages;
  Self.ListarRegistros();
end;

procedure TFrmBaseCadastro.DsCadastroStateChange(Sender: TObject);
begin
  inherited;
  if (DsCadastro.DataSet.State in dsEditModes) then tshCadastro.Show else tshVisualizar.Show;
end;

procedure TFrmBaseCadastro.DBGridDblClick(Sender: TObject);
begin
  inherited;
  btnAlterar.Click;
end;

procedure TFrmBaseCadastro.DoBeforeList;
begin
end;

function TFrmBaseCadastro.GetPageLimit: Integer;
begin
  Result := StrToIntDef(cmbRegistros.Text, 50);
end;

procedure TFrmBaseCadastro.ListarRegistros;
begin
  Self.DoBeforeList();
  FService.ListarRegistros();
  Self.CalcularPaginacao();
  lblPagina.Caption := String.Format('Página %d de %d', [FService.Page, FService.Pages]);
end;

procedure TFrmBaseCadastro.CalcularPaginacao;
var
  LTotalPaginas: Double;
begin
  if (FService.Page <= 0) then
  begin
    FService.Page := 1;
  end;
  LTotalPaginas  := FService.Records / Self.GetPageLimit();
  FService.Pages := Trunc(LTotalPaginas);
  if ((LTotalPaginas - FService.Pages > 0) or (FService.Pages = 0)) then
  begin
    FService.Pages := FService.Pages + 1;
  end;
end;

procedure TFrmBaseCadastro.cmbRegistrosChange(Sender: TObject);
begin
  inherited;
  FService.PageLimit := Self.GetPageLimit();
  FService.Page := 1;
  Self.ListarRegistros();
end;

end.

