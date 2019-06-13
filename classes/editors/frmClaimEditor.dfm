object ClaimEditorForm: TClaimEditorForm
  Left = 0
  Top = 0
  Caption = 'Claim editor'
  ClientHeight = 200
  ClientWidth = 284
  Color = clBtnFace
  Constraints.MaxHeight = 238
  Constraints.MinHeight = 238
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    284
    200)
  PixelsPerInch = 96
  TextHeight = 13
  object lblId: TLabel
    Left = 8
    Top = 8
    Width = 10
    Height = 13
    Caption = 'Id'
  end
  object lblGrossClaim: TLabel
    Left = 8
    Top = 54
    Width = 55
    Height = 13
    Caption = 'Gross Claim'
  end
  object lblDeductible: TLabel
    Left = 8
    Top = 77
    Width = 50
    Height = 13
    Caption = 'Deductible'
  end
  object lblNeClaim: TLabel
    Left = 8
    Top = 100
    Width = 45
    Height = 13
    Caption = 'Net Claim'
  end
  object lblYear: TLabel
    Left = 8
    Top = 123
    Width = 22
    Height = 13
    Caption = 'Year'
  end
  object lblType: TLabel
    Left = 8
    Top = 146
    Width = 24
    Height = 13
    Caption = 'Type'
  end
  object lblName: TLabel
    Left = 8
    Top = 31
    Width = 27
    Height = 13
    Caption = 'Name'
  end
  object edtId: TEdit
    Left = 77
    Top = 5
    Width = 203
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clBtnFace
    Enabled = False
    TabOrder = 0
  end
  object edtGrossClaim: TEdit
    Left = 77
    Top = 51
    Width = 203
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 2
  end
  object edtDeductible: TEdit
    Left = 77
    Top = 74
    Width = 203
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 3
  end
  object edtNetClaim: TEdit
    Left = 77
    Top = 97
    Width = 203
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clBtnFace
    Enabled = False
    TabOrder = 4
  end
  object edtYear: TEdit
    Left = 77
    Top = 120
    Width = 203
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 5
  end
  object cbType: TComboBox
    Left = 77
    Top = 143
    Width = 203
    Height = 21
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvRaised
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 6
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 168
    Width = 284
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 7
    ExplicitTop = 142
    DesignSize = (
      284
      32)
    object btnCancel: TButton
      Left = 205
      Top = 4
      Width = 75
      Height = 25
      Action = actCancel
      Anchors = [akTop, akRight]
      TabOrder = 1
    end
    object btnSave: TButton
      Left = 8
      Top = 4
      Width = 75
      Height = 25
      Action = actSave
      TabOrder = 0
    end
  end
  object edtName: TEdit
    Left = 77
    Top = 28
    Width = 203
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 1
  end
  object aclButtons: TActionList
    Left = 152
    Top = 16
    object actSave: TAction
      Caption = 'Save'
      OnExecute = actSaveExecute
    end
    object actCancel: TAction
      Caption = 'Cancel'
      OnExecute = actCancelExecute
    end
  end
end
