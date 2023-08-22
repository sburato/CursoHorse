inherited ProvidersCadastro: TProvidersCadastro
  OldCreateOrder = True
  Width = 314
  inherited FDConnection: TFDConnection
    Left = 80
  end
  inherited FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 80
    Top = 108
  end
  inherited FDGUIxWaitCursor: TFDGUIxWaitCursor
    Left = 80
  end
  object QryPesquisa: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    Left = 208
    Top = 40
  end
  object QryRecordCount: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    Left = 208
    Top = 108
    object QryRecordCountCOUNT: TIntegerField
      FieldName = 'COUNT'
    end
  end
  object QryCadastro: TFDQuery
    CachedUpdates = True
    Connection = FDConnection
    Left = 208
    Top = 176
  end
end
