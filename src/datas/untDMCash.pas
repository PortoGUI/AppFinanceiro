unit untDMCash;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Datasnap.Provider,
  Data.DB, Datasnap.DBClient, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TCashDataModule = class(TDataModule)
    FDQueryCash: TFDQuery;
    ClientDataSet: TClientDataSet;
    DataSetProvider: TDataSetProvider;
    ClientDataSetid_cash: TAutoIncField;
    ClientDataSetdoc_number: TStringField;
    ClientDataSetdescription: TStringField;
    ClientDataSetvalue: TFloatField;
    ClientDataSettype: TStringField;
    ClientDataSetcreate_date: TDateField;
    ClientDataSetdelete_date: TDateField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CashDataModule: TCashDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
