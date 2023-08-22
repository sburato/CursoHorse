unit Services.Produtos;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServiceProdutos = class(TServiceBaseCadastro)
    mtPesquisaid: TLargeintField;
    mtPesquisanome: TStringField;
    mtPesquisavalor: TBCDField;
    mtPesquisastatus: TSmallintField;
    mtPesquisaestoque: TBCDField;
    mtCadastroid: TLargeintField;
    mtCadastronome: TStringField;
    mtCadastrovalor: TBCDField;
    mtCadastrostatus: TSmallintField;
    mtCadastroestoque: TBCDField;
    procedure DataModuleCreate(Sender: TObject);
    procedure mtCadastroAfterInsert(DataSet: TDataSet);
    procedure mtPesquisastatusGetText(Sender: TField; var Text: string; DisplayText: Boolean);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServiceProdutos.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Request.BaseURL('http://localhost:9000').Resource('produtos');
end;

procedure TServiceProdutos.mtCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  mtCadastrostatus.AsInteger := 1;
end;

procedure TServiceProdutos.mtPesquisastatusGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Ativo';
  if (Sender.AsInteger = 0) then
  begin
    Text := 'Inativo';
  end;
end;

end.
