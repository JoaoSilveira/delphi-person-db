unit Database;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI;

type
  TDataModule1 = class(TDataModule)
    CnnSqlite: TFDConnection;
    QryPerson: TFDQuery;
    QryPersonid: TIntegerField;
    QryPersonativo: TBooleanField;
    QryPersoncpf: TWideMemoField;
    QryPersonnome: TWideMemoField;
    QryPersonobs: TWideMemoField;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  // Entidade simplificada para agrupar dados relacionados a pessoa
  TPerson = class
    Id: Integer;
    Active: Boolean;
    Cpf: String;
    Name: String;
    Observation: String;

    public
      Constructor Create(); overload;
      Constructor Create(Active: Boolean; Cpf, Name, Observation: String); overload;
      Constructor Create(Id: Integer; Active: Boolean; Cpf, Name, Observation: String); overload;
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

Constructor TPerson.Create;
begin
  Create(-1, True, '', '', '');
end;

Constructor TPerson.Create(Active: Boolean; Cpf: string; Name: string; Observation: string);
begin
  Create(-1, Active, Cpf, Name, Observation);
end;

Constructor TPerson.Create(Id: Integer; Active: Boolean; Cpf: string; Name: string; Observation: string);
begin

  Self.Id := Id;
  Self.Active := Active;
  Self.Cpf := Cpf;
  Self.Name := Name;
  Self.Observation := Observation;
end;

end.
