program ICManager;

uses
  Vcl.Forms,
  frmMain in 'frmMain.pas' {MainForm},
  frmClaimEditor in 'classes\editors\frmClaimEditor.pas' {ClaimEditorForm},
  uClaim in 'classes\objects\uClaim.pas',
  uUnitOfWork in 'classes\general\uUnitOfWork.pas',
  uBaseObject in 'classes\objects\uBaseObject.pas',
  uClaimType in 'classes\objects\uClaimType.pas',
  uObjectListHelper in 'classes\general\uObjectListHelper.pas',
  uEditorIntf in 'classes\editors\uEditorIntf.pas';

{$R *.res}

begin
  UnitOfWork.InitConnection('FILE NAME=ICManager.udl');

  UnitOfWork.ClaimTypeRepository.GetAll;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TClaimEditorForm, ClaimEditorForm);
  Application.Run;
end.
