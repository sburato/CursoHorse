object ProvidersConnection: TProvidersConnection
  OldCreateOrder = False
  Height = 270
  Width = 249
  object FDConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=Curso_Pooled')
    LoginPrompt = False
    Left = 112
    Top = 40
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 112
    Top = 104
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Console'
    Left = 112
    Top = 176
  end
end
