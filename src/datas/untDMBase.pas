unit untDMBase;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.VCLUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  Vcl.Forms,
  Vcl.Dialogs;

type
  TbaseDataModule = class(TDataModule)
    FDConnection: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }

    const
      CONFIGFILE = 'Financeiro.cfg';
  public
    { Public declarations }

    procedure LoadConfig;
    procedure connect;
    procedure disconnect;
  end;

var
  baseDataModule: TbaseDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

procedure TbaseDataModule.connect;
begin
  FDConnection.Connected := true;
end;

procedure TbaseDataModule.DataModuleCreate(Sender: TObject);
begin
  try
    LoadConfig;
  except
    on E: Exception do
    begin
      MessageDlg(E.Message + ' Verfique!', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
      Application.Terminate;
    end;
  end;
  connect;
end;

procedure TbaseDataModule.disconnect;
begin
  FDConnection.Connected := false;
end;

procedure TbaseDataModule.LoadConfig;
var
  iCount: Integer;
  stParmaList: TStringList;
  sParamnName, sParamnValue, ConfigFilePath: string;
begin
  ConfigFilePath := ExtractFilePath(ParamStr(0)) + CONFIGFILE;

  FDConnection.Params.Clear;
  if not FileExists(ConfigFilePath) then
    raise Exception.Create('Arquivo de Configuração não encontrado.');

  stParmaList := TStringList.Create;
  try
    stParmaList.LoadFromFile(ConfigFilePath);
    for iCount := 0 to stParmaList.Count - 1 do
    begin
      if stParmaList[iCount].IndexOf('=') > 0 then
      begin
        sParamnName := stParmaList[iCount].Split(['='])[0].Trim;
        sParamnValue := stParmaList[iCount].Split(['='])[1].Trim;
        FDConnection.Params.Add(sParamnName + '=' + sParamnValue);
      end;
    end;
  finally
    stParmaList.Free
  end;
end;

end.

