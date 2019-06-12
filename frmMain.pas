unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList, Vcl.Menus,
  Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls;

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
  private
    { Private declarations }
  public
    procedure AfterConstruction; override;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

{ TMainForm }

procedure TMainForm.AfterConstruction;
begin
  inherited;

  grdClaims.Cells[0, 0] := 'Name';
  grdClaims.Cells[1, 0] := 'Gross Claim';
  grdClaims.Cells[1, 0] := 'Deductible';
  grdClaims.Cells[1, 0] := 'Net Claim';
  grdClaims.Cells[1, 0] := 'Year';
  grdClaims.Cells[1, 0] := 'Type';
end;

end.
