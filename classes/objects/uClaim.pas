unit uClaim;

interface

type
  TClaim = class
  private
    FModified: Boolean;

    FId: Integer;
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
  private
    function AlterProperty<T>(AOldValue: T; ANewValue: T): T;
  public
    property Id: Integer read FId;
    property Name: string read FName write SetName;
    property GrossClaim: Currency read FGrossClaim write SetGrossClaim;
    property Deductible: Currency read FDeductible write SetDeductible;
    property NetClaim: Currency read GetNetClaim;
    property Year: Integer read FYear write SetYear;
    property ClaimType: Integer read FClaimType write SetClaimType;
  end;

implementation

{ TClaim }

function TClaim.AlterProperty<T>(AOldValue, ANewValue: T): T;
begin
  if AOldValue <> ANewValue then
  begin
    FModified := True;
    Result := ANewValue;
  end
  else
    Result := ANewValue;
end;

function TClaim.GetNetClaim: Currency;
begin
  Result := FGrossClaim - FDeductible;
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
