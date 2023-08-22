inherited ServiceCliente: TServiceCliente
  inherited QryPesquisa: TFDQuery
    SQL.Strings = (
      'select'
      '   c.id,'
      '   c.nome,'
      '   c.status'
      'from cliente c'
      'where'
      '   1 = 1')
    object QryPesquisaID: TLargeintField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryPesquisaNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 60
    end
    object QryPesquisaSTATUS: TSmallintField
      FieldName = 'STATUS'
      Origin = 'STATUS'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
  end
  inherited QryRecordCount: TFDQuery
    SQL.Strings = (
      'select count(c.id) from cliente c where 1 = 1')
  end
  inherited QryCadastro: TFDQuery
    SQL.Strings = (
      'select'
      '   c.id,'
      '   c.nome,'
      '   c.status'
      'from cliente c')
    object QryCadastroID: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryCadastroNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 60
    end
    object QryCadastroSTATUS: TSmallintField
      FieldName = 'STATUS'
      Origin = 'STATUS'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
  end
end
