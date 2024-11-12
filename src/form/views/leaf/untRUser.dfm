inherited frmRegisterUser: TfrmRegisterUser
  Caption = 'Usu'#225'rios'
  ClientWidth = 788
  ExplicitWidth = 800
  TextHeight = 15
  inherited cpContainer: TCardPanel
    Width = 788
    ExplicitWidth = 784
    inherited crdRegister: TCard
      Width = 788
      ExplicitWidth = 788
      object Label1: TLabel [0]
        Left = 10
        Top = 10
        Width = 33
        Height = 15
        Caption = 'Nome'
      end
      object Label2: TLabel [1]
        Left = 10
        Top = 58
        Width = 30
        Height = 15
        Caption = 'Login'
      end
      object Label5: TLabel [2]
        Left = 688
        Top = 58
        Width = 32
        Height = 15
        Caption = 'Status'
      end
      object Label3: TLabel [3]
        Left = 276
        Top = 58
        Width = 32
        Height = 15
        Caption = 'Senha'
        Enabled = False
      end
      object Label4: TLabel [4]
        Left = 482
        Top = 58
        Width = 85
        Height = 15
        Caption = 'Confirma Senha'
        Enabled = False
      end
      inherited p3_RFooter: TPanel
        Width = 788
        ExplicitWidth = 788
        inherited pnlAux: TPanel
          Left = 597
          ExplicitLeft = 597
        end
      end
      object edtName: TEdit
        Left = 10
        Top = 25
        Width = 768
        Height = 23
        TabOrder = 1
      end
      object edtLogin: TEdit
        Left = 10
        Top = 73
        Width = 260
        Height = 23
        CharCase = ecUpperCase
        TabOrder = 2
      end
      object tgswStatus: TToggleSwitch
        Left = 688
        Top = 73
        Width = 92
        Height = 20
        StateCaptions.CaptionOn = '&Ativo'
        StateCaptions.CaptionOff = '&Inativo'
        TabOrder = 3
      end
      object edtPassword: TEdit
        Left = 276
        Top = 73
        Width = 200
        Height = 23
        Enabled = False
        TabOrder = 4
      end
      object edtConfirmPassword: TEdit
        Left = 482
        Top = 73
        Width = 200
        Height = 23
        Enabled = False
        TabOrder = 5
      end
    end
    inherited crdSearch: TCard
      Width = 788
      ExplicitWidth = 784
      inherited p1_SHeader: TPanel
        Width = 788
        ExplicitWidth = 784
        inherited pnlSearch: TPanel
          Left = 125
          ExplicitLeft = 121
          inherited btnSearch: TButton
            OnClick = btnSearchClick
          end
        end
        inherited pnlButtons: TPanel
          Width = 125
          ExplicitWidth = 121
        end
      end
      inherited p2_SBody: TPanel
        Width = 788
        ExplicitWidth = 784
        inherited DBGridBase: TDBGrid
          Width = 788
          DataSource = DataSourceBase
          Columns = <
            item
              Expanded = False
              FieldName = 'id_user'
              Title.Caption = 'ID'
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'name'
              Title.Caption = 'Nome'
              Width = 331
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'login'
              Title.Caption = 'Login'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'status'
              Title.Caption = 'Status'
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'create_date'
              Title.Caption = 'Data de Cria'#231#227'o'
              Width = 100
              Visible = True
            end>
        end
      end
      inherited p3_SFooter: TPanel
        Width = 788
        ExplicitWidth = 784
      end
    end
  end
  inherited DataSourceBase: TDataSource
    DataSet = userDataModule.ClientDataSet
  end
  inherited PopupMenuBase: TPopupMenu
    object pmnClearPassword: TMenuItem
      Caption = '&Limpar senha'
      OnClick = pmnClearPasswordClick
    end
  end
end
