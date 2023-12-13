unit Validation;

interface

uses System.RegularExpressions, Database;

type
  {
    interface para validação de dados
    valida um TValue e notifica o erro por TError

    Classes de validação foram feitas singleton
    mas pela simplicidade dos requisitos poderia até ser uma função para cada
  }
  IValidate<TValue, TError> = interface
    function Validate(Value: TValue; var Error: TError): Boolean;
  end;

  // Validador de CPF pela especificação
  TCpfValidator = class(TInterfacedObject, IValidate<String, String>)
    function Validate(Value: String; var Error: String): Boolean;

  private
    Constructor Create;
    class var _Instance: TCpfValidator;

  public
    class function GetInstance: TCpfValidator;
  end;

  // Valida se uma string tem conteúdo
  TStringNotEmptyValidator = class(TInterfacedObject, IValidate<String, String>)
    function Validate(Value: String; var Error: String): Boolean;

  private
    Constructor Create;
    class var _Instance: TStringNotEmptyValidator;

  public
    class function GetInstance: TStringNotEmptyValidator;
  end;

  // Mensagem de erro sobre a validação de uma pessoa
  TPersonValidationError = class
    Name: String;
    Cpf: String;
  end;

  // Validador de pessoa, valida se nome foi preenchido e CPF é válido
  TPersonValidator = class(TInterfacedObject,
    IValidate<TPerson, TPersonValidationError>)
    function Validate(Value: TPerson;
      var Error: TPersonValidationError): Boolean;

  private
    CpfValidator: IValidate<String, String>;
    NameValidator: IValidate<String, String>;
  
    Constructor Create;
    class var _Instance: TPersonValidator;

  public
    class function GetInstance: TPersonValidator;
  end;

implementation

constructor TCpfValidator.Create;
begin
  inherited;
end;

class function TCpfValidator.GetInstance: TCpfValidator;
begin
  if not Assigned(_Instance) then
    _Instance := TCpfValidator.Create;

  Result := _Instance;
end;

function TCpfValidator.Validate(Value: string; var Error: string): Boolean;
var

  NumberArray: Array [0 .. 10] of Integer;

//  Transforma a string de entrada em um array de dígitos
  procedure FillNumberArray;
  var
    StringIndex: Integer;
    ArrayIndex: Integer;
  begin
    ArrayIndex := 0;

    for StringIndex := 1 to Length(Value) do
    begin
      if (Value[StringIndex] = '-') or (Value[StringIndex] = '.') then
        continue;

      NumberArray[ArrayIndex] := Ord(Value[StringIndex]) - Ord('0');
      Inc(ArrayIndex);
    end;
  end;

//  cálculo de validação do primeiro digito do CPF
  function ValidateFirstDigit: Boolean;
  var
    Digit: Integer;
    Sum: Integer;
    Reminder: Integer;
  begin
    Sum := 0;

    for Digit := 0 to 8 do
    begin
      Sum := Sum + (10 - Digit) * NumberArray[Digit];
    end;

    // calcula o digito e transforma 10 em 0
    Reminder := ((Sum * 10) mod 11) mod 10;

    Result := Reminder = NumberArray[9];
  end;

//  validação do segundo dígito do CPF
  function ValidateSecondDigit: Boolean;
  var
    Digit: Integer;
    Sum: Integer;
    Reminder: Integer;
  begin
    Sum := 0;

    for Digit := 0 to 9 do
    begin
      Sum := Sum + (11 - Digit) * NumberArray[Digit];
    end;

    // calcula o digito e transforma 10 em 0
    Reminder := ((Sum * 10) mod 11) mod 10;

    Result := Reminder = NumberArray[10];
  end;

begin
  Result := false;

  if not TRegEx.IsMatch(Value, '\d{3}\.\d{3}\.\d{3}-\d{2}') then
  begin
    Error := 'formato incorreto ou não preenchido por completo. Formato esperado: ###.###.###-##';
    Exit;
  end;

  FillNumberArray;

  if not ValidateFirstDigit then
  begin
    Error := 'Primeiro digito verificador inválido';
    Exit;
  end;

  if not ValidateSecondDigit then
  begin
    Error := 'Segundo digito verificador inválido';
    Exit;
  end;

  Result := true;
end;

constructor TStringNotEmptyValidator.Create;
begin
  inherited;
end;

class function TStringNotEmptyValidator.GetInstance: TStringNotEmptyValidator;
begin
  if not Assigned(_Instance) then
    _Instance := TStringNotEmptyValidator.Create;

  Result := _Instance;
end;

function TStringNotEmptyValidator.Validate(Value: string;
  var Error: string): Boolean;
begin
//  Tem que validar se a string é vazia ou não porque a regex não funciona como
//  esperado neste caso
  if (Length(Value) = 0) or TRegEx.IsMatch(Value, '\A\s*\z') then
  begin
    Error := 'valor está vazio';
    Result := false;
  end
  else
    Result := true;
end;

constructor TPersonValidator.Create;
begin
  inherited;

  CpfValidator := TCpfValidator.GetInstance;
  NameValidator := TStringNotEmptyValidator.GetInstance;
end;

class function TPersonValidator.GetInstance: TPersonValidator;
begin
  if not Assigned(_Instance) then
    _Instance := TPersonValidator.Create;

  Result := _Instance;
end;

function TPersonValidator.Validate(Value: TPerson;
  var Error: TPersonValidationError): Boolean;
var
  AuxiliarError: String;
begin
  Result := true;
  
  if not CpfValidator.Validate(Value.Cpf, AuxiliarError) then
  begin  
    Result := false;
    Error.Cpf := 'CPF Inválido: ' + AuxiliarError;
  end; 
  
  if not NameValidator.Validate(Value.Name, AuxiliarError) then
  begin  
    Result := false;
    Error.Name := 'Nome inválido: ' + AuxiliarError;
  end;
end;

end.
