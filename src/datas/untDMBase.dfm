object baseDataModule: TbaseDataModule
  OnCreate = DataModuleCreate
  Height = 600
  Width = 800
  object FDConnection: TFDConnection
    Params.Strings = (
      'LockingMode=Normal'
      
        'Database=C:\Users\Hexa\Documents\Projetos\Modulo3_2\install\data' +
        'base\database.db'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 8
  end
end
