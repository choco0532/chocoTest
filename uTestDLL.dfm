object Form1: TForm1
  Left = 685
  Top = 209
  Width = 224
  Height = 195
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 39
    Height = 13
    Caption = #21345#21495'     '
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 66
    Height = 13
    Caption = #36523#20221#35777#21495'      '
  end
  object edtName: TEdit
    Left = 72
    Top = 12
    Width = 121
    Height = 21
    ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
    TabOrder = 0
    Text = '666'
  end
  object edtPhone: TEdit
    Left = 72
    Top = 44
    Width = 121
    Height = 21
    ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
    TabOrder = 1
    Text = '370205196502232236'
  end
  object rb1: TRadioButton
    Left = 8
    Top = 84
    Width = 113
    Height = 17
    Caption = #35786#30103#21345
    Checked = True
    TabOrder = 3
    TabStop = True
  end
  object rb2: TRadioButton
    Left = 72
    Top = 84
    Width = 65
    Height = 17
    Caption = #21307#20445#21345
    TabOrder = 4
  end
  object btnSearch: TButton
    Left = 16
    Top = 120
    Width = 75
    Height = 25
    Caption = #35843#29992'DLL'
    Default = True
    TabOrder = 2
    OnClick = btnSearchClick
  end
  object btnclose: TButton
    Left = 104
    Top = 120
    Width = 97
    Height = 25
    Cancel = True
    Caption = #20851#38381
    TabOrder = 5
    OnClick = btncloseClick
  end
  object rb3: TRadioButton
    Left = 136
    Top = 84
    Width = 57
    Height = 17
    Caption = #20462#25913
    TabOrder = 6
  end
end
