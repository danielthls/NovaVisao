object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 341
  ClientWidth = 780
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 24
    Top = 18
    Width = 201
    Height = 159
    Caption = 'Cadastrar'
    TabOrder = 0
    object Label1: TLabel
      Left = 23
      Top = 28
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object Label2: TLabel
      Left = 23
      Top = 55
      Width = 28
      Height = 13
      Caption = 'E-mail'
    end
    object Label3: TLabel
      Left = 23
      Top = 81
      Width = 24
      Height = 13
      Caption = 'Fone'
    end
    object edtNome: TEdit
      Left = 56
      Top = 24
      Width = 121
      Height = 21
      TabOrder = 0
      TextHint = 'Informe um Nome'
    end
    object edtEmail: TEdit
      Left = 56
      Top = 51
      Width = 121
      Height = 21
      TabOrder = 1
      TextHint = 'Informe um E-mail'
    end
    object edtFone: TEdit
      Left = 56
      Top = 78
      Width = 121
      Height = 21
      TabOrder = 2
      TextHint = 'Informe um Telefone'
    end
    object btnGravar: TButton
      Left = 56
      Top = 118
      Width = 121
      Height = 25
      Caption = 'Gravar'
      TabOrder = 3
      OnClick = btnGravarClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 231
    Top = 18
    Width = 242
    Height = 255
    Caption = 'Pesquisar'
    TabOrder = 1
    object Label4: TLabel
      Left = 20
      Top = 46
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label5: TLabel
      Left = 80
      Top = 46
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object btnPesquisar: TButton
      Left = 20
      Top = 222
      Width = 181
      Height = 25
      Caption = 'Pesquisar'
      TabOrder = 0
      OnClick = btnPesquisarClick
    end
    object edtNomeConsulta: TEdit
      Left = 80
      Top = 65
      Width = 121
      Height = 21
      TabOrder = 1
      TextHint = 'Nome'
    end
    object edtCodigo: TEdit
      Left = 20
      Top = 65
      Width = 54
      Height = 21
      TabOrder = 2
      TextHint = 'C'#243'digo'
    end
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=NOVA_VISAO'
      'User_Name=sa'
      'Password=mfn869618'
      'OSAuthent=No'
      'Server=TIGO-PC\SQLEXPRESS'
      'DriverID=MSSQL')
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode]
    Transaction = FDTransaction1
    Left = 512
    Top = 128
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConnection1
    Left = 512
    Top = 88
  end
  object fdConect: TFDTransaction
    Options.ReadOnly = True
    Connection = tfdConectDataBase
    Left = 697
    Top = 216
  end
  object tfdConectDataBase: TFDConnection
    Params.Strings = (
      'Server=TIGO-PC\SQLEXPRESS'
      'Database=SERVER_DB'
      'User_Name=sa'
      'Password=mfn869618'
      'DriverID=MSSQL')
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode]
    TxOptions.ReadOnly = True
    Transaction = fdConect
    Left = 592
    Top = 96
  end
end
