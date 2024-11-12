unit untSearch;

interface

uses
  Vcl.DBGrids,
  System.SysUtils,
  MZLib;

type
  TSearchUtil = class
    class function LikeFind(pValue: string; pGrid: TDBGrid): string;
  end;

implementation

{ TSearchUtil }

class function TSearchUtil.LikeFind(pValue: string; pGrid: TDBGrid): string;
var
  count: Integer;
begin
  Result := '';
  if pValue.Trim.isEmpty then
  begin
    exit
  end
  else
  begin
    for count := 0 to Pred(pGrid.Columns.Count) do
    begin
      Result := Result + pGrid.Columns.Items[count].FieldName + ' LIKE ' + QuotedStr('%' + Trim(pValue) + '%') + ' OR ';
    end;

    Result := ' WHERE ' + Copy(Result, 1, Length(Result) - 4);
  end;
end;

end.

