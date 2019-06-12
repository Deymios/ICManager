unit frmClaimEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TClaimEditorForm = class(TForm)
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ClaimEditorForm: TClaimEditorForm;

implementation

{$R *.dfm}

end.
