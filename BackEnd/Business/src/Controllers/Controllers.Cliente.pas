unit Controllers.Cliente;

interface

procedure Registry;

implementation

uses
  Horse, System.JSON, DataSet.Serialize, Data.DB, Services.Cliente;

procedure ListarClientes(Req: THorseRequest; Res: THorseResponse);
var
  LRetorno: TJSONObject;
  LService: TServiceCliente;
begin
  LService := TServiceCliente.Create;
  try
    LRetorno := TJSONObject.Create;
    LRetorno.AddPair('data', LService.ListAll(Req.Query.Dictionary).ToJSONArray());
    LRetorno.AddPair('records', TJSONNumber.Create(LService.GetRecordCount()));
    Res.Send(LRetorno);
  finally
    LService.Free;
  end;
end;

procedure ObterCliente(Req: THorseRequest; Res: THorseResponse);
var
  LService  : TServiceCliente;
  LIdCliente: String;
begin
  LService := TServiceCliente.Create;
  try
    LIdCliente := Req.Params.Dictionary['id'];
    if (LService.GetById(LIdCliente).IsEmpty) then
    begin
      raise EHorseException.New.Error('Cliente não cadastrado.').Status(THTTPStatus.NotFound);
    end;
    Res.Send(LService.QryCadastro.ToJSONObject());
  finally
    LService.Free;
  end;
end;

procedure CadastrarCliente(Req: THorseRequest; Res: THorseResponse);
var
  LCliente: TJSONObject;
  LService: TServiceCliente;
begin
  LService := TServiceCliente.Create;
  try
    LCliente := Req.Body<TJSONObject>;
    if (LService.Append(LCliente)) then
    begin
      Res.Send(LService.QryCadastro.ToJSONObject()).Status(THTTPStatus.Created);
    end;
  finally
    LService.Free;
  end;
end;

procedure AlterarCliente(Req: THorseRequest; Res: THorseResponse);
var
  LService  : TServiceCliente;
  LCliente  : TJSONObject;
  LIdCliente: String;
begin
  LService := TServiceCliente.Create;
  try
    LIdCliente := Req.Params.Dictionary['id'];
    if (LService.GetById(LIdCliente).IsEmpty) then
    begin
      raise EHorseException.New.Error('Cliente não cadastrado.').Status(THTTPStatus.NotFound);
    end;
    LCliente := Req.Body<TJSONObject>;
    if (LService.Update(LCliente)) then
    begin
      Res.Status(THTTPStatus.NoContent);
    end;
  finally
    LService.Free;
  end;
end;

procedure DeletarCliente(Req: THorseRequest; Res: THorseResponse);
var
  LService  : TServiceCliente;
  LIdCliente: String;
begin
  LService := TServiceCliente.Create;
  try
    LIdCliente := Req.Params.Dictionary['id'];
    if (LService.GetById(LIdCliente).IsEmpty) then
    begin
      raise EHorseException.New.Error('Cliente não cadastrado.').Status(THTTPStatus.NotFound);
    end;
    if (LService.Delete) then
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
    .Get('/clientes', ListarClientes)
    .Get('/clientes/:id', ObterCliente)
    .Post('/clientes', CadastrarCliente)
    .Put('/clientes/:id', AlterarCliente)
    .Delete('/clientes/:id', DeletarCliente);
end;

end.
