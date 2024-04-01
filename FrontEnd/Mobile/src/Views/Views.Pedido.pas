unit Views.Pedido;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, FMX.Types, FMX.Graphics, FMX.Controls,
  FMX.Forms, FMX.Dialogs, FMX.StdCtrls, Providers.Frames.Base.View, FMX.Layouts, FMX.TabControl, FMX.Objects,
  FMX.Controls.Presentation, Data.DB, Services.Pedido, FMX.Ani;

type
  TFrmPedido = class(TFrmBaseView)
    retContent: TRectangle;
    tabControlPedido: TTabControl;
    tabConsulta: TTabItem;
    tabCadastro: TTabItem;
    retContentCadastro: TRectangle;
    retContentConsulta: TRectangle;
    btnAdicionarVenda: TButton;
    imgAdicionarVenda: TPath;
    vsbPedidos: TVertScrollBox;
    lytNenhumaVenda: TLayout;
    txtNenhumaVenda: TLabel;
    imgLogo: TPath;
    retHeaderCadastro: TRectangle;
    btnVoltar: TButton;
    imgVoltar: TPath;
    btnAdicionarProduto: TButton;
    imgAdicionarProduto: TPath;
    LineSeparator: TLine;
    lytContentCliente: TLayout;
    lytBuscaCliente: TLayout;
    lytCliente: TLayout;
    lblCliente: TLabel;
    txtNomeCliente: TLabel;
    btnBuscaCliente: TButton;
    imgBuscaCliente: TPath;
    vsbProdutos: TVertScrollBox;
    lytTotalVenda: TLayout;
    txtTotalVenda: TLabel;
    btnConfirmar: TButton;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    FloatKeyAnimation1: TFloatKeyAnimation;
    procedure btnAdicionarVendaClick(Sender: TObject);
  private
    FService: TServicesPedido;
    procedure DesingPedidos;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DoAfterShow; override;
    destructor Destroy; override;
  end;

implementation

{$R *.fmx}

uses Providers.Frames.Pedido, Providers.Aguarde;

{ TFrmPedido }

procedure TFrmPedido.btnAdicionarVendaClick(Sender: TObject);
begin
  inherited;
  tabControlPedido.Next();
end;

constructor TFrmPedido.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FService := TServicesPedido.Create(Self);
end;

destructor TFrmPedido.Destroy;
begin
  FService.Free;
  inherited;
end;

procedure TFrmPedido.DesingPedidos;
var
  I: Integer;
  LFramePedido: TFramePedido;
begin
  lytNenhumaVenda.Visible := FService.mtPedidos.IsEmpty;
  vsbPedidos.Visible      := FService.mtPedidos.IsEmpty = False;

  if (FService.mtPedidos.IsEmpty) then
  begin
    Exit;
  end;

  vsbPedidos.BeginUpdate;
  try
    for I := Pred(vsbPedidos.Content.ControlsCount) downto 0 do
    begin
      vsbPedidos.Controls.Items[I].DisposeOf;
    end;

    FService.mtPedidos.First;
    while (FService.mtPedidos.Eof = False) do
    begin
      LFramePedido := TFramePedido.Create(vsbPedidos);
      LFramePedido.Align := TAlignLayout.Top;
      LFramePedido.txtNumero.Text := FService.mtPedidosID.AsString;
      LFramePedido.txtDataVenda.Text := FormatDateTime('dd/mm/yyyy', FService.mtPedidosDATA.AsDateTime);
//      LFramePedido.txtValorVenda.Text  := FormatFloat('R$ ,0.00;', FService.mtPedidosID.AsFloat);
      LFramePedido.txtNomeCliente.Text := FService.mtPedidosNOME_CLIENTE.AsString;
      LFramePedido.Name := LFramePedido.ClassName + FService.mtPedidosid.AsString;
      LFramePedido.Parent := vsbPedidos;
      FService.mtPedidos.Next;
    end;
  finally
    vsbPedidos.EndUpdate;
  end;
end;

procedure TFrmPedido.DoAfterShow;
begin
  inherited;
  tabControlPedido.ActiveTab := tabConsulta;
  TAguarde.Aguardar(procedure
  begin
    FService.ListarPedidosUsuario();
    TThread.Synchronize(TThread.CurrentThread, procedure
    begin
      Self.DesingPedidos();
    end);
  end);
end;

end.
