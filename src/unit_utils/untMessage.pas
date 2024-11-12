unit untMessage;

interface

uses
  Winapi.Windows,
  Vcl.Forms;

type
  TMessage = (tWarning, tError, tInfo);

procedure mDialogUtils(pType: TMessage; text: string);

function mDialogQuestionUtils(text: string): boolean;

implementation

procedure mDialogUtils(pType: TMessage; text: string);
begin
  if pType = tWarning then
    Application.MessageBox(PChar(text + '.'), 'Attention', MB_ICONWARNING + MB_OK);

  if pType = tError then
    Application.MessageBox(PChar(text + '.'), 'Error', MB_ICONERROR + MB_OK);

  if pType = tInfo then
    Application.MessageBox(PChar(text + '.'), 'Information', MB_ICONINFORMATION + MB_OK);
end;

function mDialogQuestionUtils(text: string): boolean;
begin
  Result := Application.MessageBox(PChar(text + '?'), 'Question', MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON2) = IDYES;
end;

end.

