unit uEditorIntf;

interface

uses
  uBaseObject;

type
  {$SCOPEDENUMS ON}
  TEditorMode = (Add, Edit);
  {$SCOPEDENUMS OFF}

  IEditor<T: TDBObject> = interface
    function Open(ATarget: T; AMode: TEditorMode): Boolean;
    function IsSatisfy: Boolean;
  end;

implementation

end.
