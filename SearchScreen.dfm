object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Pesquisar'
  ClientHeight = 312
  ClientWidth = 438
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 400
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnHide = FormHide
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 438
    Height = 312
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 434
    ExplicitHeight = 311
    DesignSize = (
      438
      312)
    object LblSearch: TLabel
      Left = 8
      Top = 16
      Width = 46
      Height = 15
      Caption = '&Pesquisa'
      FocusControl = EdtSearch
    end
    object EdtSearch: TEdit
      Left = 60
      Top = 13
      Width = 339
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnChange = EdtSearchChange
      ExplicitWidth = 335
    end
    object BtnEdit: TButton
      Left = 324
      Top = 278
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Editar'
      Default = True
      ModalResult = 1
      TabOrder = 2
      OnClick = BtnEditClick
      ExplicitLeft = 320
      ExplicitTop = 277
    end
    object BtnCancel: TButton
      Left = 221
      Top = 278
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = '&Cancelar'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 217
      ExplicitTop = 277
    end
    object DBGrid1: TDBGrid
      Left = 8
      Top = 42
      Width = 391
      Height = 230
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = DsPerson
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 3
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'id'
          Title.Caption = 'Id'
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ativo'
          Title.Caption = 'Ativo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cpf'
          Title.Caption = 'Cpf'
          Width = 79
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome'
          Title.Caption = 'Nome'
          Width = 345
          Visible = True
        end>
    end
  end
  object DsPerson: TDataSource
    AutoEdit = False
    DataSet = DataModule1.QryPerson
    Left = 24
    Top = 248
  end
end
