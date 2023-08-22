unit Services.Base.Cadastro;

interface

uses
  System.SysUtils, System.Classes, Services.Base, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServiceBaseCadastro = class(TServiceBase)
    mtPesquisa: TFDMemTable;
    mtCadastro: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    FRecords: Integer;
    FPageLimit: Integer;
    FPage: Integer;
    FPages: Integer;
    function GetResourceSuffix: String;
  public
    procedure Salvar; virtual;
    procedure Incluir; virtual;
    procedure Alterar; virtual;
    procedure Excluir; virtual;
    procedure ListarRegistros; virtual;

    property Records  : Integer read FRecords   write FRecords;
    property PageLimit: Integer read FPageLimit write FPageLimit;
    property Page     : Integer read FPage      write FPage;
    property Pages    : Integer read FPages     write FPages;
  end;

implementation

uses
  System.JSON, RESTRequest4D, DataSet.Serialize, Providers.Session;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TServiceBaseCadastro }

procedure TServiceBaseCadastro.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FPage := 1;
  FPages := 1;
  FRecords := 0;
  FPageLimit := 50;
end;

function TServiceBaseCadastro.GetResourceSuffix: String;
var
  LField: TField;
begin
  for LField in mtPesquisa.Fields do
  begin
    if (TProviderFlag.pfInKey in LField.ProviderFlags) then
    begin
      Exit(LField.AsString);
    end;
  end;
end;

procedure TServiceBaseCadastro.ListarRegistros;
var
  LResponse: IResponse;
begin
  mtPesquisa.DisableControls;
  try
    LResponse := Request
      .Token('bearer' + TSession.GetInstance.Token.Access)
      .ResourceSuffix(String.Empty)
      .AddParam('limit', FPageLimit.ToString)
      .AddParam('offset', (Pred(FPage) * FPageLimit).ToString)
      .Get;

    if (mtPesquisa.Active) then
    begin
      mtPesquisa.EmptyDataSet;
    end;

    if (LResponse.StatusCode <> 200) then
    begin
      raise Exception.Create(LResponse.JSONValue.GetValue<String>('error'));
    end;

    mtPesquisa.LoadFromJSON(LResponse.JSONValue.GetValue<TJSONArray>('data'), False);
    FRecords := LResponse.JSONValue.GetValue<Integer>('records');
  finally
    mtPesquisa.EnableControls;
  end;
end;

procedure TServiceBaseCadastro.Incluir;
begin
  if (mtCadastro.Active = False) then
  begin
    mtCadastro.Open;
  end;
  mtCadastro.Append;
end;

procedure TServiceBaseCadastro.Alterar;
var
  LResponse: IResponse;
begin
  if ((mtPesquisa.Active = False) or (mtPesquisa.IsEmpty)) then
  begin
    raise Exception.Create('Selecione um registro para alterar.');
  end;

  LResponse := Request
    .Token('bearer' + TSession.GetInstance.Token.Access)
    .ResourceSuffix(Self.GetResourceSuffix())
    .Get;

  if (LResponse.StatusCode <> 200) then
  begin
    raise Exception.Create(LResponse.JSONValue.GetValue<String>('error'));
  end;

  if (mtCadastro.Active) then
  begin
    mtCadastro.EmptyDataSet;
  end;

  mtCadastro.LoadFromJSON(LResponse.Content);
  mtCadastro.Edit;
end;

procedure TServiceBaseCadastro.Excluir;
var
  LResponse: IResponse;
begin
  if ((mtPesquisa.Active = False) or (mtPesquisa.IsEmpty)) then
  begin
    raise Exception.Create('Selecione um registro para excluir.');
  end;

  LResponse := Request
    .Token('bearer ' + TSession.GetInstance.Token.Access)
    .ResourceSuffix(Self.GetResourceSuffix())
    .Delete;

  if (LResponse.StatusCode <> 204) then
  begin
    raise Exception.Create(LResponse.JSONValue.GetValue<String>('error'));
  end;

  mtPesquisa.Delete;
end;

procedure TServiceBaseCadastro.Salvar;
var
  LResponse: IResponse;
begin
  mtPesquisa.DisableControls;
  try
    Request
      .Token('bearer' + TSession.GetInstance.Token.Access)
      .ClearParams
      .ClearBody
      .AddBody(mtCadastro.ToJSONObject);

    if (mtCadastro.State = TDataSetState.dsEdit) then
      LResponse := Request.Put
    else
      LResponse := Request.ResourceSuffix(String.Empty).Post;

    if ((LResponse.StatusCode in [201, 204]) = False) then
    begin
      raise Exception.Create(LResponse.JSONValue.GetValue<String>('error'));
    end;

    if (mtPesquisa.Active = False) then
    begin
      mtPesquisa.Open;
    end;

    if (mtCadastro.State = TDataSetState.dsEdit) then
      mtPesquisa.MergeFromJSONObject(mtCadastro.ToJSONObject)
    else
      mtPesquisa.LoadFromJSON(LResponse.Content);

    mtCadastro.Cancel;
  finally
    mtPesquisa.EnableControls;
  end;
end;

end.
