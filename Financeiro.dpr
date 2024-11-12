program Financeiro;

uses
  Vcl.Forms,
  untMain in 'src\form\views\root\untMain.pas' {frmMain},
  untRegisterBase in 'src\form\views\root\untRegisterBase.pas' {frmRegisterBase},
  untImagesDataModule in 'src\datas\untImagesDataModule.pas' {dmIcons: TDataModule},
  untAppConfig in 'src\form\views\root\untAppConfig.pas' {frmAppConfig},
  untDMBase in 'src\datas\untDMBase.pas' {baseDataModule: TDataModule},
  untRUser in 'src\form\views\leaf\untRUser.pas' {frmRegisterUser},
  untDMUser in 'src\datas\untDMUser.pas' {userDataModule: TDataModule},
  untMessage in 'src\unit_utils\untMessage.pas',
  untLogin in 'src\form\views\root\untLogin.pas' {frmLogin},
  untDMAuth in 'src\datas\untDMAuth.pas' {authDataModule: TDataModule},
  untRedefinePassword in 'src\form\views\root\untRedefinePassword.pas' {frmRedefinePassword},
  untSearch in 'src\unit_utils\untSearch.pas',
  untDMCash in 'src\datas\untDMCash.pas' {CashDataModule: TDataModule},
  untRCash in 'src\form\views\leaf\untRCash.pas' {frmRegisterCash};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TbaseDataModule, baseDataModule);
  Application.CreateForm(TuserDataModule, userDataModule);
  Application.CreateForm(TCashDataModule, CashDataModule);
  Application.CreateForm(TdmIcons, dmIcons);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmRegisterBase, frmRegisterBase);
  Application.CreateForm(TfrmRegisterUser, frmRegisterUser);
  Application.CreateForm(TauthDataModule, authDataModule);
  Application.CreateForm(TfrmRegisterCash, frmRegisterCash);
  Application.Run;
end.
