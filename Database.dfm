object DataModule1: TDataModule1
  Height = 480
  Width = 640
  object CnnSqlite: TFDConnection
    Params.Strings = (
      'DriverID=sQLite')
    LoginPrompt = False
    Left = 32
    Top = 8
  end
  object QryPerson: TFDQuery
    Connection = CnnSqlite
    SQL.Strings = (
      'select * from Person')
    Left = 160
    Top = 8
    object QryPersonid: TIntegerField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object QryPersonativo: TBooleanField
      FieldName = 'ativo'
      Origin = 'ativo'
      Required = True
    end
    object QryPersoncpf: TWideMemoField
      FieldName = 'cpf'
      Origin = 'cpf'
      Required = True
      BlobType = ftWideMemo
      DisplayValue = dvFull
    end
    object QryPersonnome: TWideMemoField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      BlobType = ftWideMemo
      DisplayValue = dvFull
    end
    object QryPersonobs: TWideMemoField
      FieldName = 'obs'
      Origin = 'obs'
      BlobType = ftWideMemo
    end
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 448
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 448
    Top = 96
  end
end
