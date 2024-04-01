unit Services.Consulta.Cliente;

interface

uses
  System.SysUtils, System.Classes, Services.Base, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServiceConsultaCliente = class(TServicesBase)
    mtClientes: TFDMemTable;
    mtClientesID: TLargeintField;
    mtClientesNOME: TStringField;
    mtClientesSTATUS: TSmallintField;
  public
    procedure ListarClientes(ANome: String);
  end;

implementation

uses
  DataSet.Serialize, Providers.Request, System.JSON;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TServiceConsultaCliente }

procedure TServiceConsultaCliente.ListarClientes(ANome: String);
var
  LResponse: IResponse;
begin
  if (mtClientes.Active = False) then
  begin
    mtClientes.Open;
  end;

  mtClientes.EmptyDataSet;

  LResponse := TRequest.New
    .BaseURL('http://localhost:9000')
    .Resource('clientes')
    .AddParam('nome', ANome)
    .Get;

  if (LResponse.StatusCode <> 200) then
  begin
    raise Exception.Create(LResponse.Content);
  end;

  mtClientes.LoadFromJSON(LResponse.JSONValue.GetValue<TJsonArray>('data'), False);
end;

end.
