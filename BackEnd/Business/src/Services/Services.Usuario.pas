unit Services.Usuario;

interface

uses
  System.SysUtils, System.Classes, Providers.Cadastro, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase, System.JSON,
  System.Generics.Collections;

type
  TServiceUsuario = class(TProvidersCadastro)
    QryPesquisaID: TLargeintField;
    QryPesquisaNOME: TStringField;
    QryPesquisaLOGIN: TStringField;
    QryPesquisaSTATUS: TSmallintField;
    QryPesquisaTELEFONE: TStringField;
    QryPesquisaSEXO: TSmallintField;
    QryCadastroID: TLargeintField;
    QryCadastroNOME: TStringField;
    QryCadastroLOGIN: TStringField;
    QryCadastroSENHA: TStringField;
    QryCadastroSTATUS: TSmallintField;
    QryCadastroTELEFONE: TStringField;
    QryCadastroSEXO: TSmallintField;
    QryCadastroFOTO: TBlobField;
    procedure QryCadastroBeforePost(DataSet: TDataSet);
  public
    function ObterFotoUsuario: TStream;
    function GetById(AId: String): TFDQuery; override;
    function SalvarFotoUsuario(AFoto: TStream): Boolean;
    function Update(AJson: TJSONObject): Boolean; override;
    function Append(AJson: TJSONObject): Boolean; override;
    function ListAll(AParams: TDictionary<String, String>): TFDQuery; override;
  end;

implementation

uses
  BCrypt;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TServiceUsuario }

function TServiceUsuario.Append(AJson: TJSONObject): Boolean;
begin
  Result := inherited Append(AJson);
  QryCadastroSENHA.Visible := False;
end;

function TServiceUsuario.GetById(AId: String): TFDQuery;
begin
  Result := inherited GetById(AId);
  QryCadastroSENHA.Visible := False;
end;

function TServiceUsuario.ListAll(AParams: TDictionary<String, String>): TFDQuery;
begin
  if (AParams.ContainsKey('id')) then
  begin
    QryPesquisa.SQL.Add('and id = :id');
    QryPesquisa.ParamByName('id').AsInteger := AParams.Items['id'].ToInteger;
    QryRecordCount.SQL.Add('and id = :id');
    QryRecordCount.ParamByName('id').AsInteger := AParams.Items['id'].ToInteger;
  end;
  if (AParams.ContainsKey('nome')) then
  begin
    QryPesquisa.SQL.Add('and lower(nome) like :nome');
    QryPesquisa.ParamByName('nome').AsString := '%' + AParams.Items['nome'].ToLower + '%';
    QryRecordCount.SQL.Add('and lower(nome) like :nome');
    QryRecordCount.ParamByName('nome').AsString := '%' + AParams.Items['nome'].ToLower + '%';
  end;
  if (AParams.ContainsKey('login')) then
  begin
    QryPesquisa.SQL.Add('and login = :login');
    QryPesquisa.ParamByName('login').AsString := AParams.Items['login'];
    QryRecordCount.SQL.Add('and login = :login');
    QryRecordCount.ParamByName('login').AsString := AParams.Items['login'];
  end;
  QryPesquisa.SQL.Add('order by u.id');
  Result := inherited ListAll(AParams);
end;

procedure TServiceUsuario.QryCadastroBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (QryCadastroSENHA.OldValue <> QryCadastroSENHA.NewValue) then
  begin
    if (QryCadastroSENHA.AsString.Trim.IsEmpty = False) then
    begin
      QryCadastroSENHA.AsString := TBCrypt.GenerateHash(QryCadastroSENHA.AsString);
    end;
  end;
end;

function TServiceUsuario.SalvarFotoUsuario(AFoto: TStream): Boolean;
begin
  QryCadastro.Edit;
  QryCadastroFOTO.LoadFromStream(AFoto);
  QryCadastro.Post;
  Result := QryCadastro.ApplyUpdates(0) = 0;
end;

function TServiceUsuario.ObterFotoUsuario: TStream;
begin
  Result := nil;
  if (QryCadastroFOTO.IsNull) then
  begin
    Exit;
  end;
  Result := TMemoryStream.Create;
  QryCadastroFOTO.SaveToStream(Result);
end;

function TServiceUsuario.Update(AJson: TJSONObject): Boolean;
begin
  QryCadastroSENHA.Visible := True;
  Result := inherited Update(AJson);
end;

end.
