object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Financeiro'
  ClientHeight = 562
  ClientWidth = 788
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = mmRegister
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  TextHeight = 15
  object sbMain: TStatusBar
    Left = 0
    Top = 546
    Width = 788
    Height = 16
    Panels = <
      item
        Alignment = taCenter
        Width = 150
      end
      item
        Width = 300
      end>
    ExplicitTop = 545
    ExplicitWidth = 784
  end
  object mmRegister: TMainMenu
    Left = 737
    Top = 511
    object mRegister: TMenuItem
      Caption = '&Cadastros'
      object mRUser: TMenuItem
        Caption = '&Usu'#225'rios'
        OnClick = mRUserClick
      end
    end
    object Financeiro1: TMenuItem
      Caption = '&Financeiro'
      object mFCash: TMenuItem
        Caption = 'Caixa'
        OnClick = mFCashClick
      end
    end
    object mReport: TMenuItem
      Caption = '&Relat'#243'rios'
    end
    object mHelp: TMenuItem
      Caption = '&Ajuda'
    end
  end
  object tmDate: TTimer
    OnTimer = tmDateTimer
    Left = 10
    Top = 510
  end
end
