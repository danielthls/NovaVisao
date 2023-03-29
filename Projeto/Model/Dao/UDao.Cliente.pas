unit UDao.Cliente;

interface

uses
  UEntity.Cliente,
  FireDac.Comp.Client,
  FireDAC.Phys.MySQL,
  FireDac.DApt,
  FireDAC.Stan.Def,
  FireDAC.Stan.Async,
  Data.DB;

type
  TDAOCliente= class
    private
      FCliente: TCliente;
      FTabela: String;
      class function PreencherCliente(aQuery: TFDQuery): TCliente;
    public
      constructor Create;
      destructor Destroy; override;
      function ProcurarCliente({const aIdentificador: Integer;} aNome: String): TCliente;
      function AdicionarRegistro(aCliente: TCliente): Boolean;
  end;
implementation
uses
  System.SysUtils,
  fmx.Dialogs,
  UUtils.Banco;

{ TDAOUsers }

constructor TDAOCliente.Create;
begin
  FTabela := 'cliente';
end;

destructor TDAOCliente.Destroy;
begin
  FreeAndNil(FCliente);
  inherited;
end;

class function TDAOCliente.PreencherCliente(aQuery: TFDQuery): TCliente;
begin

end;

function TDAOCliente.ProcurarCliente(aNome: String): TCliente;

var
  UtilBanco: TUtilBanco;
begin
  UtilBanco := TUtilBanco.Create;
  try
    try
      Result := UtilBanco.PesquisarRegistroCliente({aIdentificador,} aNome);
    except
      on e: Exception do
        raise Exception.Create('Erro ao Pesquisar Registro: '
          + e.Message);
    end;
  finally
    FreeAndNil(UtilBanco);
  end;
end;

function TDaoCliente.AdicionarRegistro(aCliente: TCliente): Boolean;
begin
    try
      Result := TUtilBanco.AdicionarRegistroCliente(aCliente);
      ShowMessage('Cliente Cadastrado com Sucesso. ');
    except
      on e: Exception do
        raise Exception.Create('Erro ao Adicionar Registro: '
          + e.Message);
    end;
end;

{class function TDAOCliente.PreencherCliente(aQuery: TFDQuery): TCliente;
var
  xCliente: TCliente;
begin
  xCliente := TCliente.Create(aQuery.FieldByName('NOME').AsString,
                                  aQuery.FieldByName('EMAIL').AsString,
                                  aQuery.FieldByName('NUM_TELEFONE').AsString);
  Result := xCliente;
end;}

//function TDAOCliente.ProcurarCliente({const aIdentificador: Integer;} aNome: String): TCliente;
{const
  COMANDO_SQL = 'SELECT * FROM %s WHERE nome = %s';
var
  xNome: String;
begin
  xNome := QuotedStr('%' + aNome + '%') + '';
  FCliente := Self.PreencherCliente(TUtilBanco.ExecutarConsulta(Format(COMANDO_SQL, [FTabela, xNome])));
  try
    Result := FCliente;
  except
    on e: Exception do
      raise Exception.Create('Erro ao Pesquisar Registro: '
        + e.Message);
  end;
end;}
end.
