unit untDMAuth;

interface

uses
  System.SysUtils,
  System.Classes,
  System.IniFiles,
  Vcl.Forms;

type
  TauthDataModule = class(TDataModule)
  private
    { Private declarations }

    function getConfig(pSection, pParamn, pValue: string): string;
    procedure setConfig(pSection, pParam, pValue: string);
    const
      FileConfigName = 'Financeiro.cfg';
  public
    { Public declarations }

    function DateLastLogin: string; overload;
    procedure DateLastLogin(pValue: TDateTime); overload;
    function UserLastLogin: string; overload;
    procedure UserLastLogin(pvalue: string); overload;
  end;

var
  authDataModule: TauthDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TauthDataModule.DateLastLogin: string;
begin
  Result := getConfig('Access', 'Date', '')
end;

procedure TauthDataModule.DateLastLogin(pValue: TDateTime);
begin
  setConfig('Access', 'Date', DateToStr(pValue))
end;

function TauthDataModule.getConfig(pSection, pParamn, pValue: string): string;
var
  FileConfig: TIniFile;
begin
  FileConfig := TIniFile.Create(ExtractFilePath(Application.ExeName) + FileConfigName);
  try
    result := FileConfig.ReadString(pSection, pParamn, pValue);
  finally
    FileConfig.Free
  end;
end;

procedure TauthDataModule.setConfig(pSection, pParam, pValue: string);
var
  FileConfig: TIniFile;
begin
  FileConfig := TIniFile.Create(ExtractFilePath(Application.ExeName) + FileConfigName);
  try
    FileConfig.WriteString(pSection, pParam, pValue);
  finally
    FileConfig.Free;
  end;
end;

function TauthDataModule.UserLastLogin: string;
begin
  Result := getConfig('Access', 'User', '');
end;

procedure TauthDataModule.UserLastLogin(pvalue: string);
begin
  setConfig('Access', 'User', pvalue);
end;

end.

