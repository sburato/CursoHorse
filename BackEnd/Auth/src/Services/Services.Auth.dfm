inherited ServiceAuth: TServiceAuth
  OldCreateOrder = True
  Width = 326
  object QryLogin: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select'
      '   u.id,'
      '   u.senha'
      'from usuario u'
      'where'
      '      u.login = :login'
      '   and'
      '      u.status = 1')
    Left = 232
    Top = 40
    ParamData = <
      item
        Name = 'LOGIN'
        DataType = ftString
        ParamType = ptInput
        Size = 30
        Value = Null
      end>
    object QryLoginID: TLargeintField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryLoginSENHA: TStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Required = True
      Size = 256
    end
  end
end
