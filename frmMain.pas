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
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

end.
