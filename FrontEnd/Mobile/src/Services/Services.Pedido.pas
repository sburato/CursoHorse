unit Services.Pedido;

interface

uses
  System.SysUtils, System.Classes, Services.Base, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServicesPedido = class(TServicesBase)
    mtPedidos: TFDMemTable;
    mtPedidosID: TLargeintField;
    mtPedidosID_CLIENTE: TLargeintField;
    mtPedidosID_USUARIO: TLargeintField;
    mtPedidosDATA: TSQLTimeStampField;
    mtPedidosNOME_CLIENTE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ListarPedidosUsuario;
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses
  System.JSON, Providers.Request, DataSet.Serialize;

{$R *.dfm}

procedure TServicesPedido.DataModuleCreate(Sender: TObject);
begin
  inherited;
  mtPedidos.Open;
end;

procedure TServicesPedido.ListarPedidosUsuario;
var
  LResponse: IResponse;
begin
  LResponse := TRequest.New
    .BaseUrl('http://localhost:9000')
    .Resource('/pedidos')
    .AddParam('idUsuario', Session.User.Id.ToString)
    .Get;

  if (LResponse.StatusCode <> 200) then
  begin
    raise Exception.Create(LResponse.Content);
  end;

  mtPedidos.EmptyDataSet;
  mtPedidos.LoadFromJSON(LResponse.JSONValue.GetValue<TJSONArray>('data'), False);
end;

end.
