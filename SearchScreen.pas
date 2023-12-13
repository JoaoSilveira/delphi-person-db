unit SearchScreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, StrUtils, System.RegularExpressions,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Database;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    LblSearch: TLabel;
    EdtSearch: TEdit;
    BtnEdit: TButton;
    BtnCancel: TButton;
    DsPerson: TDataSource;
    DBGrid1: TDBGrid;
    procedure BtnEditClick(Sender: TObject);
    procedure EdtSearchChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
    FSelectedPerson: TPerson;
    FSearchTerm: String;

    procedure FilterByCpfOrName(DataSet: TDataSet; var Accept: Boolean);
  public
    { Public declarations }
    property SelectedPerson: TPerson read FSelectedPerson;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.BtnEditClick(Sender: TObject);
begin
  if DsPerson.DataSet.FieldByName('id').AsInteger > 0 then
  begin
    // Preenche os dados da pessoa selecionada com os dados do dataset
    FSelectedPerson := TPerson.Create(
      DsPerson.DataSet.FieldByName('id').AsInteger,
      DsPerson.DataSet.FieldByName('ativo').AsBoolean,
      DsPerson.DataSet.FieldByName('cpf').AsWideString,
      DsPerson.DataSet.FieldByName('nome').AsWideString,
      DsPerson.DataSet.FieldByName('obs').AsWideString
    );
  end
  else
  begin
    ModalResult := mrCancel;
    Close;
  end;
end;

procedure TForm2.EdtSearchChange(Sender: TObject);
begin
  // verifica se é um CPF, começando da esquerda,
  // pode ser só números ou com pontuação também,
  // não pesquisa por EndsWith
  if TRegEx.IsMatch(EdtSearch.Text,
    '^\s*\d{1,3}(\.?\d{0,3}(\.?\d{0,3}(-?\d{0,2})?)?)?\s*$') then
    FSearchTerm := TRegEx.Replace(EdtSearch.Text, '\D', '')
  else
    FSearchTerm := LowerCase(Trim(EdtSearch.Text));

  DsPerson.DataSet.Refresh;
end;

procedure TForm2.FilterByCpfOrName(DataSet: TDataSet; var Accept: Boolean);
var
  NumberOnlyCpf: String;
begin
  {
    Condições inclusão da entidade

      1 - nada digitado
      2 - contém _SearchTerm no nome (caso não sensitivo)
      3 - CPF é iniciado por _SearchTerm
  }
  Accept := (Length(FSearchTerm) = 0) or ContainsText(LowerCase(DataSet.FieldByName('nome').AsWideString),
    FSearchTerm) or StartsText(FSearchTerm, DataSet.FieldByName('cpf').AsWideString);
end;

procedure TForm2.FormHide(Sender: TObject);
begin
  DsPerson.DataSet.Active := false;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  DsPerson.DataSet.Active := true;
  DsPerson.DataSet.Filtered := true;
  DsPerson.DataSet.OnFilterRecord := FilterByCpfOrName;
end;

end.
