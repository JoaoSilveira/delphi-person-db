program TesteAdmissional;

uses
  Vcl.Forms,
  PersonScreen in 'PersonScreen.pas' {Form1},
  Validation in 'Validation.pas',
  SearchScreen in 'SearchScreen.pas' {Form2},
  Database in 'Database.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
