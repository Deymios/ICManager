object ClaimEditorForm: TClaimEditorForm
  Left = 0
  Top = 0
  Caption = 'Claim editor'
  ClientHeight = 174
  ClientWidth = 284
  Color = clBtnFace
  Constraints.MaxHeight = 212
  Constraints.MinHeight = 212
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    284
    174)
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
    Top = 31
    Width = 55
    Height = 13
    Caption = 'Gross Claim'
  end
  object lblDeductible: TLabel
    Left = 8
    Top = 54
    Width = 50
    Height = 13
    Caption = 'Deductible'
  end
  object lblNeClaim: TLabel
    Left = 8
    Top = 77
    Width = 45
    Height = 13
    Caption = 'Net Claim'
  end
  object lblYear: TLabel
    Left = 8
    Top = 100
    Width = 22
    Height = 13
    Caption = 'Year'
  end
  object lblType: TLabel
    Left = 8
    Top = 123
    Width = 24
    Height = 13
    Caption = 'Type'
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
    Top = 28
    Width = 203
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 261
  end
  object edtDeductible: TEdit
    Left = 77
    Top = 51
    Width = 203
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 261
  end
  object edtNetClaim: TEdit
    Left = 77
    Top = 74
    Width = 203
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clBtnFace
    Enabled = False
    TabOrder = 3
    ExplicitWidth = 261
  end
  object edtYear: TEdit
    Left = 77
    Top = 97
    Width = 203
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 4
    ExplicitWidth = 261
  end
  object cbType: TComboBox
    Left = 80
    Top = 120
    Width = 200
    Height = 21
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvRaised
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 5
    ExplicitWidth = 258
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 142
    Width = 284
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    ExplicitTop = 296
    ExplicitWidth = 346
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
      TabOrder = 0
      ExplicitLeft = 263
    end
    object btnSave: TButton
      Left = 8
      Top = 4
      Width = 75
      Height = 25
      Action = actSave
      TabOrder = 1
    end
  end
  object aclButtons: TActionList
    Left = 152
    Top = 16
    object actSave: TAction
      Caption = 'Save'
    end
    object actCancel: TAction
      Caption = 'Cancel'
    end
  end
end
