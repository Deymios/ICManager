program ICManager;

uses
  Vcl.Forms,
  frmMain in 'frmMain.pas' {MainForm},
  frmClaimEditor in 'classes\editors\frmClaimEditor.pas' {ClaimEditorForm},
  uClaim in 'classes\objects\uClaim.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TClaimEditorForm, ClaimEditorForm);
  Application.Run;
end.
