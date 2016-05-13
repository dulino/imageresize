object Form1: TForm1
  Left = 98
  Top = 110
  Caption = 'Conversor de Bitmaps'
  ClientHeight = 182
  ClientWidth = 362
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBText1: TDBText
    Left = 304
    Top = 87
    Width = 49
    Height = 17
    DataField = 'COD_FUNC'
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 132
    Top = 87
    Width = 169
    Height = 13
    Caption = 'Processando funcion'#225'rio: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 132
    Top = 114
    Width = 125
    Height = 13
    Caption = 'Fotos encontradas:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 132
    Top = 141
    Width = 108
    Height = 13
    Caption = 'Fotos ajustadas:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbTot: TLabel
    Left = 304
    Top = 114
    Width = 49
    Height = 13
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbAtu: TLabel
    Left = 304
    Top = 141
    Width = 49
    Height = 13
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 132
    Top = 20
    Width = 133
    Height = 13
    Caption = 'Limite de Registros: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 133
    Top = 47
    Width = 125
    Height = 13
    Caption = 'A partir do c'#243'digo: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btIniciar: TButton
    Left = 8
    Top = 8
    Width = 114
    Height = 25
    Caption = 'Iniciar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btIniciarClick
  end
  object DBImage1: TDBImage
    Left = 8
    Top = 39
    Width = 114
    Height = 138
    DataField = 'FOTO_FUNC'
    DataSource = DataSource1
    TabOrder = 1
  end
  object edLim: TEdit
    Left = 304
    Top = 17
    Width = 49
    Height = 21
    TabOrder = 2
    Text = '2000'
    OnChange = edLimChange
  end
  object edCod: TEdit
    Left = 305
    Top = 44
    Width = 49
    Height = 21
    TabOrder = 3
    Text = '0'
    OnChange = edLimChange
  end
  object oSession: TOraSession
    ConnectDialog = ConnectDialog1
    Left = 24
    Top = 128
  end
  object qryFotos: TOraQuery
    SQLInsert.Strings = (
      'INSERT INTO RHFP0299'
      '  (COD_FUNC, FOTO_FUNC)'
      'VALUES'
      '  (:COD_FUNC, :FOTO_FUNC)')
    SQLDelete.Strings = (
      'DELETE FROM RHFP0299'
      'WHERE'
      '  COD_FUNC = :Old_COD_FUNC')
    SQLUpdate.Strings = (
      'UPDATE RHFP0299'
      'SET'
      '  COD_FUNC = :COD_FUNC, FOTO_FUNC = :FOTO_FUNC'
      'WHERE'
      '  COD_FUNC = :Old_COD_FUNC')
    SQLLock.Strings = (
      'SELECT * FROM RHFP0299'
      'WHERE'
      '  COD_FUNC = :Old_COD_FUNC'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      'SELECT COD_FUNC, FOTO_FUNC FROM RHFP0299'
      'WHERE'
      '  COD_FUNC = :COD_FUNC')
    SQL.Strings = (
      'SELECT *'
      'FROM RHFP0299'
      'WHERE COD_FUNC > :INICIO'
      'ORDER BY COD_FUNC')
    Left = 72
    Top = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'INICIO'
      end>
    object qryFotosCOD_FUNC: TFloatField
      FieldName = 'COD_FUNC'
      Required = True
    end
    object qryFotosFOTO_FUNC: TBlobField
      FieldName = 'FOTO_FUNC'
    end
  end
  object DataSource1: TDataSource
    DataSet = qryFotos
    Left = 48
    Top = 56
  end
  object ConnectDialog1: TConnectDialog
    Caption = 'Conectar'
    UsernameLabel = 'Usu'#225'rio'
    PasswordLabel = 'Senha'
    ServerLabel = 'Servidor'
    ConnectButton = 'Conectar'
    CancelButton = 'Cancelar'
    LabelSet = lsCustom
    Left = 240
    Top = 128
  end
end
