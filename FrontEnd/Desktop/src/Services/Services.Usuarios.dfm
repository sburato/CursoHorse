inherited ServiceUsuarios: TServiceUsuarios
  inherited mtPesquisa: TFDMemTable
    object mtPesquisaID: TLargeintField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object mtPesquisaNOME: TStringField
      FieldName = 'NOME'
      Size = 60
    end
    object mtPesquisaLOGIN: TStringField
      FieldName = 'LOGIN'
      Size = 30
    end
    object mtPesquisaSTATUS: TSmallintField
      Alignment = taLeftJustify
      FieldName = 'STATUS'
      OnGetText = mtPesquisaSTATUSGetText
    end
    object mtPesquisaTELEFONE: TStringField
      FieldName = 'TELEFONE'
    end
    object mtPesquisaSEXO: TSmallintField
      Alignment = taLeftJustify
      FieldName = 'SEXO'
      OnGetText = mtPesquisaSEXOGetText
    end
  end
  inherited mtCadastro: TFDMemTable
    AfterInsert = mtCadastroAfterInsert
    object mtCadastroID: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object mtCadastroNOME: TStringField
      FieldName = 'NOME'
      ProviderFlags = [pfInUpdate]
      Size = 60
    end
    object mtCadastroLOGIN: TStringField
      FieldName = 'LOGIN'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object mtCadastroSENHA: TStringField
      FieldName = 'SENHA'
      ProviderFlags = [pfInUpdate]
      Size = 256
    end
    object mtCadastroSTATUS: TSmallintField
      FieldName = 'STATUS'
      ProviderFlags = [pfInUpdate]
    end
    object mtCadastroTELEFONE: TStringField
      FieldName = 'TELEFONE'
      ProviderFlags = [pfInUpdate]
    end
    object mtCadastroSEXO: TSmallintField
      FieldName = 'SEXO'
      ProviderFlags = [pfInUpdate]
    end
    object mtCadastroFOTO: TBlobField
      FieldName = 'FOTO'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
  end
end
