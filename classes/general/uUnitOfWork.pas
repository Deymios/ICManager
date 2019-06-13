unit uUnitOfWork;

interface

uses
  uBaseObject,
  uClaim,
  uClaimType,
  System.Generics.Collections,
  System.Generics.Defaults;

type
  IRepository<T: TDBObject> = interface
    function GetAll(): TObjectList<T>;
    function Get(AId: Integer): T;
    procedure Add(ATarget: T);
    procedure Update(ATarget: T);
    procedure Delete(ATarget: T); overload;
    procedure Delete(AId: Integer); overload;
  end;

  IUnitOfWork = interface
    procedure InitConnection(AConnectionString: string);

    function ClaimRepository: IRepository<TClaim>;
    function ClaimTypeRepository: IRepository<TClaimType>;
  end;

  function UnitOfWork: IUnitOfWork;

implementation

uses
  Data.Win.ADODB,
  System.SysUtils,
  System.Variants;

type
  TRepository = class(TSingletonImplementation)
  protected
    FConnection: TADOConnection;
    FStoredProc: TADOStoredProc;
  public
    constructor Create(AConnection: TADOConnection);
    destructor Destroy; override;
  end;

  TClaimTypeRepository = class(TRepository, IRepository<TClaimType>)
  public
    function GetAll(): TObjectList<TClaimType>;
    function Get(AId: Integer): TClaimType;
    procedure Add(ATarget: TClaimType);
    procedure Update(ATarget: TClaimType);
    procedure Delete(ATarget: TClaimType); overload;
    procedure Delete(AId: Integer); overload;
  end;

  TClaimRepository = class(TRepository, IRepository<TClaim>)
  public
    function GetAll(): TObjectList<TClaim>;
    function Get(AId: Integer): TClaim;
    procedure Add(ATarget: TClaim);
    procedure Update(ATarget: TClaim);
    procedure Delete(ATarget: TClaim); overload;
    procedure Delete(AId: Integer); overload;
  end;

  TUnitOfWork = class sealed(TSingletonImplementation, IUnitOfWork)
  private
    class var FInstance: TUnitOfWork;

    FConnection: TADOConnection;
    FClaimTypesRepository: TClaimTypeRepository;
    FClaimRepository: TClaimRepository;
  public
    procedure InitConnection(AConnectionString: string);

    function ClaimRepository: IRepository<TClaim>;
    function ClaimTypeRepository: IRepository<TClaimType>;

    constructor Create;
    destructor Destroy; override;
  end;

function UnitOfWork: IUnitOfWork;
begin
  if not Assigned(TUnitOfWork.FInstance) then
    TUnitOfWork.FInstance := TUnitOfWork.Create;

  Result := TUnitOfWork.FInstance;
end;

{ TRepository }

constructor TRepository.Create(AConnection: TADOConnection);
begin
  FConnection := AConnection;

  FStoredProc := TADOStoredProc.Create(nil);
  FStoredProc.Connection := AConnection;
end;

destructor TRepository.Destroy;
begin
  FStoredProc.Close;
  FStoredProc.Free;

  inherited;
end;

{ TClaimTypeRepository }

procedure TClaimTypeRepository.Add(ATarget: TClaimType);
begin
  raise ENotImplemented.Create('Not implemented yet');
end;

procedure TClaimTypeRepository.Delete(ATarget: TClaimType);
begin
  raise ENotImplemented.Create('Not implemented yet');
end;

procedure TClaimTypeRepository.Delete(AId: Integer);
begin
  raise ENotImplemented.Create('Not implemented yet');
end;

function TClaimTypeRepository.Get(AId: Integer): TClaimType;
begin
  Result := nil;

  FStoredProc.ProcedureName := 'dbo.LoadClaimTypes';
  FStoredProc.Parameters.Refresh;
  FStoredProc.Parameters.ParamByName('@Id').Value := AId;
  FStoredProc.Open;
  try
    if FStoredProc.RecordCount > 0 then
    begin
      Result := TClaimType.Create;
      Result.Id := FStoredProc.FieldByName('Id').AsInteger;
      Result.Name := FStoredProc.FieldByName('Name').AsString;
    end;
  finally
    FStoredProc.Close;
  end;
end;

function TClaimTypeRepository.GetAll: TObjectList<TClaimType>;
var
  ClaimType: TClaimType;
begin
  Result := nil;

  FStoredProc.ProcedureName := 'dbo.LoadClaimTypes';
  FStoredProc.Parameters.Refresh;
  FStoredProc.Parameters.ParamByName('@Id').Value := null;
  FStoredProc.Open;
  try
    if FStoredProc.RecordCount > 0 then
    begin
      Result := TObjectList<TClaimType>.Create(True);

      while not FStoredProc.Eof do
      begin
        ClaimType := TClaimType.Create;
        ClaimType.Id := FStoredProc.FieldByName('Id').AsInteger;
        ClaimType.Name := FStoredProc.FieldByName('Name').AsString;

        Result.Add(ClaimType);

        FStoredProc.Next;
      end;
    end;
  finally
    FStoredProc.Close;
  end;
end;

procedure TClaimTypeRepository.Update(ATarget: TClaimType);
begin
  raise ENotImplemented.Create('Not implemented yet');
end;

{ TUnitOfWork }

