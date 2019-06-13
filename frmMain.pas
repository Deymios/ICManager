unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList, Vcl.Menus,
  Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls, uUnitOfWork, uClaimType, System.Generics.Collections,
  frmClaimEditor, uEditorIntf;

type
  TMainForm = class(TForm)
    pnlButtons: TPanel;
    btnNewClaim: TButton;
    pnlGrid: TPanel;
    grdClaims: TStringGrid;
    pmClaims: TPopupMenu;
    aclClaims: TActionList;
    actAddClaim: TAction;
    actDeleteClaim: TAction;
    actEditClaim: TAction;
    miDeleteClaim: TMenuItem;
    miEditClaim: TMenuItem;
    procedure actAddClaimExecute(Sender: TObject);
    procedure actDeleteClaimExecute(Sender: TObject);
    procedure actEditClaimExecute(Sender: TObject);
    procedure actDeleteClaimUpdate(Sender: TObject);
    procedure actEditClaimUpdate(Sender: TObject);
  private
    FClaimsEditor: TClaimEditorForm;
    FClaimTypes: TObjectList<TClaimType>;
  private
    procedure LoadClaimTypes;
    procedure FillHeader;
    procedure FillData;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

var
  MainForm: TMainForm;

implementation

uses
  uClaim,
  uObjectListHelper;

{$R *.dfm}

{ TMainForm }

procedure TMainForm.actAddClaimExecute(Sender: TObject);
var
  Claim: TClaim;
begin
  Claim := TClaim.Create;
  try
    if FClaimsEditor.Open(Claim, TEditorMode.Add) then
    begin
      UnitOfWork.ClaimRepository.Add(Claim);
      FillData;
    end;
  finally
    Claim.Free;
  end;
end;

procedure TMainForm.actDeleteClaimExecute(Sender: TObject);
var
  ClaimId: Integer;
begin
  ClaimId := StrToInt(grdClaims.Cells[6, grdClaims.Row]);
  UnitOfWork.ClaimRepository.Delete(ClaimId);
  FillData;
end;

procedure TMainForm.actDeleteClaimUpdate(Sender: TObject);
begin
  actDeleteClaim.Enabled := grdClaims.Row > 0;
end;

procedure TMainForm.actEditClaimExecute(Sender: TObject);
var
  Claim: TClaim;
begin
  Claim := UnitOfWork.ClaimRepository.Get(StrToInt(grdClaims.Cells[6, grdClaims.Row]));
  if FClaimsEditor.Open(Claim, TEditorMode.Edit) then
  begin
    UnitOfWork.ClaimRepository.Update(Claim);
    FillData;
  end;
end;

procedure TMainForm.actEditClaimUpdate(Sender: TObject);
begin
  actEditClaim.Enabled := grdClaims.Row > 0;
end;

procedure TMainForm.AfterConstruction;
begin
  inherited;

  FClaimsEditor := TClaimEditorForm.Create(nil);

  LoadClaimTypes;
  FillHeader;
  FillData;
end;

procedure TMainForm.BeforeDestruction;
begin
  inherited;

  FClaimsEditor.Free;
  FClaimTypes.Free;
end;

procedure TMainForm.FillData;
var
  i: Integer;
  ClaimList: TObjectList<TClaim>;
  ClaimType: TClaimType;
begin
  ClaimList := UnitOfWork.ClaimRepository.GetAll;
  if ClaimList = nil then
    Exit;

  try
    grdClaims.RowCount := ClaimList.Count + 1;
    for i := 0 to ClaimList.Count - 1 do
    begin
      grdClaims.Cells[0, i + 1] := ClaimList[i].Name;
      grdClaims.Cells[1, i + 1] := FormatCurr('0.##', ClaimList[i].GrossClaim);
      grdClaims.Cells[2, i + 1] := FormatCurr('0.##', ClaimList[i].Deductible);
      grdClaims.Cells[3, i + 1] := FormatCurr('0.##', ClaimList[i].NetClaim);
      grdClaims.Cells[4, i + 1] := ClaimList[i].Year.ToString;

      ClaimType := TObjectListHelper.FindById<TClaimType>(FClaimTypes, ClaimList[i].ClaimType);
      if ClaimType <> nil then
        grdClaims.Cells[5, i + 1] := ClaimType.Name
      else
        grdClaims.Cells[5, i + 1] := 'Unknown';

      grdClaims.Cells[6, i + 1] := ClaimList[i].Id.ToString;
    end;
  finally
    ClaimList.Free;
  end;
end;

procedure TMainForm.FillHeader;
begin
  grdClaims.Cells[0, 0] := 'Name';
  grdClaims.Cells[1, 0] := 'Gross Claim';
  grdClaims.Cells[2, 0] := 'Deductible';
  grdClaims.Cells[3, 0] := 'Net Claim';
  grdClaims.Cells[4, 0] := 'Year';
  grdClaims.Cells[5, 0] := 'Type';
end;

procedure TMainForm.LoadClaimTypes;
begin
  FClaimTypes := UnitOfWork.ClaimTypeRepository.GetAll;
end;

end.
