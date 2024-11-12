unit untRegisterBase;

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
  Data.DB,
  Vcl.StdCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ExtCtrls,
  Vcl.WinXPanels,
  System.ImageList,
  Vcl.ImgList,
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
  untImagesDataModule,
  Vcl.Menus,
  Datasnap.DBClient,
  Vcl.WinXCtrls;

type
  TfrmRegisterBase = class(TForm)
    cpContainer: TCardPanel;
    crdRegister: TCard;
    crdSearch: TCard;
    p1_SHeader: TPanel;
    p2_SBody: TPanel;
    p3_SFooter: TPanel;
    DBGridBase: TDBGrid;
    btnSearch: TButton;
    pnlSearch: TPanel;
    pnlButtons: TPanel;
    edtSearch: TEdit;
    btnAdd: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    btnPrint: TButton;
    p3_RFooter: TPanel;
    btnCancel: TButton;
    pnlAux: TPanel;
    btnSave: TButton;
    DataSourceBase: TDataSource;
    PopupMenuBase: TPopupMenu;
    procedure btnAddClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    { Private declarations }

    procedure toggleButtons;
    procedure clearFields;
  public
    { Public declarations }

  protected
  { Protected declarations }

    procedure search; virtual;
  end;

var
  frmRegisterBase: TfrmRegisterBase;

implementation

uses
  untMessage;

{$R *.dfm}

procedure TfrmRegisterBase.btnAddClick(Sender: TObject);
begin
  cpContainer.ActiveCard := crdRegister;
  clearFields;
  TClientDataSet(DataSourceBase.DataSet).Insert;
end;

procedure TfrmRegisterBase.btnCancelClick(Sender: TObject);
begin
  TClientDataSet(DataSourceBase.DataSet).Cancel;
  cpContainer.ActiveCard := crdSearch;
end;

procedure TfrmRegisterBase.btnDeleteClick(Sender: TObject);
begin
  TClientDataSet(DataSourceBase.DataSet).Edit;

  if not mDialogQuestionUtils('Deseja realmente excluir este registro') then
  begin
    exit;
    TClientDataSet(DataSourceBase.DataSet).Cancel;
  end;

  TClientDataSet(DataSourceBase.DataSet).FieldByName('delete_date').AsDateTime := date;
  TClientDataSet(DataSourceBase.DataSet).Post;
  TClientDataSet(DataSourceBase.DataSet).ApplyUpdates(0);
  search;
  mDialogUtils(tInfo, 'Registro excluído com êxito');
end;

procedure TfrmRegisterBase.btnEditClick(Sender: TObject);
begin
  clearFields;
  cpContainer.ActiveCard := crdRegister;
  TClientDataSet(DataSourceBase.DataSet).Edit;
end;

procedure TfrmRegisterBase.btnSaveClick(Sender: TObject);
var
  smessageMode: string;
begin
  if DataSourceBase.State in [dsInsert] then
    smessageMode := 'adicionado'
  else
    smessageMode := 'editado';

  TClientDataSet(DataSourceBase.DataSet).Post;
  TClientDataSet(DataSourceBase.DataSet).ApplyUpdates(0);

  mDialogUtils(tInfo, 'Registro ' + smessageMode + ' com êxito');
  search;
  cpContainer.ActiveCard := crdSearch;
end;

procedure TfrmRegisterBase.clearFields;
var
  iCount: Integer;
begin

  for iCount := 0 to pred(ComponentCount) do
  begin
    if Components[iCount] is TCustomEdit then
      TCustomEdit(Components[iCount]).Clear;

    if Components[iCount] is TToggleSwitch then
      TToggleSwitch(Components[iCount]).State := tssOn;

    if Components[iCount] is TRadioGroup then
      TRadioGroup(Components[iCount]).ItemIndex := -1;
  end;
end;

procedure TfrmRegisterBase.FormShow(Sender: TObject);
begin
  cpContainer.ActiveCard := crdSearch;
  edtSearch.SetFocus;
  search;
end;

procedure TfrmRegisterBase.search;
begin
  toggleButtons;
end;

procedure TfrmRegisterBase.toggleButtons;
begin
  btnEdit.Enabled := not DataSourceBase.DataSet.IsEmpty;
  btnPrint.Enabled := not DataSourceBase.DataSet.IsEmpty;
  btnDelete.Enabled := not DataSourceBase.DataSet.IsEmpty;
end;

end.

