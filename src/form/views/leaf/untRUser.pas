unit untRUser;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  untRegisterBase,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.WinXPanels,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  untDMUser,
  Vcl.WinXCtrls,
  System.SysUtils,
  untMessage,
  untDMBase,
  BCrypt,
  Vcl.Menus;

type
  TfrmRegisterUser = class(TfrmRegisterBase)
    edtName: TEdit;
    edtLogin: TEdit;
    tgswStatus: TToggleSwitch;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    pmnClearPassword: TMenuItem;
    edtPassword: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    edtConfirmPassword: TEdit;
    procedure btnEditClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure pmnClearPasswordClick(Sender: TObject);
  private
    { Private declarations }
    procedure formValidate;
  public
    { Public declarations }

  protected
    { Protected declarations }

    procedure search; override;

  end;

var
  frmRegisterUser: TfrmRegisterUser;

implementation

uses
  untSearch;

{$R *.dfm}

procedure TfrmRegisterUser.btnEditClick(Sender: TObject);
begin
  inherited;

  edtName.Text := userDataModule.ClientDataSetname.AsString;
  edtLogin.Text := userDataModule.ClientDataSetlogin.AsString;

  tgswStatus.State := tssOn;
  if userDataModule.ClientDataSetstatus.AsString = 'I' then
    tgswStatus.State := tssOff;
end;

procedure TfrmRegisterUser.btnSaveClick(Sender: TObject);
var
  sStatus: string;
begin
  formValidate;

  if tgswStatus.State = tssOff then
    sStatus := 'I'
  else
    sStatus := 'A';

  if userDataModule.ClientDataSet.State in [dsInsert] then
  begin
    userDataModule.ClientDataSetpassword.AsString := TBCrypt.GenerateHash(userDataModule.TEMP_PASSWORD);
    userDataModule.ClientDataSettemp_password.AsString := 'Y';
  end;

  userDataModule.ClientDataSetname.AsString := Trim(edtName.Text);
  userDataModule.ClientDataSetlogin.AsString := Trim(edtLogin.Text);
  userDataModule.ClientDataSetstatus.AsString := sStatus;
  inherited;
end;

procedure TfrmRegisterUser.btnSearchClick(Sender: TObject);
begin
  inherited;
  search;
end;

procedure TfrmRegisterUser.formValidate;
var
  sMessage: string;
begin
  if edtLogin.Text = '' then
  begin
    edtLogin.SetFocus;
    sMessage := sMessage + 'Campo [ Login ] está vazio';
  end
  else
  begin
    if userdatamodule.hasLogin(trim(edtLogin.Text), userDataModule.ClientDataSet.FieldByName('ID_USER').AsString) then
    begin
      edtLogin.SetFocus;
      sMessage := sMessage + 'Esse login já pertence a outro usuário, tente outro';
      edtLogin.Clear;
    end;
  end;

  if edtName.Text = '' then
  begin
    edtName.SetFocus;
    sMessage := sMessage + 'Campo [ Nome ] está vazio';
  end;

  if sMessage <> '' then
  begin
    mDialogUtils(tWarning, sMessage);
    abort;
  end;
end;

procedure TfrmRegisterUser.pmnClearPasswordClick(Sender: TObject);
begin
  inherited;
  if not DataSourceBase.DataSet.IsEmpty then
  begin
    userDataModule.resetPasswordToDefault(DataSourceBase.DataSet.FieldByName('ID_USER').AsString);
    mDialogUtils(tInfo, 'A senha deste usuario foi redefinida para uma senha padrão');
  end;
end;

procedure TfrmRegisterUser.search;
var
  searchFilter, ExpressionAux: string;
begin
  searchFilter := TSearchUtil.LikeFind(edtSearch.Text, DBGridBase);

  if searchFilter.IsEmpty then
    ExpressionAux := ' WHERE '
  else
    ExpressionAux := ' AND ';

  userDataModule.ClientDataSet.Close;
  userDataModule.ClientDataSet.CommandText := 'SELECT * FROM USER ' + searchFilter + ExpressionAux + 'DELETE_DATE IS NULL';
  userDataModule.ClientDataSet.Open;
  inherited;
end;

end.

