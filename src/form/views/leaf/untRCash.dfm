inherited frmRegisterCash: TfrmRegisterCash
  TextHeight = 15
  inherited cpContainer: TCardPanel
    inherited crdRegister: TCard
      object Label1: TLabel [0]
        Left = 10
        Top = 10
        Width = 63
        Height = 15
        Caption = 'Documento'
      end
      object Label2: TLabel [1]
        Left = 216
        Top = 10
        Width = 51
        Height = 15
        Caption = 'Descri'#231#227'o'
      end
      object Label3: TLabel [2]
        Left = 583
        Top = 10
        Width = 26
        Height = 15
        Caption = 'Valor'
      end
      object edtDocument: TEdit
        Left = 10
        Top = 25
        Width = 200
        Height = 23
        TabOrder = 1
      end
      object edtDescription: TEdit
        Left = 216
        Top = 25
        Width = 360
        Height = 23
        TabOrder = 2
      end
      object edtValue: TEdit
        Left = 583
        Top = 25
        Width = 190
        Height = 23
        TabOrder = 3
      end
      object rgType: TRadioGroup
        Left = 10
        Top = 54
        Width = 200
        Height = 51
        Caption = 'Tipo'
        Columns = 2
        Items.Strings = (
          'Receita'
          'Despesa')
        TabOrder = 4
      end
    end
    inherited crdSearch: TCard
      inherited p2_SBody: TPanel
        inherited DBGridBase: TDBGrid
          DataSource = DataSourceBase
          Columns = <
            item
              Expanded = False
              FieldName = 'id_cash'
              Title.Caption = 'ID'
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'doc_number'
              Title.Caption = 'Documento'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'description'
              Title.Caption = 'Descri'#231#227'o'
              Width = 367
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'value'
              Title.Caption = 'Valor'
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'type'
              Title.Caption = 'Tipo'
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'create_date'
              Title.Caption = 'Data Lan'#231'amento'
              Width = 100
              Visible = True
            end>
        end
      end
    end
  end
  inherited DataSourceBase: TDataSource
    DataSet = CashDataModule.ClientDataSet
  end
end
