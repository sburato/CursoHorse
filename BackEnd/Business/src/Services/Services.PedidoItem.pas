unit Services.PedidoItem;

interface

uses
  System.SysUtils, System.Classes, Providers.Cadastro, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase, System.JSON,
  System.Generics.Collections;

type
  TServicePedidoItem = class(TProvidersCadastro)
    QryPesquisaID: TLargeintField;
    QryPesquisaID_PRODUTO: TLargeintField;
    QryPesquisaQUANTIDADE: TBCDField;
    QryPesquisaVALOR: TBCDField;
    QryPesquisaNOME_PRODUTO: TStringField;
    QryCadastroID: TLargeintField;
    QryCadastroID_PEDIDO: TLargeintField;
    QryCadastroID_PRODUTO: TLargeintField;
    QryCadastroQUANTIDADE: TBCDField;
    QryCadastroVALOR: TBCDField;
    QryCadastroNOME_PRODUTO: TStringField;
  public
    function Append(AJson: TJSONObject): Boolean; override;
    function GetByPedido(AIdPedido, AIdItem: String): TFDQuery;
    function ListAllByPedido(AParams: TDictionary<String, String>; AIdPedido: String): TFDQuery;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TServicePedidoItem }

function TServicePedidoItem.Append(AJson: TJSONObject): Boolean;
begin
  Result := inherited Append(AJson);
  QryCadastroID_PEDIDO.Visible := False;
end;

function TServicePedidoItem.GetByPedido(AIdPedido, AIdItem: String): TFDQuery;
begin
  QryCadastroID_PEDIDO.Visible := False;
  QryCadastro.SQL.Add('where i.id = :id and i.id_pedido = :id_pedido');
  QryCadastro.ParamByName('id').AsInteger        := AIdItem.ToInteger;
  QryCadastro.ParamByName('id_pedido').AsInteger := AIdPedido.ToInteger;
  QryCadastro.Open;
  Result := QryCadastro;
end;

function TServicePedidoItem.ListAllByPedido(AParams: TDictionary<String, String>; AIdPedido: String): TFDQuery;
begin
  QryPesquisa.Close;
  QryPesquisa.ParamByName('id_pedido').AsInteger := AIdPedido.ToInteger;
  QryRecordCount.Close;
  QryRecordCount.ParamByName('id_pedido').AsInteger := AIdPedido.ToInteger;
  Result := inherited ListAll(AParams);
end;

end.
