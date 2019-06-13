unit uClaim;

interface

uses
  uBaseObject;

type
  TClaim = class(TDBObject)
  private
    FName: string;
    FGrossClaim: Currency;
    FDeductible: Currency;
    FYear: Integer;
    FClaimType: Integer;
    procedure SetName(const Value: string);
    procedure SetGrossClaim(const Value: Currency);
    procedure SetDeductible(const Value: Currency);
    function GetNetClaim: Currency;
    procedure SetYear(const Value: Integer);
    procedure SetClaimType(const Value: Integer);
  public
    procedure Reset; override;
  public
    property Name: string read FName write SetName;
    property GrossClaim: Currency read FGrossClaim write SetGrossClaim;
    property Deductible: Currency read FDeductible write SetDeductible;
    property NetClaim: Currency read GetNetClaim;
    property Year: Integer read FYear write SetYear;
    property ClaimType: Integer read FClaimType write SetClaimType;
  end;

implementation

{ TClaim }

function TClaim.GetNetClaim: Currency;
begin
  Result := FGrossClaim - FDeductible;
end;

procedure TClaim.Reset;
begin
  FName := '';
  FGrossClaim := 0;
  FDeductible := 0;
  FYear := 0;
  FClaimType := 0;
end;

procedure TClaim.SetClaimType(const Value: Integer);
begin
  FClaimType := AlterProperty(FClaimType, Value);
end;

procedure TClaim.SetDeductible(const Value: Currency);
begin
  FDeductible := AlterProperty(FDeductible, Value);
end;

procedure TClaim.SetGrossClaim(const Value: Currency);
begin
  FGrossClaim := AlterProperty(FGrossClaim, Value);
end;

procedure TClaim.SetName(const Value: string);
begin
  FName := AlterProperty(FName, Value);
end;

procedure TClaim.SetYear(const Value: Integer);
begin
  FYear := AlterProperty(FYear, Value);
end;

end.
