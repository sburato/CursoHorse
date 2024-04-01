unit Providers.Models.User;

interface

type
  TUser = class
  private
    FId: Integer;
    FNome: String;
    FLogin: String;
    FTelefone: String;
    FSexo: Integer;
  public
    function GetSexoAsString: String;

    property Id: Integer read FId write FId;
    property Nome: String read FNome write FNome;
    property Login: String read FLogin write FLogin;
    property Telefone: String read FTelefone write FTelefone;
    property Sexo: Integer read FSexo write FSexo;
  end;

implementation

{ TUser }

function TUser.GetSexoAsString: String;
begin
  Result := 'Masculino';
  if (FSexo = 1) then
  begin
    Result := 'Feminino';
  end;
end;

end.
