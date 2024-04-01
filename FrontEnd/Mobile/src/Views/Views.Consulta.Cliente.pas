unit Views.Consulta.Cliente;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, Providers.Frames.Base.View, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMX.Effects, Services.Consulta.Cliente;

type
  TFrmConsultaCliente = class(TFrmBaseView)
    retHeader: TRectangle;
    btnVoltar: TButton;
    imgVoltar: TPath;
    btnBuscaCliente: TButton;
    imgBuscaCliente: TPath;
    edtPesquisar: TEdit;
    ShadowEffect: TShadowEffect;
    retContent: TRectangle;
    lytBuscaVazia: TLayout;
    txtBuscaVazia: TLabel;
    imgBuscaVazia: TPath;
    vsbClientes: TVertScrollBox;
    procedure imgBuscaClienteClick(Sender: TObject);
  private
    FService: TServiceConsultaCliente;
    procedure DesignClientes;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  end;

implementation

{$R *.fmx}

uses
  Data.DB, Providers.Aguarde;

{ TFrmConsultaCliente }

constructor TFrmConsultaCliente.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FService := TServiceConsultaCliente.Create(Self)
end;

destructor TFrmConsultaCliente.Destroy;
begin
  FService.Free;
  inherited;
end;

procedure TFrmConsultaCliente.imgBuscaClienteClick(Sender: TObject);
begin
  inherited;
  TAguarde.Aguardar(procedure
  begin
    FService.ListarClientes(edtPesquisar.Text);
    TThread.Synchronize(TThread.CurrentThread, procedure
    begin
      Self.DesignClientes();
    end);
  end);

end;

procedure TFrmConsultaCliente.DesignClientes;
var
  I: Integer;
begin
  lytBuscaVazia.Visible := FService.mtClientes.IsEmpty;
  vsbClientes.Visible   := FService.mtClientes.IsEmpty = False;

  if (FService.mtClientes.IsEmpty) then
  begin
    Exit;
  end;

  vsbClientes.BeginUpdate;
  try
    for I := Pred(vsbClientes.Content.ControlsCount) downto 0 do
    begin
      vsbClientes.Controls.Items[I].DisposeOf;
    end;

    FService.mtClientes.First;
    while (FService.mtClientes.Eof) do
    begin

      Module 15 (Mobile parte 3) aula 6

      FService.mtClientes.Next;
    end;
  finally
    vsbClientes.EndUpdate;
  end;
end;

end.
