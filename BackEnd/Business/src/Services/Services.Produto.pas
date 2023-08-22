unit Services.Produto;

interface

uses
  System.SysUtils, System.Classes, Providers.Cadastro, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase, FireDAC.ConsoleUI.Wait,
  System.Generics.Collections;

type
  TServiceProduto = class(TProvidersCadastro)
    QryPesquisaID: TLargeintField;
    QryPesquisaNOME: TStringField;
    QryPesquisaVALOR: TBCDField;
    QryPesquisaSTATUS: TSmallintField;
    QryPesquisaESTOQUE: TBCDField;
    QryCadastroID: TLargeintField;
    QryCadastroNOME: TStringField;
    QryCadastroVALOR: TBCDField;
    QryCadastroSTATUS: TSmallintField;
    QryCadastroESTOQUE: TBCDField;
  public
    function ListAll(AParams: TDictionary<String, String>): TFDQuery; override;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TServiceProduto }

function TServiceProduto.ListAll(AParams: TDictionary<String, String>): TFDQuery;
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
  if (AParams.ContainsKey('status')) then
  begin
    QryPesquisa.SQL.Add('and status = :status');
    QryPesquisa.ParamByName('status').AsInteger := AParams.Items['status'].ToInteger;
    QryRecordCount.SQL.Add('and status = :status');
    QryRecordCount.ParamByName('status').AsInteger := AParams.Items['status'].ToInteger;
  end;
  QryPesquisa.SQL.Add('order by id');
  Result := inherited ListAll(AParams);
end;

end.
