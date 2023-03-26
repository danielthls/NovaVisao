unit UDaoCliente;

interface
uses
  uEntity.Cliente;
type
  TDAOCliente= class
    private
      FTabela: String;
    public
      constructor Create;
      function ProcurarCliente(const aIdentificador: Integer; aNome: String): TCliente;
      function AdicionarRegistro(aCliente: TCliente): Boolean;
  end;
implementation
uses
  System.SysUtils,
  UUtils.Banco;

{ TDAOUsers }

constructor TDAOCliente.Create;
begin
  FTabela := 'clientes';
end;

function TDaoCliente.AdicionarRegistro(aCliente: TCliente): Boolean;
var
  UtilBanco: TUtilBanco;
begin
  UtilBanco := TUtilBanco.Create;
  try
    try
      Result := UtilBanco.AdicionarRegistroCliente(aCliente);
    except
      on e: Exception do
        raise Exception.Create('Erro ao Adicionar Registro: '
          + e.Message);
    end;
  finally
    FreeAndNil(UtilBanco);
  end;
end;
function TDAOCliente.ProcurarCliente(const aIdentificador: Integer; aNome: String): TCliente;
var
  UtilBanco: TUtilBanco;
begin
  UtilBanco := TUtilBanco.Create;
  try
    try
      Result := UtilBanco.PesquisarRegistroCliente(aIdentificador, aNome);
    except
      on e: Exception do
        raise Exception.Create('Erro ao Adicionar Registro: '
          + e.Message);
    end;
  finally
    FreeAndNil(UtilBanco);
  end;
end;
end.
