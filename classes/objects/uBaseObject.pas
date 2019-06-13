unit uBaseObject;

interface

type
  TBaseObject = class
  private
    FModified: Boolean;
  protected
    function AlterProperty<T>(AOldValue: T; ANewValue: T): T;
  public
    procedure Reset; virtual;
  public
    property Modified: Boolean read FModified;
  end;

  TDBObject = class(TBaseObject)
  private
    FId: Integer;

    procedure SetId(const Value: Integer);
  public
    procedure Reset; override;
  public
    property Id: Integer read FId write SetId;
  end;

implementation

uses
  System.Generics.Defaults;

{ TBaseObject }

function TBaseObject.AlterProperty<T>(AOldValue, ANewValue: T): T;
var
  EqualityComparer: IEqualityComparer<T>;
begin
  EqualityComparer := TEqualityComparer<T>.Default;

  if not EqualityComparer.Equals(AOldValue, ANewValue) then
  begin
    FModified := True;
    Result := ANewValue;
  end
  else
    Result := ANewValue;
end;

procedure TBaseObject.Reset;
begin
  FModified := False;
end;

{ TDBObject }

procedure TDBObject.Reset;
begin
  inherited;

  FId := 0;
end;

procedure TDBObject.SetId(const Value: Integer);
begin
  FId := AlterProperty(FId, Value);
end;

end.
