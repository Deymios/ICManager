unit frmClaimEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.StdCtrls, uEditorIntf, uClaim, uClaimType, System.Generics.Collections;

type
  TClaimEditorForm = class(TForm, IEditor<TClaim>)
    edtId: TEdit;
    lblId: TLabel;
    lblGrossClaim: TLabel;
    lblDeductible: TLabel;
    lblNeClaim: TLabel;
    lblYear: TLabel;
    lblType: TLabel;
    edtGrossClaim: TEdit;
    edtDeductible: TEdit;
    edtNetClaim: TEdit;
    edtYear: TEdit;
    cbType: TComboBox;
    btnSave: TButton;
    btnCancel: TButton;
    pnlButtons: TPanel;
    aclButtons: TActionList;
    actSave: TAction;
    actCancel: TAction;
    lblName: TLabel;
    edtName: TEdit;
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
  private
    FMode: TEditorMode;
    FTarget: TClaim;
    FClaimTypes: TObjectList<TClaimType>;
  private
    procedure Init;
    procedure AssignFormFields;
    procedure AssignObjectFields;
  public
    function Open(ATarget: TClaim; AMode: TEditorMode): Boolean;
    function IsSatisfy: Boolean;

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

var
  ClaimEditorForm: TClaimEditorForm;

implementation

uses
  uUnitOfWork,
  uObjectListHelper;

{$R *.dfm}

{ TClaimEditorForm }

procedure TClaimEditorForm.actCancelExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TClaimEditorForm.actSaveExecute(Sender: TObject);
begin
  if IsSatisfy then
  begin
    AssignObjectFields;
    ModalResult := mrOk;
  end;
end;

procedure TClaimEditorForm.AfterConstruction;
begin
  inherited;

  FClaimTypes := UnitOfWork.ClaimTypeRepository.GetAll;
end;

procedure TClaimEditorForm.AssignFormFields;
var
  i: Integer;
begin
  edtId.Text := FTarget.Id.ToString;
  edtGrossClaim.Text := FormatCurr('0.##', FTarget.GrossClaim);
  edtDeductible.Text := FormatCurr('0.##', FTarget.Deductible);
  edtNetClaim.Text := FormatCurr('0.##', FTarget.NetClaim);
  edtYear.Text := FTarget.Year.ToString;
  edtName.Text := FTarget.Name;

  if FTarget.ClaimType > 0 then
  begin
    for i := 0 to cbType.Items.Count - 1 do
      if FTarget.ClaimType = Integer(cbType.Items.Objects[i]) then
        cbType.ItemIndex := i;
  end
  else
    cbType.ItemIndex := 0;

end;

procedure TClaimEditorForm.AssignObjectFields;
begin
  FTarget.Name := edtName.Text;
  FTarget.GrossClaim := StrToCurr(edtGrossClaim.Text);
  FTarget.Deductible := StrToCurr(edtDeductible.Text);
  FTarget.Year := StrToInt(edtYear.Text);
  FTarget.ClaimType := Integer(cbType.Items.Objects[cbType.ItemIndex]);
end;

procedure TClaimEditorForm.BeforeDestruction;
begin
  FClaimTypes.Free;

  inherited;
end;

procedure TClaimEditorForm.Init;
var
  ClaimType: TClaimType;
begin
  for ClaimType in FClaimTypes do
  begin
    cbType.Items.AddObject(ClaimType.Name, TObject(ClaimType.Id));
  end;
end;

function TClaimEditorForm.IsSatisfy: Boolean;
begin
  Result := True;
end;

function TClaimEditorForm.Open(ATarget: TClaim; AMode: TEditorMode): Boolean;
begin
  FTarget := ATarget;
  FMode := AMode;

  Init;
  AssignFormFields;
  Result := ShowModal = mrOk;
end;

end.
