unit untRedefinePassword;

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
  Vcl.ExtCtrls,
  GR32_Image,
  GraphicEx,
  Vcl.StdCtrls,
  Vcl.Buttons;

type
  TfrmRedefinePassword = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Image321: TImage32;
    StaticText1: TStaticText;
    imgSysLogin: TImage;
    lblLogin: TLabel;
    edtOldPassword: TEdit;
    lbPassword: TLabel;
    edtNewPassword: TEdit;
    btnSubmit: TButton;
    Label1: TLabel;
    Button1: TButton;
    lblUser: TLabel;
    procedure btnSubmitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRedefinePassword: TfrmRedefinePassword;

implementation

uses
  untDMUser,
  untMessage;

{$R *.dfm}

procedure TfrmRedefinePassword.btnSubmitClick(Sender: TObject);
begin
  ModalResult := mrCancel
end;

procedure TfrmRedefinePassword.Button1Click(Sender: TObject);
begin
  edtOldPassword.text := Trim(edtOldPassword.text);
  edtNewPassword.text := Trim(edtOldPassword.text);

  if edtOldPassword.text = '' then
  begin
    edtOldPassword.SetFocus;
    mDialogUtils(tWarning, 'Campo [ Senha atual ] não pode estar vazio');
  end;

  if edtNewPassword.text = '' then
  begin
    edtNewPassword.SetFocus;
    mDialogUtils(tWarning, 'Defina a sua nova senha para prosseguir');
  end;

  try
    userDataModule.verifyPassword(userDataModule.pAuthUserId, Trim(edtOldPassword.Text));
    userDataModule.changePassword(userDataModule.pAuthUserId, edtNewPassword.text);
    edtOldPassword.Clear;
    edtNewPassword.Clear;
    mDialogUtils(tInfo, 'Senha Alterada, essa janela sera fechada');
    ModalResult := mrOk;
  except
    on e: Exception do
    begin
      mDialogUtils(tWarning, e.Message)
    end;
  end;
end;

procedure TfrmRedefinePassword.FormShow(Sender: TObject);
begin
  lblUser.caption := userDataModule.pAuthUserName;
end;

end.

