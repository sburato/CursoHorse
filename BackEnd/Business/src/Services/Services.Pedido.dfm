inherited ServicePedido: TServicePedido
  inherited QryPesquisa: TFDQuery
    SQL.Strings = (
      'select'
      '   p.id,'
      '   p.id_cliente,'
      '   p.id_usuario,'
      '   p.data,'
      '   c.nome as nome_cliente'
      'from pedido p'
      '  left outer join cliente c on (c.id = p.id_cliente)'
      'where'
      '   1 = 1')
    object QryPesquisaID: TLargeintField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryPesquisaID_CLIENTE: TLargeintField
      FieldName = 'ID_CLIENTE'
      Origin = 'ID_CLIENTE'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object QryPesquisaID_USUARIO: TLargeintField
      FieldName = 'ID_USUARIO'
      Origin = 'ID_USUARIO'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object QryPesquisaDATA: TSQLTimeStampField
      FieldName = 'DATA'
      Origin = '"DATA"'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object QryPesquisaNOME_CLIENTE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME_CLIENTE'
      Origin = 'NOME'
      ProviderFlags = []
      Size = 60
    end
  end
  inherited QryRecordCount: TFDQuery
    SQL.Strings = (
      'select count(p.id) from pedido p'
      '  left outer join cliente c on (c.id = p.id_cliente)'
      'where'
      '   1 = 1')
  end
  inherited QryCadastro: TFDQuery
    AfterInsert = QryCadastroAfterInsert
    SQL.Strings = (
      'select'
      '   p.id,'
      '   p.id_cliente,'
      '   p.id_usuario,'
      '   p.data,'
      '   c.nome as nome_cliente'
      'from pedido p'
      '  left outer join cliente c on (c.id = p.id_cliente)')
    object QryCadastroID: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryCadastroID_CLIENTE: TLargeintField
      FieldName = 'ID_CLIENTE'
      Origin = 'ID_CLIENTE'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object QryCadastroID_USUARIO: TLargeintField
      FieldName = 'ID_USUARIO'
      Origin = 'ID_USUARIO'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object QryCadastroDATA: TSQLTimeStampField
      FieldName = 'DATA'
      Origin = '"DATA"'
      ProviderFlags = [pfInUpdate]
    end
    object QryCadastroNOME_CLIENTE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME_CLIENTE'
      Origin = 'NOME'
      ProviderFlags = []
      Size = 60
    end
  end
end
