unit Providers.Cadastro;

interface

uses
  System.SysUtils, System.Classes, Providers.Connection, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Comp.UI, FireDAC.Phys.IBBase, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, System.Json,
  System.Generics.Collections, DataSet.Serialize, FireDAC.ConsoleUI.Wait, VCL.DIALOGS;

type
  TProvidersCadastro = class(TProvidersConnection)
    QryPesquisa: TFDQuery;
    QryRecordCount: TFDQuery;
    QryCadastro: TFDQuery;
    QryRecordCountCOUNT: TIntegerField;
  public
    constructor Create; reintroduce;
    function Delete: Boolean; virtual;
    function GetRecordCount: Int64; virtual;
    function GetById(AId: String): TFDQuery; virtual;
    function Append(AJson: TJSONObject): Boolean; virtual;
    function Update(AJson: TJSONObject): Boolean; virtual;
    function ListAll(AParams: TDictionary<String, String>): TFDQuery; virtual;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TProvidersCadastro }

constructor TProvidersCadastro.Create;
begin
  inherited Create(nil);
end;

function TProvidersCadastro.Append(AJson: TJSONObject): Boolean;
begin
  QryCadastro.SQL.Add('where 1 <> 1');
  QryCadastro.Open();
  QryCadastro.LoadFromJSON(AJson, False);
  Result := QryCadastro.ApplyUpdates(0) = 0;
end;

function TProvidersCadastro.Delete: Boolean;
begin
  QryCadastro.Delete;
  Result := QryCadastro.ApplyUpdates(0) = 0;
end;

function TProvidersCadastro.GetById(AId: String): TFDQuery;
begin
  QryCadastro.SQL.Add('where id = :id');
  QryCadastro.ParamByName('id').AsLargeInt := AId.ToInteger;
  QryCadastro.Open();
  Result := QryCadastro;
end;

function TProvidersCadastro.GetRecordCount: Int64;
begin
  QryRecordCount.Open();
  Result := QryRecordCountCOUNT.AsLargeInt;
end;

function TProvidersCadastro.ListAll(AParams: TDictionary<String, String>): TFDQuery;
begin
  if (AParams.ContainsKey('limit')) then
  begin
    QryPesquisa.FetchOptions.RecsMax    := StrToIntDef(AParams.Items['limit'], 50);
    QryPesquisa.FetchOptions.RowsetSize := StrToIntDef(AParams.Items['limit'], 50);
  end;
  if (AParams.ContainsKey('offset')) then
  begin
    QryPesquisa.FetchOptions.RecsSkip   := StrToIntDef(AParams.Items['offset'], 50);
  end;
  QryPesquisa.Open();
  Result := QryPesquisa;
end;

function TProvidersCadastro.Update(AJson: TJSONObject): Boolean;
begin
  QryCadastro.MergeFromJSONObject(AJson, False);
  Result := QryCadastro.ApplyUpdates(0) = 0;
end;

end.
