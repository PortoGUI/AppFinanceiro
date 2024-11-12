unit untMain;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Menus,
  untAppConfig,
  untRUser,
  untLogin,
  Vcl.ComCtrls,
  untDMUser,
  Vcl.ExtCtrls,
  untRedefinePassword;

type
  TfrmMain = class(TForm)
    mmRegister: TMainMenu;
    mRegister: TMenuItem;
    mReport: TMenuItem;
    mHelp: TMenuItem;
    mRUser: TMenuItem;
    sbMain: TStatusBar;
    tmDate: TTimer;
    Financeiro1: TMenuItem;
    mFCash: TMenuItem;
    procedure mRUserClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmDateTimer(Sender: TObject);
    procedure mFCashClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }

  end;

var
  frmMain: TfrmMain;

implementation

uses
  untRCash;

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  frmAppConfig := TfrmAppConfig.Create(nil);
  try
    frmAppConfig.ShowModal;
  finally
    FreeAndNil(frmAppConfig);
  end;

  frmLogin := TfrmLogin.Create(nil);
  try
    frmLogin.ShowModal;
    if frmLogin.ModalResult <> mrOK then
      Application.Terminate;
  finally
    FreeAndNil(frmlogin);
  end;

  if userDataModule.pTempPassword = 'Y' then
  begin
    frmRedefinePassword := TfrmRedefinePassword.Create(nil);
    try
      frmRedefinePassword.ShowModal;
      if frmRedefinePassword.ModalResult <> mrOK then
      begin
        Application.Terminate;
      end;
    finally
      FreeAndNil(frmlogin);
    end;
  end;

  sbMain.Panels.Items[1].Text := 'Usuário: ' + userDataModule.pAuthUserName;
end;

procedure TfrmMain.mFCashClick(Sender: TObject);
begin
  frmRegisterCash.showModal;
end;

procedure TfrmMain.mRUserClick(Sender: TObject);
begin
  frmRegisterUser.ShowModal
end;

procedure TfrmMain.tmDateTimer(Sender: TObject);
begin
  sbMain.Panels.Items[0].Text := DateTimeToStr(Now);
end;

end.

