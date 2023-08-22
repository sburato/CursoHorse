unit Controllers.Usuario;

interface

procedure Registry;

implementation

uses
  System.Classes, System.JSON, Data.DB, Horse, DataSet.Serialize, Services.Usuario;

procedure ListarUsuarios(Req: THorseRequest; Res: THorseResponse);
var
  LRetorno: TJSONObject;
  LService: TServiceUsuario;
begin
  LService := TServiceUsuario.Create;
  try
    LRetorno := TJSONObject.Create;
    LRetorno.AddPair('data', LService.ListAll(Req.Query.Dictionary).ToJSONArray);
    LRetorno.AddPair('records', TJSONNumber.Create(LService.GetRecordCount()));
    Res.Send(LRetorno);
  finally
    LService.Free;
  end;
end;

procedure ObterUsuario(Req: THorseRequest; Res: THorseResponse);
var
  LService  : TServiceUsuario;
  LUsuarioId: String;
begin
  LService := TServiceUsuario.Create;
  try
    LUsuarioId := Req.Params.Dictionary.Items['id'];
    if (LService.GetById(LUsuarioId).IsEmpty) then
    begin
      raise EHorseException.New.Error('Usuário não cadastrado.').Status(THTTPStatus.NotFound);
    end;
    Res.Send(LService.QryCadastro.ToJSONObject());
  finally
    LService.Free
  end;
end;

procedure CadastrarUsuario(Req: THorseRequest; Res: THorseResponse);
var
  LUsuario: TJSONObject;
  LService: TServiceUsuario;
begin
  LService := TServiceUsuario.Create;
  try
    LUsuario := Req.Body<TJSONObject>;
    if (LService.Append(LUsuario)) then
    begin
      Res.Send(LService.QryCadastro.ToJSONObject()).Status(THTTPStatus.Created);
    end;
  finally
    LService.Free;
  end;
end;

procedure AlterarUsuario(Req: THorseRequest; Res: THorseResponse);
var
  LService  : TServiceUsuario;
  LUsuario  : TJSONObject;
  LUsuarioId: String;
begin
  LService := TServiceUsuario.Create;
  try
    LUsuarioId := Req.Params.Dictionary.Items['id'];
    if (LService.GetById(LUsuarioId).IsEmpty) then
    begin
      raise EHorseException.New.Error('Usuário não cadastrado.').Status(THTTPStatus.NotFound);
    end;
    LUsuario := Req.Body<TJSONObject>;
    if (LService.Update(LUsuario)) then
    begin
      Res.Status(THTTPStatus.NoContent);
    end;
  finally
    LService.Free;
  end;
end;

procedure DeletarUsuario(Req: THorseRequest; Res: THorseResponse);
var
  LService  : TServiceUsuario;
  LUsuarioId: String;
begin
  LService := TServiceUsuario.Create;
  try
    LUsuarioId := Req.Params.Dictionary.Items['id'];
    if (LService.GetById(LUsuarioId).IsEmpty) then
    begin
      raise EHorseException.New.Error('Usuário não cadastrado.').Status(THTTPStatus.NotFound);
    end;
    if (LService.Delete()) then
    begin
      Res.Status(THTTPStatus.NoContent);
    end;
  finally
    LService.Free;
  end;
end;

procedure CadastrarFotoUsuario(Req: THorseRequest; Res: THorseResponse);
var
  LFoto     : TMemoryStream;
  LService  : TServiceUsuario;
  LUsuarioId: String;
begin
  LService := TServiceUsuario.Create;
  try
    LUsuarioId := Req.Params.Dictionary.Items['id'];
    if (LService.GetById(LUsuarioId).IsEmpty) then
    begin
      raise EHorseException.New.Error('Usuário não cadastrado.').Status(THTTPStatus.NotFound);
    end;
    LFoto := Req.Body<TMemoryStream>;
    if (Assigned(LFoto) = False) then
    begin
      raise EHorseException.New.Error('Foto inválida.').Status(THTTPStatus.BadRequest);
    end;
    if (LService.SalvarFotoUsuario(LFoto)) then
    begin
      Res.Status(THTTPStatus.NoContent);
    end;
  finally
    LService.Free;
  end;
end;

procedure ObterFotoUsuario(Req: THorseRequest; Res: THorseResponse);
var
  LFoto     : TStream;
  LService  : TServiceUsuario;
  LUsuarioId: String;
begin
  LService := TServiceUsuario.Create;
  try
    LUsuarioId := Req.Params.Dictionary.Items['id'];
    if (LService.GetById(LUsuarioId).IsEmpty) then
    begin
      raise EHorseException.New.Error('Usuário não cadastrado.').Status(THTTPStatus.NotFound);
    end;
    LFoto := LService.ObterFotoUsuario();
    if (Assigned(LFoto) = False) then
    begin
      raise EHorseException.New.Error('Foto não cadastrada.').Status(THTTPStatus.NotFound);
    end;
    Res.Send(LFoto);
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse
    .Get('/usuarios', ListarUsuarios)
    .Get('/usuarios/:id', ObterUsuario)
    .Post('/usuarios', CadastrarUsuario)
    .Put('/usuarios/:id', AlterarUsuario)
    .Delete('/usuarios/:id', DeletarUsuario)
    .Get('/usuarios/:id/foto', ObterFotoUsuario)
    .Post('/usuarios/:id/foto', CadastrarFotoUsuario);
end;

end.
