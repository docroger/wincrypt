object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 333
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 312
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Button1: TButton
    Left = 24
    Top = 72
    Width = 89
    Height = 33
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 119
    Top = 72
    Width = 73
    Height = 33
    Caption = 'Button2'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 24
    Top = 168
    Width = 89
    Height = 33
    Caption = 'Button3'
    TabOrder = 2
  end
  object Button4: TButton
    Left = 119
    Top = 168
    Width = 73
    Height = 33
    Caption = 'Button4'
    TabOrder = 3
  end
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 184
    Height = 21
    TabOrder = 4
    Text = 'Edit1 123 456 789 azzzz'
  end
  object Edit2: TEdit
    Left = 8
    Top = 141
    Width = 193
    Height = 21
    TabOrder = 5
    Text = 'Edit2'
  end
  object Memo1: TMemo
    Left = 224
    Top = 8
    Width = 225
    Height = 150
    Lines.Strings = (
      'Memo1')
    TabOrder = 6
  end
  object Memo2: TMemo
    Left = 224
    Top = 164
    Width = 225
    Height = 161
    Lines.Strings = (
      'Memo2')
    TabOrder = 7
  end
end
