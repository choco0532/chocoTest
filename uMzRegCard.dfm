object FMzRegCard: TFMzRegCard
  Left = 636
  Top = 178
  Width = 457
  Height = 390
  Caption = #23458#26381#22238#35775#35760#24405
  Color = clWindow
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object lblTitle: TLabel
    Left = 0
    Top = 0
    Width = 449
    Height = 37
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = #35786#30103#21345#24555#36895#21457#21345
    Color = 16776178
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlue
    Font.Height = -19
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object Shape1: TShape
    Left = 0
    Top = 37
    Width = 449
    Height = 1
    Align = alTop
    Pen.Color = clGreen
  end
  object grp01: TGroupBox
    Left = 0
    Top = 38
    Width = 449
    Height = 289
    Align = alClient
    Caption = #35786#30103#21345#22522#30784#20449#24687
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 70
      Height = 18
      AutoSize = False
      Caption = #21345#21495'  '
    end
    object Label2: TLabel
      Left = 190
      Top = 24
      Width = 70
      Height = 18
      AutoSize = False
      Caption = #21345'ID '
    end
    object Label3: TLabel
      Left = 16
      Top = 56
      Width = 70
      Height = 18
      AutoSize = False
      Caption = #22995#21517
    end
    object Label4: TLabel
      Left = 190
      Top = 56
      Width = 70
      Height = 18
      AutoSize = False
      Caption = #31867#21035
      Visible = False
    end
    object Label5: TLabel
      Left = 16
      Top = 92
      Width = 70
      Height = 18
      AutoSize = False
      Caption = #30005#35805
    end
    object Label6: TLabel
      Left = 16
      Top = 128
      Width = 70
      Height = 18
      AutoSize = False
      Caption = #22320#22336
    end
    object Label7: TLabel
      Left = 190
      Top = 128
      Width = 70
      Height = 18
      AutoSize = False
      Caption = #36523#20221#35777#21495
    end
    object lblMSG: TLabel
      Left = 2
      Top = 274
      Width = 445
      Height = 13
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
    end
    object edtCardNo: TEdit
      Left = 54
      Top = 21
      Width = 130
      Height = 21
      Ctl3D = False
      Enabled = False
      ParentCtl3D = False
      TabOrder = 0
    end
    object edtCardID: TEdit
      Left = 252
      Top = 21
      Width = 180
      Height = 21
      Ctl3D = False
      Enabled = False
      ParentCtl3D = False
      TabOrder = 1
    end
    object edtName: TEdit
      Left = 54
      Top = 53
      Width = 130
      Height = 21
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 2
    end
    object cbbType: TComboBox
      Left = 252
      Top = 53
      Width = 180
      Height = 23
      Ctl3D = False
      ItemHeight = 15
      ParentCtl3D = False
      TabOrder = 3
      Visible = False
    end
    object edtTelePhone: TEdit
      Left = 54
      Top = 89
      Width = 130
      Height = 21
      Ctl3D = False
      MaxLength = 11
      ParentCtl3D = False
      TabOrder = 4
    end
    object edtAddress: TEdit
      Left = 54
      Top = 125
      Width = 130
      Height = 21
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 5
    end
    object edtIDNO: TEdit
      Left = 252
      Top = 125
      Width = 180
      Height = 21
      Ctl3D = False
      MaxLength = 18
      ParentCtl3D = False
      TabOrder = 6
    end
    object pnl1: TPanel
      Left = 8
      Top = 160
      Width = 433
      Height = 65
      Caption = 'pnl1'
      TabOrder = 7
      Visible = False
      object Label9: TLabel
        Left = 190
        Top = 23
        Width = 70
        Height = 18
        AutoSize = False
        Caption = #29983#26085
      end
      object Label8: TLabel
        Left = 16
        Top = 23
        Width = 49
        Height = 18
        AutoSize = False
        Caption = #24615#21035
      end
      object dtpBirthday: TDateTimePicker
        Left = 245
        Top = 18
        Width = 180
        Height = 23
        CalAlignment = dtaLeft
        Date = 0.641797395830508
        Time = 0.641797395830508
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 0
      end
      object rb2: TRadioButton
        Left = 120
        Top = 24
        Width = 57
        Height = 17
        Caption = #22899
        TabOrder = 1
      end
      object rb1: TRadioButton
        Left = 56
        Top = 24
        Width = 57
        Height = 17
        Caption = #30007
        Checked = True
        TabOrder = 2
        TabStop = True
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 327
    Width = 449
    Height = 32
    Align = alBottom
    BevelOuter = bvLowered
    Color = clWindow
    TabOrder = 1
    object Shape2: TShape
      Left = 1
      Top = 1
      Width = 447
      Height = 1
      Align = alTop
      Pen.Color = clGreen
    end
    object btnSave: TsuiButton
      Left = 18
      Top = 5
      Width = 63
      Height = 24
      Hint = 'save'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      Caption = #20445' '#23384
      AutoSize = False
      ParentFont = False
      UIStyle = WinXP
      TabOrder = 0
      Transparent = False
      ModalResult = 0
      FocusedRectMargin = 2
      Layout = blGlyphLeft
      Spacing = 4
      MouseContinuouslyDownInterval = 100
      OnClick = btnSaveClick
      ResHandle = 0
    end
    object btnExit: TsuiButton
      Left = 348
      Top = 5
      Width = 63
      Height = 24
      Hint = 'close'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      Caption = #20851' '#38381
      AutoSize = False
      ParentFont = False
      UIStyle = WinXP
      TabOrder = 2
      Transparent = False
      ModalResult = 0
      FocusedRectMargin = 2
      Layout = blGlyphLeft
      Spacing = 4
      MouseContinuouslyDownInterval = 100
      OnClick = btnExitClick
      ResHandle = 0
    end
    object btnReadIDCard: TsuiButton
      Tag = 3
      Left = 103
      Top = 5
      Width = 83
      Height = 24
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      Caption = #20108#20195#36523#20221#35777
      AutoSize = False
      Visible = False
      ParentFont = False
      UIStyle = WinXP
      TabOrder = 1
      Transparent = False
      ModalResult = 0
      FocusedRectMargin = 2
      Layout = blGlyphLeft
      Spacing = 2
      MouseContinuouslyDownInterval = 100
      ResHandle = 0
    end
    object edtEncryptCardNo: TEdit
      Left = 104
      Top = 6
      Width = 227
      Height = 21
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 3
    end
  end
  object adoConn: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 160
  end
  object qryCard: TADOQuery
    Connection = adoConn
    Parameters = <>
    Left = 216
  end
  object qryCardDetail: TADOQuery
    Connection = adoConn
    Parameters = <>
    Left = 280
  end
  object qryTemp: TADOQuery
    Connection = adoConn
    Parameters = <>
    Left = 344
  end
  object tmrclose: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tmrcloseTimer
    Left = 120
  end
  object spGetNextVoucher: TADOStoredProc
    Connection = adoConn
    ProcedureName = 'pMzGetNextVoucher;1'
    Parameters = <
      item
        Name = '@iFlag'
        Attributes = [paNullable]
        DataType = ftSmallint
        Precision = 5
        Value = Null
      end
      item
        Name = '@bMustSeria'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end
      item
        Name = '@cTyBh'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 20
        Value = Null
      end>
    Left = 128
    Top = 266
  end
end
