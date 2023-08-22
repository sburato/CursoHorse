inherited ServiceProdutos: TServiceProdutos
  inherited mtPesquisa: TFDMemTable
    object mtPesquisaid: TLargeintField
      FieldName = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object mtPesquisanome: TStringField
      FieldName = 'nome'
      Size = 60
    end
    object mtPesquisavalor: TBCDField
      FieldName = 'valor'
      Precision = 18
    end
    object mtPesquisastatus: TSmallintField
      Alignment = taLeftJustify
      FieldName = 'status'
      OnGetText = mtPesquisastatusGetText
    end
    object mtPesquisaestoque: TBCDField
      FieldName = 'estoque'
      Precision = 18
    end
  end
  inherited mtCadastro: TFDMemTable
    AfterInsert = mtCadastroAfterInsert
    object mtCadastroid: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object mtCadastronome: TStringField
      FieldName = 'nome'
      ProviderFlags = [pfInUpdate]
      Size = 60
    end
    object mtCadastrovalor: TBCDField
      FieldName = 'valor'
      ProviderFlags = [pfInUpdate]
      Precision = 18
    end
    object mtCadastrostatus: TSmallintField
      FieldName = 'status'
      ProviderFlags = [pfInUpdate]
    end
    object mtCadastroestoque: TBCDField
      FieldName = 'estoque'
      ProviderFlags = [pfInUpdate]
      Precision = 18
    end
  end
end
