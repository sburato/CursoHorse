unit Controllers.Produto;

interface

uses
  Services.Produto, DataSet.Serialize;

procedure Registry;

implementation

uses
  System.SysUtils, System.JSON, Data.DB, Horse;

procedure ListarProdutos(Req: THorseRequest; Res: THorseResponse);
var
  LRetorno: TJSONObject;
  LService: TServiceProduto;
begin
  LService := TServiceProduto.Create;
  try
    LRetorno := TJSONObject.Create;
    LRetorno.AddPair('data', LService.ListAll(Req.Query.Dictionary).ToJSONArray);
    LRetorno.AddPair('records', TJSONNumber.Create(LService.GetRecordCount()));
    Res.Send(LRetorno);
  finally
    LService.Free;
  end;
end;

procedure ObterProduto(Req: THorseRequest; Res: THorseResponse);
var
  LService  : TServiceProduto;
  LIdProduto: String;
begin
  LService := TServiceProduto.Create;
  try
    LIdProduto := Req.Params.Dictionary['id'];
    if (LService.GetById(LIdProduto).IsEmpty) then
    begin
      raise EHorseException.New.Error('Produto não cadastrado.').Status(THTTPStatus.NotFound);
    end;
    Res.Send(LService.QryCadastro.ToJSONObject());
  finally
    LService.Free;
  end;
end;

procedure CadastrarProduto(Req: THorseRequest; Res: THorseResponse);
var
  LProduto: TJSONObject;
  LService: TServiceProduto;
begin
  LService := TServiceProduto.Create;
  try
    LProduto := Req.Body<TJSONObject>;
    if (LService.Append(LProduto)) then
    begin
      Res.Send(LService.QryCadastro.ToJSONObject()).Status(THTTPStatus.Created);
    end;
  finally
    LService.Free;
  end;
end;

procedure AlterarProduto(Req: THorseRequest; Res: THorseResponse);
var
  LService  : TServiceProduto;
  LProduto  : TJSONObject;
  LIdProduto: String;
begin
  LService := TServiceProduto.Create;
  try
    LIdProduto := Req.Params.Dictionary['id'];
    if (LService.GetById(LIdProduto).IsEmpty) then
    begin
      raise EHorseException.New.Error('Produto não cadastrado.').Status(THTTPStatus.NotFound);
    end;
    LProduto := Req.Body<TJSONObject>;
    if (LService.Update(LProduto)) then
    begin
      Res.Status(THTTPStatus.NoContent);
    end;
  finally
    LService.Free;
  end;
end;

procedure DeletarProduto(Req: THorseRequest; Res: THorseResponse);
var
  LService  : TServiceProduto;
  LIdProduto: String;
begin
  LService := TServiceProduto.Create;
  try
    LIdProduto := Req.Params.Dictionary['id'];
    if (LService.GetById(LIdProduto).IsEmpty) then
    begin
      raise EHorseException.New.Error('Produto não cadastrado.').Status(THTTPStatus.NotFound);
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
    .Get('/produtos', ListarProdutos)
    .Get('/produtos/:id', ObterProduto)
    .Post('/produtos', CadastrarProduto)
    .Put('/produtos/:id', AlterarProduto)
    .Delete('/produtos/:id', DeletarProduto);
end;

end.
