unit PersonScreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.Generics.Collections, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask,
  SearchScreen, Database, Validation, System.RegularExpressions,
  Data.DB;

type
  TForm1 = class(TForm)
    Page: TPanel;
    SearchPanel: TPanel;
    ContentPanel: TPanel;
    ActionPanel: TPanel;
    BtnSearch: TButton;
    BtnSave: TButton;
    BtnNew: TButton;
    EdtCpf: TMaskEdit;
    CbxActive: TCheckBox;
    EdtName: TEdit;
    MemObservations: TMemo;
    lblCpf: TLabel;
    lblName: TLabel;
    lblObservations: TLabel;
    DsPerson: TDataSource;
    procedure BtnSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnNewClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    FPerson: TPerson;
    PersonValidator: IValidate<TPerson, TPersonValidationError>;

    procedure SetPerson(NewPerson: TPerson);
    procedure UpdatePersonFromUI;

  public
    { Public declarations }
    property Person: TPerson read FPerson write SetPerson;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BtnNewClick(Sender: TObject);
begin
  Person := TPerson.Create;
  EdtCpf.SetFocus;
end;

procedure TForm1.BtnSaveClick(Sender: TObject);
var
  ValidationError: TPersonValidationError;
  ErrorMessage: String;
begin
  // atualiza o model com os dados da tela
  UpdatePersonFromUI;

  // O ideal seria ter uma API pra fazer validação e transformação de dados
  // como Yup em Javascript.
  ValidationError := TPersonValidationError.Create;
  if not PersonValidator.Validate(Person, ValidationError) then
  begin
    if (ValidationError.Name <> '') and (ValidationError.Cpf <> '') then
      ErrorMessage := ValidationError.Name + sLineBreak + ValidationError.Cpf
    else if ValidationError.Name <> '' then
      ErrorMessage := ValidationError.Name
    else
      ErrorMessage := ValidationError.Cpf;

    ShowMessage(ErrorMessage);
    Exit;
  end;

  try
    DsPerson.DataSet.Open;

    // caso a entidade exista o ID vai ser positivo
    // então localiza e edita ela, caso contrario, insere
    if Person.Id > -1 then
    begin
      DsPerson.DataSet.Locate('id', Person.Id, []);
      DsPerson.DataSet.Edit;
    end
    else
      DsPerson.DataSet.Append;

    // não encontrei nada de ORM sem uso de bibliotecas externas
    // então fiz a inserção na mão mesmo
    DsPerson.DataSet.FieldByName('ativo').AsBoolean := Person.Active;
    DsPerson.DataSet.FieldByName('cpf').AsWideString :=
      TRegEx.Replace(Person.Cpf, '\D', '');
    DsPerson.DataSet.FieldByName('nome').AsWideString := Trim(Person.Name);

    // quando o memo está vazio gravar nulo invés de
    if TStringNotEmptyValidator.GetInstance.Validate(Person.Observation,
      ErrorMessage) then
      DsPerson.DataSet.FieldByName('obs').AsWideString :=
        Trim(Person.Observation)
    else
      DsPerson.DataSet.FieldByName('obs').Clear;

    DsPerson.DataSet.Post;
    DsPerson.DataSet.Close;

    BtnNew.Click;
  except
    on E: Exception do
    begin
      ShowMessage
        ('Não foi possível gravar os dados devido a um erro. Exception: ' +
        sLineBreak + sLineBreak + E.ToString);
      DsPerson.DataSet.Close;
    end;
  end;

end;

procedure TForm1.BtnSearchClick(Sender: TObject);
var
  Modal: SearchScreen.TForm2;
begin
  Modal := SearchScreen.TForm2.Create(self);

  if Modal.ShowModal <> mrOk then
    Exit;

  Person := Modal.SelectedPerson;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Person := TPerson.Create;
  PersonValidator := TPersonValidator.GetInstance;
end;

procedure TForm1.SetPerson(NewPerson: TPerson);
begin
  FPerson := NewPerson;

  // tem que refazer a máscara
  EdtCpf.Text := Person.Cpf.Substring(0, 3) + '.' + Person.Cpf.Substring(3, 3) +
    '.' + Person.Cpf.Substring(6, 3) + '-' + Person.Cpf.Substring(9, 2);
  EdtName.Text := Person.Name;
  MemObservations.Lines.Text := Person.Observation;
  CbxActive.Checked := Person.Active;
end;

procedure TForm1.UpdatePersonFromUI;
begin
  FPerson.Name := EdtName.Text;
  FPerson.Cpf := EdtCpf.Text;
  FPerson.Observation := MemObservations.Lines.Text;
  FPerson.Active := CbxActive.Checked;
end;

end.
