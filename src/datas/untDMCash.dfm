object CashDataModule: TCashDataModule
  Height = 187
  Width = 142
  object FDQueryCash: TFDQuery
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
    object ClientDataSetid_cash: TAutoIncField
      FieldName = 'id_cash'
      Origin = 'id_cash'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object ClientDataSetdoc_number: TStringField
      FieldName = 'doc_number'
      Origin = 'doc_number'
      Required = True
      FixedChar = True
      Size = 32767
    end
    object ClientDataSetdescription: TStringField
      FieldName = 'description'
      Origin = 'description'
      FixedChar = True
      Size = 32767
    end
    object ClientDataSetvalue: TFloatField
      FieldName = 'value'
      Origin = 'value'
      Required = True
    end
    object ClientDataSettype: TStringField
      FieldName = 'type'
      Origin = 'type'
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
    end
  end
  object DataSetProvider: TDataSetProvider
    DataSet = FDQueryCash
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 50
    Top = 102
  end
end
