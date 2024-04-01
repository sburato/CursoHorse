unit Providers.Frames.Pedido;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, FMX.Types, FMX.Graphics, FMX.Controls,
  FMX.Forms, FMX.Dialogs, FMX.StdCtrls, Providers.Frames.Base, FMX.Controls.Presentation, FMX.Objects, FMX.Layouts;

type
  TFramePedido = class(TFrmBase)
    retDadosValores: TRectangle;
    retDadosPedidos: TRectangle;
    retDadosCliente: TRectangle;
    imgLogo: TPath;
    lytVenda: TLayout;
    lblNumero: TLabel;
    txtNumero: TLabel;
    btnEditar: TButton;
    imgEditar: TPath;
    btnExcluir: TButton;
    imgExcluir: TPath;
    lytCliente: TLayout;
    imgCliente: TPath;
    txtNomeCliente: TLabel;
    lytDataVenda: TLayout;
    imgDataVenda: TPath;
    txtDataVenda: TLabel;
    lytDinheiro: TLayout;
    imgDinheiro: TPath;
    txtValorVenda: TLabel;
    LineSeparator: TLine;
  end;

implementation

{$R *.fmx}

end.
