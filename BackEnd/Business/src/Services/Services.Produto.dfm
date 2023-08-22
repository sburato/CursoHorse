inherited ServiceProduto: TServiceProduto
  inherited QryPesquisa: TFDQuery
    SQL.Strings = (
      'select'
      '   p.id,'
      '   p.nome,'
      '   p.valor,'
      '   p.status,'
      '   p.estoque'
      'from produto p'
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
      Required = True
      Size = 60
    end
    object QryPesquisaVALOR: TBCDField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      Required = True
      Precision = 18
    end
    object QryPesquisaSTATUS: TSmallintField
      FieldName = 'STATUS'
      Origin = 'STATUS'
      Required = True
    end
    object QryPesquisaESTOQUE: TBCDField
      FieldName = 'ESTOQUE'
      Origin = 'ESTOQUE'
      Required = True
      Precision = 18
    end
  end
  inherited QryRecordCount: TFDQuery
    SQL.Strings = (
      'select count(p.id) from produto p where 1 = 1')
  end
  inherited QryCadastro: TFDQuery
    SQL.Strings = (
      'select'
      '   p.id,'
      '   p.nome,'
      '   p.valor,'
      '   p.status,'
      '   p.estoque'
      'from produto p')
    object QryCadastroID: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
      Required = True
    end
    object QryCadastroNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 60
    end
    object QryCadastroVALOR: TBCDField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      ProviderFlags = [pfInUpdate]
      Required = True
      Precision = 18
    end
    object QryCadastroSTATUS: TSmallintField
      FieldName = 'STATUS'
      Origin = 'STATUS'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object QryCadastroESTOQUE: TBCDField
      FieldName = 'ESTOQUE'
      Origin = 'ESTOQUE'
      ProviderFlags = [pfInUpdate]
      Required = True
      Precision = 18
    end
  end
end
