object Formlogin: TFormlogin
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Login'
  ClientHeight = 117
  ClientWidth = 376
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 27
    Top = 8
    Width = 96
    Height = 13
    Caption = 'CHAVE DE ACESSO:'
  end
  object Edit1: TEdit
    Left = 27
    Top = 27
    Width = 321
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 27
    Top = 72
    Width = 75
    Height = 25
    Caption = 'ENTRAR'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 273
    Top = 72
    Width = 75
    Height = 25
    Caption = 'SAIR'
    TabOrder = 2
    OnClick = Button2Click
  end
end
