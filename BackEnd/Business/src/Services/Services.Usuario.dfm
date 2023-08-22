inherited ServiceUsuario: TServiceUsuario
  inherited QryPesquisa: TFDQuery
    SQL.Strings = (
      'select'
      '   u.id,'
      '   u.nome,'
      '   u.login,'
      '   u.status,'
      '   u.telefone,'
      '   u.sexo'
      'from usuario u'
      'where'
      '  1 = 1')
    object QryPesquisaID: TLargeintField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryPesquisaNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 60
    end
    object QryPesquisaLOGIN: TStringField
      FieldName = 'LOGIN'
      Origin = 'LOGIN'
      Required = True
      Size = 30
    end
    object QryPesquisaSTATUS: TSmallintField
      FieldName = 'STATUS'
      Origin = 'STATUS'
      Required = True
    end
    object QryPesquisaTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
    end
    object QryPesquisaSEXO: TSmallintField
      FieldName = 'SEXO'
      Origin = 'SEXO'
      Required = True
    end
  end
  inherited QryRecordCount: TFDQuery
    SQL.Strings = (
      'select count(u.id) from usuario u'
      'where'
      '  1 = 1')
  end
  inherited QryCadastro: TFDQuery
    BeforePost = QryCadastroBeforePost
    SQL.Strings = (
      'select'
      '   u.id,'
      '   u.nome,'
      '   u.login,'
      '   u.senha,'
      '   u.status,'
      '   u.telefone,'
      '   u.sexo,'
      '   u.foto'
      'from usuario u')
    object QryCadastroID: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QryCadastroNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 60
    end
    object QryCadastroLOGIN: TStringField
      FieldName = 'LOGIN'
      Origin = 'LOGIN'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 30
    end
    object QryCadastroSENHA: TStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 256
    end
    object QryCadastroSTATUS: TSmallintField
      FieldName = 'STATUS'
      Origin = 'STATUS'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object QryCadastroTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
      ProviderFlags = [pfInUpdate]
    end
    object QryCadastroSEXO: TSmallintField
      FieldName = 'SEXO'
      Origin = 'SEXO'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object QryCadastroFOTO: TBlobField
      FieldName = 'FOTO'
      Origin = 'FOTO'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
  end
end
