unit uClaimType;

interface

uses
  uBaseObject, System.Generics.Collections;

type
  TClaimType = class(TDBObject)
  private
    FName: string;

    procedure SetName(const Value: string);
  public
    procedure Reset; override;
  public
    property Name: string read FName write SetName;
  end;

implementation

{ TClaimType }

procedure TClaimType.Reset;
begin
  FName := '';
end;

procedure TClaimType.SetName(const Value: string);
begin
  FName := AlterProperty(FName, Value);
end;

end.
