unit Controllers.PedidoItem;

interface

procedure Registry;

implementation

uses
  Horse, Data.DB, System.JSON, DataSet.Serialize, Services.PedidoItem;

procedure ListarItensPedidos(Req: THorseRequest; Res: THorseResponse);
var
  LRetorno : TJSONObject;
  LService : TServicePedidoItem;
  LIdPedido: String;
begin
  LService := TServicePedidoItem.Create;
  try
    LIdPedido := Req.Params.Dictionary.Items['id_pedido'];
    LRetorno  := TJSONObject.Create;
    LRetorno.AddPair('data', LService.ListAllByPedido(Req.Query.Dictionary, LIdPedido).ToJSONArray);
    LRetorno.AddPair('records', TJSONNumber.Create(LService.GetRecordCount()));
    Res.Send(LRetorno);
  finally
    LService.Free;
  end;
end;

procedure ObterItemPedido(Req: THorseRequest; Res: THorseResponse);
var
  LIdItem  : String;
  LService : TServicePedidoItem;
  LIdPedido: String;
begin
  LService := TServicePedidoItem.Create;
  try
    LIdItem   := Req.Params.Dictionary.Items['id_item'];
    LIdPedido := Req.Params.Dictionary.items['id_pedido'];
    if (LService.GetByPedido(LIdPedido, LIdItem).IsEmpty) then
    begin
      raise EHorseException.New.Error('Item não cadastrado.').Status(THTTPStatus.NotFound)
    end;
    Res.Send(LService.QryCadastro.ToJSONObject());
  finally
    LService.Free;
  end;
end;

procedure CadastrarItem(Req: THorseRequest; Res: THorseResponse);
var
  LService   : TServicePedidoItem;
  LIdPedido  : String;
  LPedidoItem: TJSONObject;
begin
  LService := TServicePedidoItem.Create;
  try
    LIdPedido   := Req.Params.Dictionary.Items['id_pedido'];
    LPedidoItem := Req.Body<TJSONObject>;
    LPedidoItem.RemovePair('idPedido').Free;
    LPedidoItem.AddPair('idPedido', TJSONNumber.Create(LIdPedido));
    if (LService.Append(LPedidoItem)) then
    begin
      Res.Send(LService.QryCadastro.ToJSONObject()).Status(THTTPStatus.Created);
    end;
  finally
    LService.Free
  end;
end;

procedure AlterarItem(Req: THorseRequest; Res: THorseResponse);
var
  LItem        : TJSONObject;
  LService     : TServicePedidoItem;
  LPedidoId    : String;
  LPedidoItemId: String;
begin
  LService := TServicePedidoItem.Create;
  try
    LPedidoId     := Req.Params.Dictionary.Items['id_pedido'];
    LPedidoItemId := Req.Params.Dictionary.Items['id_item'];
    if (LService.GetByPedido(LPedidoId, LPedidoItemId).IsEmpty) then
    begin
      raise EHorseException.New.Error('Item não cadastrado.').Status(THTTPStatus.NotFound);
    end;
    LItem := Req.Body<TJSONObject>;
    LItem.RemovePair('idPedido').Free;
    if (LService.Update(LItem)) then
    begin
      Res.Status(THTTPStatus.NoContent);
    end;
  finally
    LService.Free;
  end;
end;

procedure DeletarItem(Req: THorseRequest; Res: THorseResponse);
var
  LService     : TServicePedidoItem;
  LPedidoId    : String;
  LPedidoItemId: String;
begin
  LService := TServicePedidoItem.Create;
  try
    LPedidoId     := Req.Params.Dictionary.Items['id_pedido'];
    LPedidoItemId := Req.Params.Dictionary.Items['id_item'];
    if (LService.GetByPedido(LPedidoId, LPedidoItemId).IsEmpty) then
    begin
      raise EHorseException.New.Error('Item não encontrado').Status(THTTPStatus.NotFound);
    end;
    if (LService.Delete()) then
    begin
      Res.Status(THTTPStatus.NoContent);
    end;
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse
    .Get('/pedidos/:id_pedido/itens', ListarItensPedidos)
    .Get('/pedidos/:id_pedido/itens/:id_item', ObterItemPedido)
    .Post('/pedidos/:id_pedido/itens', CadastrarItem)
    .Put('/pedidos/:id_pedido/itens/:id_item', AlterarItem)
    .Delete('/pedidos/:id_pedido/itens/:id_item', DeletarItem);
end;

end.
