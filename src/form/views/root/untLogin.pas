unit untLogin;

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
  GR32_Image,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  untImagesDataModule,
  untMessage,
  untDMUser,
  untDMAuth,
  GraphicEx;

type
  TfrmLogin = class(TForm)
    pnlFormContainer: TPanel;
    pnlImageContainer: TPanel;
    imgLogin: TImage32;
    lblLogin: TLabel;
    lbPassword: TLabel;
    edtLogin: TEdit;
    edtPassword: TEdit;
    btnLogin: TButton;
    imgSysLogin: TImage;
    Label1: TLabel;
    Label2: TLabel;
    StaticText1: TStaticText;
    procedure btnLoginClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtLoginKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtPasswordKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

    procedure keybindsPage(Key: Word);
  public
    { Public declarations }

  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

procedure TfrmLogin.btnLoginClick(Sender: TObject);
begin
  if trim(edtLogin.Text) = '' then
  begin
    edtLogin.SetFocus;
    mDialogUtils(tWarning, 'Campo [ Login ] nao pode estar vazio');
    exit;
  end;

  if trim(edtPassword.Text) = '' then
  begin
    edtPassword.SetFocus;
    mDialogUtils(tWarning, 'Campo [ Senha ] nao pode estar vazio');
    exit;
  end;

  try
    userDataModule.startLogin(trim(edtLogin.Text), trim(edtPassword.Text));
    authDataModule.DateLastLogin(Now);
    authDataModule.UserLastLogin(userDataModule.pAuthUserLogin);
    ModalResult := mrOk;
  except
    on e: Exception do
    begin
      mDialogUtils(tWarning, e.Message)
    end;
  end;
end;

procedure TfrmLogin.edtLoginKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  keybindsPage(Key);
end;

procedure TfrmLogin.edtPasswordKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  keybindsPage(Key);
end;

procedure TfrmLogin.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  keybindsPage(Key);
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  if authDataModule.UserLastLogin <> '' then
  begin
    edtLogin.Text := authDataModule.UserLastLogin;
    edtPassword.SetFocus;
  end;
end;

procedure TfrmLogin.keybindsPage(Key: Word);
begin
  case Key of
    27:
      Application.Terminate;
    13:
      btnLogin.Click;
  end;
end;

end.

