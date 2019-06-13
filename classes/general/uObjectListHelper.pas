unit uObjectListHelper;

interface

uses
  uBaseObject,
  System.Generics.Collections;

type
  TObjectListHelper = class
    class function FindById<T: TDBObject>(AList: TObjectList<T>; AId: Integer): T;
  end;

implementation

{ TObjectListHelper }

class function TObjectListHelper.FindById<T>(AList: TObjectList<T>;
  AId: Integer): T;
var
  Item: T;
begin
  Result := nil;

  for Item in AList do
    if TDBObject(Item).Id = AId then
      Exit(Item);
end;

end.
