inherited ServicePedidoItem: TServicePedidoItem
  inherited QryPesquisa: TFDQuery
    SQL.Strings = (
      'select'
      '   i.id,'
      '   i.id_produto,'
      '   i.quantidade,'
      '   i.valor,'
      '   p.nome as nome_produto'
      'from pedido_item i'
      '   left outer join produto p on (p.id = i.id_produto)'
      'where'
      '   i.id_pedido = :id_pedido')
    ParamData = <
      item
        Name = 'ID_PEDIDO'
        DataType = ftLargeint
        ParamType = ptInput
        Value = Null
      end>
    object QryPesquisaID: TLargeintField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryPesquisaID_PRODUTO: TLargeintField
      FieldName = 'ID_PRODUTO'
      Origin = 'ID_PRODUTO'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object QryPesquisaQUANTIDADE: TBCDField
      FieldName = 'QUANTIDADE'
      Origin = 'QUANTIDADE'
      ProviderFlags = [pfInUpdate]
      Required = True
      Precision = 18
    end
    object QryPesquisaVALOR: TBCDField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      ProviderFlags = [pfInUpdate]
      Required = True
      Precision = 18
    end
    object QryPesquisaNOME_PRODUTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME_PRODUTO'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
  end
  inherited QryRecordCount: TFDQuery
    SQL.Strings = (
      'select count(i.id)from pedido_item i'
      '   left outer join produto p on (p.id = i.id_produto)'
      'where'
      '   i.id_pedido = :id_pedido')
    ParamData = <
      item
        Name = 'ID_PEDIDO'
        DataType = ftLargeint
        ParamType = ptInput
        Value = Null
      end>
  end
  inherited QryCadastro: TFDQuery
    SQL.Strings = (
      'select'
      '   i.id,'
      '   i.id_pedido,'
      '   i.id_produto,'
      '   i.quantidade,'
      '   i.valor,'
      '   p.nome as nome_produto'
      'from pedido_item i'
      '   left outer join produto p on (p.id = i.id_produto)')
    object QryCadastroID: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
      Required = True
    end
    object QryCadastroID_PEDIDO: TLargeintField
      FieldName = 'ID_PEDIDO'
      Origin = 'ID_PEDIDO'
      ProviderFlags = [pfInUpdate]
    end
    object QryCadastroID_PRODUTO: TLargeintField
      FieldName = 'ID_PRODUTO'
      Origin = 'ID_PRODUTO'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object QryCadastroQUANTIDADE: TBCDField
      FieldName = 'QUANTIDADE'
      Origin = 'QUANTIDADE'
      ProviderFlags = [pfInUpdate]
      Required = True
      Precision = 18
    end
    object QryCadastroVALOR: TBCDField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      ProviderFlags = [pfInUpdate]
      Required = True
      Precision = 18
    end
    object QryCadastroNOME_PRODUTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME_PRODUTO'
      Origin = 'NOME'
      ProviderFlags = []
      Size = 60
    end
  end
end
