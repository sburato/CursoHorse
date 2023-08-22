unit Services.Pedido;

interface

uses
  System.SysUtils, System.Classes, Providers.Cadastro, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  System.Generics.Collections;

type
  TServicePedido = class(TProvidersCadastro)
    QryPesquisaID: TLargeintField;
    QryPesquisaID_CLIENTE: TLargeintField;
    QryPesquisaID_USUARIO: TLargeintField;
    QryPesquisaDATA: TSQLTimeStampField;
    QryPesquisaNOME_CLIENTE: TStringField;
    QryCadastroID: TLargeintField;
    QryCadastroID_CLIENTE: TLargeintField;
    QryCadastroID_USUARIO: TLargeintField;
    QryCadastroDATA: TSQLTimeStampField;
    QryCadastroNOME_CLIENTE: TStringField;
    procedure QryCadastroAfterInsert(DataSet: TDataSet);
  public
    function GetById(AId: String): TFDQuery; override;
    function ListAll(AParams: TDictionary<String, String>): TFDQuery; override;
  end;

var
  ServicePedido: TServicePedido;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TServicePedido }

function TServicePedido.GetById(AId: String): TFDQuery;
begin
  QryCadastro.SQL.Add('where p.id = :id');
  QryCadastro.ParamByName('id').AsLargeInt := AId.ToInteger;
  QryCadastro.Open();
  Result := QryCadastro;
end;

procedure TServicePedido.QryCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  QryCadastroDATA.AsDateTime := Now;
end;

function TServicePedido.ListAll(AParams: TDictionary<String, String>): TFDQuery;
begin
  if (AParams.ContainsKey('id')) then
  begin
    QryPesquisa.SQL.Add('and p.id = :id');
    QryPesquisa.ParamByName('id').AsInteger := AParams.Items['id'].ToInteger;
    QryRecordCount.SQL.Add('and p.id = :id');
    QryRecordCount.ParamByName('id').AsInteger := AParams.Items['id'].ToInteger;
  end;
  if (AParams.ContainsKey('idCliente')) then
  begin
    QryPesquisa.SQL.Add('and id_cliente = :idCliente');
    QryPesquisa.ParamByName('idCliente').AsInteger := AParams.Items['idCliente'].ToInteger;
    QryRecordCount.SQL.Add('and id_cliente = :idCliente');
    QryRecordCount.ParamByName('idCliente').AsInteger := AParams.Items['idCliente'].ToInteger;
  end;
  if (AParams.ContainsKey('idUsuario')) then
  begin
    QryPesquisa.SQL.Add('and id_usuario = :idUsuario');
    QryPesquisa.ParamByName('idUsuario').AsInteger := AParams.Items['idUsuario'].ToInteger;
    QryRecordCount.SQL.Add('and id_usuario = :idUsuario');
    QryRecordCount.ParamByName('idUsuario').AsInteger := AParams.Items['idUsuario'].ToInteger;
  end;
  if (AParams.ContainsKey('nomeCliente')) then
  begin
    QryPesquisa.SQL.Add('and lower(c.nome) like :nome');
    QryPesquisa.ParamByName('nome').AsString := '%' + AParams.Items['nomeCliente'].ToLower + '%';
    QryRecordCount.SQL.Add('and lower(c.nome) like :nome');
    QryRecordCount.ParamByName('nome').AsString := '%' + AParams.Items['nomeCliente'].ToLower + '%';
  end;
  QryPesquisa.SQL.Add('order by p.id');
  Result := inherited ListAll(AParams);
end;

end.
