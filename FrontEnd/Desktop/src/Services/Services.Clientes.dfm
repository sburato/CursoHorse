inherited ServiceClientes: TServiceClientes
  inherited mtPesquisa: TFDMemTable
    object mtPesquisaid: TIntegerField
      FieldName = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object mtPesquisanome: TStringField
      FieldName = 'nome'
      ProviderFlags = [pfInUpdate]
      Size = 500
    end
    object mtPesquisastatus: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'status'
      ProviderFlags = [pfInUpdate]
      OnGetText = mtPesquisastatusGetText
    end
  end
  inherited mtCadastro: TFDMemTable
    AfterInsert = mtCadastroAfterInsert
    object mtCadastroid: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object mtCadastronome: TStringField
      FieldName = 'nome'
      ProviderFlags = [pfInUpdate]
      Size = 500
    end
    object mtCadastrostatus: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'status'
      ProviderFlags = [pfInUpdate]
    end
  end
end
