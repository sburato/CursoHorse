unit Services.Usuarios;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServiceUsuarios = class(TServiceBaseCadastro)
    mtPesquisaID: TLargeintField;
    mtPesquisaNOME: TStringField;
    mtPesquisaLOGIN: TStringField;
    mtPesquisaSTATUS: TSmallintField;
    mtPesquisaTELEFONE: TStringField;
    mtPesquisaSEXO: TSmallintField;
    mtCadastroID: TLargeintField;
    mtCadastroNOME: TStringField;
    mtCadastroLOGIN: TStringField;
    mtCadastroSENHA: TStringField;
    mtCadastroSTATUS: TSmallintField;
    mtCadastroTELEFONE: TStringField;
    mtCadastroSEXO: TSmallintField;
    mtCadastroFOTO: TBlobField;
    procedure DataModuleCreate(Sender: TObject);
    procedure mtCadastroAfterInsert(DataSet: TDataSet);
    procedure mtPesquisaSEXOGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure mtPesquisaSTATUSGetText(Sender: TField; var Text: string; DisplayText: Boolean);
  public
    procedure Salvar; override;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TServiceUsuarios.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Request.BaseURL('http://localhost:9000').Resource('usuarios');
end;

procedure TServiceUsuarios.mtCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  mtCadastrostatus.AsInteger := 1;
  mtCadastroSEXO.AsInteger   := 0;
end;

procedure TServiceUsuarios.mtPesquisaSEXOGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Masculino';
  if (Sender.AsInteger = 1) then
  begin
    Text := 'Feminio';
  end;
end;

procedure TServiceUsuarios.mtPesquisaSTATUSGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Ativo';
  if (Sender.AsInteger = 0) then
  begin
    Text := 'Inativo';
  end;
end;

procedure TServiceUsuarios.Salvar;
begin
  mtCadastroSENHA.Visible := mtCadastroSENHA.AsString.Trim.IsEmpty = False;
  inherited;
end;

end.
