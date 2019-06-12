object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Insurance Claim Handling'
  ClientHeight = 337
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlButtons: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object btnNewClaim: TButton
      Left = 8
      Top = 9
      Width = 97
      Height = 25
      Action = actAddClaim
      TabOrder = 0
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 41
    Width = 635
    Height = 296
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 40
    object grdClaims: TStringGrid
      Left = 0
      Top = 0
      Width = 635
      Height = 296
      Align = alClient
      ColCount = 6
      DefaultColWidth = 100
      DrawingStyle = gdsGradient
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goRowSelect]
      TabOrder = 0
      ExplicitTop = -1
    end
  end
  object pmClaims: TPopupMenu
    Left = 544
    Top = 49
    object miDeleteClaim: TMenuItem
      Action = actDeleteClaim
    end
    object miEditClaim: TMenuItem
      Action = actEditClaim
    end
  end
  object aclClaims: TActionList
    Left = 584
    Top = 49
    object actAddClaim: TAction
      Caption = 'New Claim'
    end
    object actDeleteClaim: TAction
      Caption = 'Delete'
    end
    object actEditClaim: TAction
      Caption = 'Edit...'
    end
  end
end