function TUnitOfWork.ClaimRepository: IRepository<TClaim>;
begin
  Result := FClaimRepository;
end;

function TUnitOfWork.ClaimTypeRepository: IRepository<TClaimType>;
begin
  Result := FClaimTypesRepository;
end;

constructor TUnitOfWork.Create;
begin
  FConnection := TADOConnection.Create(nil);
  FClaimTypesRepository := TClaimTypeRepository.Create(FConnection);
  FClaimRepository := TClaimRepository.Create(FConnection);
end;

destructor TUnitOfWork.Destroy;
begin
  FConnection.Close;
  FConnection.Free;

  FClaimTypesRepository.Free;
  FClaimRepository.Free;

  inherited;
end;

procedure TUnitOfWork.InitConnection(AConnectionString: string);
begin
  FConnection.ConnectionString := AConnectionString;
  FConnection.Open();
end;

{ TClaimRepository }

procedure TClaimRepository.Add(ATarget: TClaim);
begin
  if not (ATarget.Modified and (ATarget.Id = 0)) then
    Exit;

  FStoredProc.ProcedureName := 'dbo.AddClaim';
  FStoredProc.Parameters.Refresh;
  FStoredProc.Parameters.ParamByName('@Name').Value := ATarget.Name;
  FStoredProc.Parameters.ParamByName('@GrossClaim').Value := ATarget.GrossClaim;
  FStoredProc.Parameters.ParamByName('@Deductible').Value := ATarget.Deductible;
  FStoredProc.Parameters.ParamByName('@Year').Value := ATarget.Year;
  FStoredProc.Parameters.ParamByName('@Type').Value := ATarget.ClaimType;
  FStoredProc.ExecProc;
end;

procedure TClaimRepository.Delete(ATarget: TClaim);
begin
  if ATarget.Id > 0 then
    Delete(ATarget.Id)
  else
    raise Exception.Create('Target identifier not specified');
end;

procedure TClaimRepository.Delete(AId: Integer);
begin
  FStoredProc.ProcedureName := 'dbo.DeleteClaim';
  FStoredProc.Parameters.Refresh;
  FStoredProc.Parameters.ParamByName('@Id').Value := AId;
  FStoredProc.ExecProc;
end;

function TClaimRepository.Get(AId: Integer): TClaim;
begin
  Result := nil;

  FStoredProc.ProcedureName := 'dbo.LoadClaims';
  FStoredProc.Parameters.Refresh;
  FStoredProc.Parameters.ParamByName('@Id').Value := AId;
  FStoredProc.Open;
  try
    if FStoredProc.RecordCount > 0 then
    begin
      Result := TClaim.Create;
      Result.Id := FStoredProc.FieldByName('Id').AsInteger;
      Result.Name := FStoredProc.FieldByName('Name').AsString;
      Result.GrossClaim := FStoredProc.FieldByName('GrossClaim').AsCurrency;
      Result.Deductible := FStoredProc.FieldByName('Deductible').AsCurrency;
      Result.Year := FStoredProc.FieldByName('Year').AsInteger;
      Result.ClaimType := FStoredProc.FieldByName('Type').AsInteger;
      end;
  finally
    FStoredProc.Close;
  end;
end;

function TClaimRepository.GetAll: TObjectList<TClaim>;
var
  Claim: TClaim;
begin
  Result := nil;

  FStoredProc.ProcedureName := 'dbo.LoadClaims';
  FStoredProc.Parameters.Refresh;
  FStoredProc.Parameters.ParamByName('@Id').Value := null;
  FStoredProc.Open;
  try
    if FStoredProc.RecordCount > 0 then
    begin
      Result := TObjectList<TClaim>.Create(True);

      while not FStoredProc.Eof do
      begin
        Claim := TClaim.Create;
        Claim.Id := FStoredProc.FieldByName('Id').AsInteger;
        Claim.Name := FStoredProc.FieldByName('Name').AsString;
        Claim.GrossClaim := FStoredProc.FieldByName('GrossClaim').AsCurrency;
        Claim.Deductible := FStoredProc.FieldByName('Deductible').AsCurrency;
        Claim.Year := FStoredProc.FieldByName('Year').AsInteger;
        Claim.ClaimType := FStoredProc.FieldByName('Type').AsInteger;

        Result.Add(Claim);

        FStoredProc.Next;
      end;
    end;
  finally
    FStoredProc.Close;
  end;
end;

procedure TClaimRepository.Update(ATarget: TClaim);
begin
  if not (ATarget.Modified and (ATarget.Id > 0)) then
    Exit;

  FStoredProc.ProcedureName := 'dbo.UpdateClaim';
  FStoredProc.Parameters.Refresh;
  FStoredProc.Parameters.ParamByName('@Id').Value := ATarget.Id;
  FStoredProc.Parameters.ParamByName('@Name').Value := ATarget.Name;
  FStoredProc.Parameters.ParamByName('@GrossClaim').Value := ATarget.GrossClaim;
  FStoredProc.Parameters.ParamByName('@Deductible').Value := ATarget.Deductible;
  FStoredProc.Parameters.ParamByName('@Year').Value := ATarget.Year;
  FStoredProc.Parameters.ParamByName('@Type').Value := ATarget.ClaimType;
  FStoredProc.ExecProc;
end;

initialization

finalization
  TUnitOfWork.FInstance.Free;

end.
