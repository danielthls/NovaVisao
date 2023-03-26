unit uEntity.Cliente;

interface

type
  TCliente = class
    private
      FId: Integer;
      FNome: String;
      FEmail: String;
      FTelefone: String;

      function GetEmail: String;
      function GetId: Integer;
      function GetNome: String;
      function GetTelefone: String;

      procedure SetEmail(const Value: String);
      procedure SetId(const Value: Integer);
      procedure SetNome(const Value: String);
      procedure SetTelefone(const Value: String);
    public
      constructor Create(const aID: Integer; aNome, aEmail, aTelefone: String);

      property Id: Integer read GetId write SetId;
      property Nome: String read GetNome write SetNome;
      property Email: String read GetEmail write SetEmail;
      property Telefone: String read GetTelefone write SetTelefone;
  end;
implementation

uses
  SysUtils;

{ TUser }

constructor TCliente.Create(const aID: Integer; aNome, aEmail, aTelefone: String);
begin
  FId       := aID;
  FNome     := aNome;
  FEmail    := aEmail;
  FTelefone := aTelefone;
end;

function TCliente.GetEmail: String;
begin
  Result := FEmail;
end;

function TCliente.GetId: Integer;
begin
  Result := FId;
end;

function TCliente.GetNome: String;
begin
  Result := FNome;
end;

function TCliente.GetTelefone: String;
begin
  Result := FTelefone;
end;

procedure TCliente.SetEmail(const Value: String);
begin
  FEmail := Value;
end;

procedure TCliente.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TCliente.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TCliente.SetTelefone(const Value: String);
begin
  FTelefone := Value;
end;

end.
