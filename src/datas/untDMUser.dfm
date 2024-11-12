object userDataModule: TuserDataModule
  Height = 183
  Width = 134
  object FDQueryUser: TFDQuery
    Connection = baseDataModule.FDConnection
    SQL.Strings = (
      '')
    Left = 50
  end
  object ClientDataSet: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider'
    Left = 50
    Top = 51
    object ClientDataSetid_user: TAutoIncField
      FieldName = 'id_user'
      Origin = 'id_user'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object ClientDataSetname: TStringField
      FieldName = 'name'
      Origin = 'name'
      Required = True
      FixedChar = True
      Size = 32767
    end
    object ClientDataSetlogin: TStringField
      FieldName = 'login'
      Origin = 'login'
      Required = True
      FixedChar = True
      Size = 32767
    end
    object ClientDataSetpassword: TStringField
      FieldName = 'password'
      Origin = 'password'
      Required = True
      FixedChar = True
      Size = 60
    end
    object ClientDataSetstatus: TStringField
      FieldName = 'status'
      Origin = 'status'
      Required = True
      FixedChar = True
      Size = 1
    end
    object ClientDataSetcreate_date: TDateField
      FieldName = 'create_date'
      Origin = 'create_date'
    end
    object ClientDataSetdelete_date: TDateField
      FieldName = 'delete_date'
      Origin = 'delete_date'
    end
    object ClientDataSettemp_password: TStringField
      FieldName = 'temp_password'
      FixedChar = True
      Size = 1
    end
  end
  object DataSetProvider: TDataSetProvider
    DataSet = FDQueryUser
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 50
    Top = 102
  end
end
