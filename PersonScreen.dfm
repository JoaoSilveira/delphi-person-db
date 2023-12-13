object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Gerenciador de Pessoa'
  ClientHeight = 360
  ClientWidth = 580
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Page: TPanel
    Left = 0
    Top = 0
    Width = 580
    Height = 360
    Align = alClient
    Padding.Left = 10
    Padding.Top = 10
    Padding.Right = 10
    Padding.Bottom = 10
    TabOrder = 0
    object SearchPanel: TPanel
      Left = 11
      Top = 11
      Width = 558
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object BtnSearch: TButton
        Left = 483
        Top = 0
        Width = 75
        Height = 25
        Align = alRight
        Caption = '&Pesquisar'
        TabOrder = 1
        OnClick = BtnSearchClick
      end
      object BtnNew: TButton
        Left = 0
        Top = 0
        Width = 75
        Height = 25
        Align = alLeft
        Caption = '&Novo'
        TabOrder = 0
        OnClick = BtnNewClick
      end
    end
    object ContentPanel: TPanel
      AlignWithMargins = True
      Left = 11
      Top = 46
      Width = 558
      Height = 268
      Margins.Left = 0
      Margins.Top = 10
      Margins.Right = 0
      Margins.Bottom = 10
      Align = alClient
      TabOrder = 1
      DesignSize = (
        558
        268)
      object lblCpf: TLabel
        Left = 54
        Top = 16
        Width = 21
        Height = 15
        Caption = '&CPF'
        FocusControl = EdtCpf
      end
      object lblName: TLabel
        Left = 42
        Top = 50
        Width = 33
        Height = 15
        Caption = 'No&me'
        FocusControl = EdtName
      end
      object lblObservations: TLabel
        Left = 8
        Top = 88
        Width = 67
        Height = 15
        Caption = '&Observa'#231#245'es'
        FocusControl = MemObservations
      end
      object EdtCpf: TMaskEdit
        Left = 81
        Top = 13
        Width = 102
        Height = 23
        EditMask = '!000.000.000-00;1;#'
        MaxLength = 14
        TabOrder = 0
        Text = '   .   .   -  '
      end
      object CbxActive: TCheckBox
        Left = 496
        Top = 16
        Width = 49
        Height = 17
        Anchors = [akTop, akRight]
        Caption = '&Ativo'
        TabOrder = 1
      end
      object EdtName: TEdit
        Left = 81
        Top = 47
        Width = 464
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
      end
      object MemObservations: TMemo
        Left = 81
        Top = 85
        Width = 464
        Height = 170
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 3
      end
    end
    object ActionPanel: TPanel
      Left = 11
      Top = 324
      Width = 558
      Height = 25
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      object BtnSave: TButton
        Left = 483
        Top = 0
        Width = 75
        Height = 25
        Align = alRight
        Caption = '&Salvar'
        TabOrder = 0
        OnClick = BtnSaveClick
      end
    end
  end
  object DsPerson: TDataSource
    DataSet = DataModule1.QryPerson
    Left = 35
    Top = 238
  end
end
