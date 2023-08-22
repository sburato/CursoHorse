unit Services.Clientes;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServiceClientes = class(TServiceBaseCadastro)
    mtPesquisaid: TIntegerField;
    mtPesquisanome: TStringField;
    mtPesquisastatus: TIntegerField;
    mtCadastroid: TIntegerField;
    mtCadastronome: TStringField;
    mtCadastrostatus: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure mtPesquisastatusGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure mtCadastroAfterInsert(DataSet: TDataSet);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServiceClientes.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Request.BaseURL('http://localhost:9000').Resource('clientes');
end;

procedure TServiceClientes.mtCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  mtCadastrostatus.AsInteger := 1;
end;

procedure TServiceClientes.mtPesquisastatusGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Ativo';
  if (Sender.AsInteger = 0) then
  begin
    Text := 'Inativo';
  end;
end;

end.
