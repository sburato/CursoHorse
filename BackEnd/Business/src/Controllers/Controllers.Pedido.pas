unit Controllers.Pedido;

interface

procedure Registry;

implementation

uses
  System.SysUtils, System.JSON, Horse, DataSet.Serialize, Data.DB, Services.Pedido;

procedure ListarPedidos(Req: THorseRequest; Res: THorseResponse);
var
  LRetorno: TJSONObject;
  LService: TServicePedido;
begin
  LService := TServicePedido.Create;
  try
    LRetorno := TJSONObject.Create;
    LRetorno.AddPair('data', LService.ListAll(Req.Query.Dictionary).ToJSONArray());
    LRetorno.AddPair('records', TJSONNumber.Create(LService.GetRecordCount()));
    Res.Send(LRetorno);
  finally
    LService.Free;
  end;
end;

procedure ObterPedido(Req: THorseRequest; Res: THorseResponse);
var
  LService : TServicePedido;
  LIdPedido: String;
begin
  LService := TServicePedido.Create;
  try
    LIdPedido := Req.Params.Dictionary.Items['id'];
    if (LService.GetById(LIdPedido).IsEmpty) then
    begin
      raise EHorseException.New.Error('Pedido não cadastrado.').Status(THTTPStatus.NotFound);
    end;
    Res.Send(LService.QryCadastro.ToJSONObject());
  finally
    LService.Free;
  end;
end;

procedure CadastrarPedido(Req: THorseRequest; Res: THorseResponse);
var
  LPedido : TJSONObject;
  LService: TServicePedido;
begin
  LService := TServicePedido.Create;
  try
    LPedido := Req.Body<TJSONObject>;
    if (LService.Append(LPedido)) then
    begin
      Res.Send(LService.QryCadastro.ToJSONObject()).Status(THTTPStatus.Created);
    end;
  finally
    LService.Free;
  end;
end;

procedure AlterarPedido(Req: THorseRequest; Res: THorseResponse);
var
  LPedido  : TJSONObject;
  LService : TServicePedido;
  LIdPedido: String;
begin
  LService := TServicePedido.Create;
  try
    LIdPedido := Req.Params.Dictionary.Items['id'];
    if (LService.GetById(LIdPedido).IsEmpty) then
    begin
      raise EHorseException.New.Error('Pedido não cadastrado.').Status(THTTPStatus.NotFound);
    end;
    LPedido := Req.Body<TJSONObject>;
    if (LService.Update(LPedido)) then
    begin
      Res.Status(THTTPStatus.NoContent);
    end;
  finally
    LService.Free;
  end;
end;

procedure DeletarPedido(Req: THorseRequest; Res: THorseResponse);
var
  LService : TServicePedido;
  LIdPedido: String;
begin
  LService := TServicePedido.Create;
  try
    LIdPedido := Req.Params.Dictionary.Items['id'];
    if (LService.GetById(LIdPedido).IsEmpty) then
    begin
      raise EHorseException.New.Error('Pedido não cadastrado.').Status(THTTPStatus.NotFound);
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
    .Get('/pedidos', ListarPedidos)
    .Get('/pedidos/:id', ObterPedido)
    .Post('/pedidos', CadastrarPedido)
    .Put('/pedidos/:id', AlterarPedido)
    .Delete('/pedidos/:id', DeletarPedido);
end;

end.
