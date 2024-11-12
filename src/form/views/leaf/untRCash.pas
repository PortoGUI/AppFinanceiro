unit untRCash;

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
  untRegisterBase,
  Data.DB,
  Vcl.Menus,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.WinXPanels,
  untSearch,
  untDMCash,
  untMessage;

type
  TfrmRegisterCash = class(TfrmRegisterBase)
    Label1: TLabel;
    edtDocument: TEdit;
    Label2: TLabel;
    edtDescription: TEdit;
    Label3: TLabel;
    edtValue: TEdit;
    rgType: TRadioGroup;
    procedure btnSaveClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
  private
    { Private declarations }
    procedure formValidate;
  public
    { Public declarations }
  protected
    procedure search; override;
  end;

var
  frmRegisterCash: TfrmRegisterCash;

implementation

{$R *.dfm}

{ TfrmRegisterBase1 }

procedure TfrmRegisterCash.btnEditClick(Sender: TObject);
begin
  inherited;

  edtDocument.Text := CashDataModule.ClientDataSetdoc_number.AsString;
  edtDescription.Text := CashDataModule.ClientDataSetdescription.AsString;
  edtValue.Text := FloatToStr(CashDataModule.ClientDataSetvalue.AsFloat);

  if CashDataModule.ClientDataSettype.AsString = 'R' then
    rgType.ItemIndex := 0
  else
    rgType.ItemIndex := 1;
end;

procedure TfrmRegisterCash.btnSaveClick(Sender: TObject);
var
  typeCash: string;
begin
  formValidate;

  typeCash := 'R';
  if rgType.ItemIndex = 1 then
    typeCash := 'E';

  if DataSourceBase.State in [dsInsert] then
  begin
    CashDataModule.ClientDataSetcreate_date.AsDateTime := Now;
  end;

  CashDataModule.ClientDataSetdoc_number.AsString := Trim(edtDocument.Text);
  CashDataModule.ClientDataSetdescription.AsString := Trim(edtDescription.Text);
  CashDataModule.ClientDataSetvalue.AsCurrency := StrToFloat((edtValue.Text));
  CashDataModule.ClientDataSettype.AsString := typeCash;

  inherited;
end;

procedure TfrmRegisterCash.formValidate;
var
  sMessage: string;
begin
  if edtDocument.Text = '' then
  begin
    edtDocument.SetFocus;
    sMessage := sMessage + 'Campo [ Documento ] está vazio';
  end;

  if edtDescription.Text = '' then
  begin
    edtDescription.SetFocus;
    sMessage := sMessage + 'Campo [ Descrição ] está vazio';
  end;

  if edtValue.Text = '' then
  begin
    edtValue.SetFocus;
    sMessage := sMessage + 'Campo [ Valor ] está vazio';
  end;

  if rgType.ItemIndex = -1 then
  begin
    sMessage := sMessage + 'Campo [ Tipo ] não selecionado';
  end;

  if sMessage <> '' then
  begin
    mDialogUtils(tWarning, sMessage);
    abort;
  end;
end;

procedure TfrmRegisterCash.search;
var
  searchFilter, ExpressionAux: string;
begin
  searchFilter := TSearchUtil.LikeFind(edtSearch.Text, DBGridBase);

  if searchFilter.IsEmpty then
    ExpressionAux := ' WHERE '
  else
    ExpressionAux := ' AND ';

  cashDataModule.ClientDataSet.Close;
  cashDataModule.ClientDataSet.CommandText := 'SELECT * FROM CASH ' + searchFilter + ExpressionAux + 'DELETE_DATE IS NULL';
  cashDataModule.ClientDataSet.Open;
  inherited;
end;

end.

