unit untDMUser;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Datasnap.Provider,
  Datasnap.DBClient,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  untDMBase,
  BCrypt;

type
  TuserDataModule = class(TDataModule)
    FDQueryUser: TFDQuery;
    ClientDataSet: TClientDataSet;
    DataSetProvider: TDataSetProvider;
    ClientDataSetid_user: TAutoIncField;
    ClientDataSetname: TStringField;
    ClientDataSetlogin: TStringField;
    ClientDataSetpassword: TStringField;
    ClientDataSetstatus: TStringField;
    ClientDataSetcreate_date: TDateField;
    ClientDataSetdelete_date: TDateField;
    ClientDataSettemp_password: TStringField;
  private
    { Private declarations }

    FpAuthUserName: string;
    FpAuthUserLogin: string;
    FpAuthUserId: string;
    FpTempPassword: string;
    procedure SetpAuthUserName(const Value: string);
    procedure SetpAuthUserLogin(const Value: string);
    procedure SetpAuthUserId(const Value: string);
    procedure SetpTempPassword(const Value: string);
  public
    { Public declarations }

    function hasLogin(pLogin, pID: string): boolean;
    procedure startLogin(pLogin, pPassword: string);
    procedure resetPasswordToDefault(pID: string);
    procedure verifyPassword(pID, pPassword: string);
    procedure changePassword(pID, pNewPassword: string);
    property pAuthUserName: string read FpAuthUserName write SetpAuthUserName;
    property pAuthUserLogin: string read FpAuthUserLogin write SetpAuthUserLogin;
    property pAuthUserId: string read FpAuthUserId write SetpAuthUserId;
    property pTempPassword: string read FpTempPassword write SetpTempPassword;
    const
      TEMP_PASSWORD = '123';
  end;

var
  userDataModule: TuserDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TuserDataModule.changePassword(pID, pNewPassword: string);
var
  vSQL: TFDQuery;
begin
  vSQL := TFDQuery.Create(nil);

  try
    vSQL.Connection := baseDataModule.FDConnection;
    vSQL.SQL.Clear;
    vSQL.SQL.Add('UPDATE USER SET TEMP_PASSWORD = :TEMP_PASSWORD, PASSWORD = :PASSWORD WHERE ID_USER = :ID');
    vSQL.ParamByName('TEMP_PASSWORD').AsString := 'N';
    vSQL.ParamByName('PASSWORD').AsString := TBCrypt.GenerateHash(pNewPassword);
    vSQL.ParamByName('ID').AsString := pID;
    vSQL.ExecSQL;
  finally
    vSQL.Close;
    vSQL.Free
  end;
end;

function TuserDataModule.hasLogin(pLogin, pID: string): boolean;
var
  vSQL: TFDQuery;
begin
  result := false;
  vSQL := TFDQuery.Create(nil);
  try
    vSQL.Connection := baseDataModule.FDConnection;
    vSQL.SQL.Clear;
    vSQL.SQL.add('SELECT ID_USER FROM USER WHERE LOGIN = :LOGIN');
    vSQL.ParamByName('LOGIN').AsString := pLogin;
    vSQL.Open;

    if not vSQL.IsEmpty then
      Result := vSQL.FieldByName('ID_USER').AsString <> pID;
  finally
    vSQL.Close;
    vSQL.Free;
  end;
end;

procedure TuserDataModule.resetPasswordToDefault(pID: string);
var
  vSQL: TFDQuery;
begin
  vSQL := TFDQuery.Create(nil);

  try
    vSQL.Connection := baseDataModule.FDConnection;
    vSQL.SQL.Clear;
    vSQL.SQL.Add('UPDATE USER SET TEMP_PASSWORD = :TEMP_PASSWORD, PASSWORD = :PASSWORD WHERE ID_USER = :ID');
    vSQL.ParamByName('TEMP_PASSWORD').AsString := 'Y';
    vSQL.ParamByName('PASSWORD').AsString := TBCrypt.GenerateHash(TEMP_PASSWORD);
    vSQL.ParamByName('ID').AsString := pID;
    vSQL.ExecSQL;
  finally
    vSQL.Close;
    vSQL.Free
  end;
end;

procedure TuserDataModule.SetpAuthUserId(const Value: string);
begin
  FpAuthUserId := Value;
end;

procedure TuserDataModule.SetpAuthUserLogin(const Value: string);
begin
  FpAuthUserLogin := Value;
end;

procedure TuserDataModule.SetpAuthUserName(const Value: string);
begin
  FpAuthUserName := Value;
end;

procedure TuserDataModule.SetpTempPassword(const Value: string);
begin
  FpTempPassword := Value;
end;

procedure TuserDataModule.startLogin(pLogin, pPassword: string);
var
  vSQL: TFDQuery;
begin
  vSQL := TFDQuery.Create(nil);
  try
    vSQL.Connection := baseDataModule.FDConnection;
    vSQL.SQL.Clear;
    vSQL.SQL.add('SELECT * FROM USER WHERE LOGIN = :LOGIN');
    vSQL.ParamByName('LOGIN').AsString := pLogin;
    vSQL.Open;

    if vSQL.IsEmpty then
      raise Exception.Create('Usuário e/ou senha Invalidos');
    if vSQL.FieldByName('STATUS').AsString <> 'A' then
      raise Exception.Create('Usuário está desativado');
    if vSQL.FieldByName('DELETE_DATE').AsString <> '' then
      raise Exception.Create('Usuário desligado permanentemente');
    if not TBCrypt.CompareHash(pPassword, vSQL.FieldByName('PASSWORD').AsString) then
      raise Exception.Create('Usuário e/ou senha Invalidos');

    FpAuthUserName := vSQL.FieldByName('NAME').AsString;
    FpAuthUserLogin := vSQL.FieldByName('LOGIN').AsString;
    FpAuthUserId := vSQL.FieldByName('ID_USER').AsString;
    FpTempPassword := vSQL.FieldByName('TEMP_PASSWORD').AsString;
  finally
    vSQL.Close;
    vSQL.Free;
  end;
end;

procedure TuserDataModule.verifyPassword(pID, pPassword: string);
var
  vSQL: TFDQuery;
begin
  vSQL := TFDQuery.Create(nil);
  try
    vSQL.Connection := baseDataModule.FDConnection;
    vSQL.SQL.Clear;
    vSQL.SQL.add('SELECT * FROM USER WHERE ID_USER = :ID');
    vSQL.ParamByName('ID').AsString := pID;
    vSQL.Open;

    if vSQL.IsEmpty then
      raise Exception.Create('Usuário não foi encontrado!');

    if not TBCrypt.CompareHash(pPassword, vSQL.FieldByName('PASSWORD').AsString) then
      raise Exception.Create('Senha inválida');
  finally
    vSQL.Close;
    vSQL.Free;
  end;
end;

end.

