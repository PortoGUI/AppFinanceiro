unit untAppConfig;

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
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  GraphicEx,
  GR32_Image;

type
  TfrmAppConfig = class(TForm)
    { Private declarations }
    pnlMain: TPanel;
    lblAction: TLabel;
    tmConfig: TTimer;
    Image321: TImage32;
    Image322: TImage32;
    Image323: TImage32;
    Image324: TImage32;
    procedure tmConfigTimer(Sender: TObject);
  private
    count: Integer;
    procedure updateStatus(message: string; img: TImage32);
    procedure imageDefaultVisible;
  public
    { Public declarations }
  end;

var
  frmAppConfig: TfrmAppConfig;

implementation

{$R *.dfm}

procedure TfrmAppConfig.imageDefaultVisible;
begin
  Image321.Visible := false;
  Image322.Visible := false;
  Image323.Visible := false;
  Image324.Visible := false;
end;

procedure TfrmAppConfig.tmConfigTimer(Sender: TObject);
begin
  if count <= 100 then
  begin
    count := count + 1;
    case count of
      10:
        updateStatus('Carregando dependências.....', Image321);
      25:
        updateStatus('Conectando com o banco de dados.....', Image322);
      45:
        updateStatus('Concluindo configurações.....', Image323);
      75:
        updateStatus('Configurações concluidas, inicializando a aplicação.....', Image324);
    end;
    if count = 100 then
      Close;
  end;
end;

procedure TfrmAppConfig.updateStatus(message: string; img: TImage32);
begin
  lblAction.Caption := message;
  imageDefaultVisible;
  img.Visible := True;
end;

end.

