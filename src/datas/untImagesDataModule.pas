unit untImagesDataModule;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList,
  Vcl.Controls;

type
  TdmIcons = class(TDataModule)
    imgLicons24x: TImageList;
  private
    { Private declarations }

  public
    { Public declarations }

  end;

var
  dmIcons: TdmIcons;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
