unit UUtils.Banco;

interface

uses
  FireDac.Comp.Client,
  FireDAC.Phys.MySQL,
  FireDac.DApt,
  FireDAC.Stan.Def,
  FireDAC.Stan.Async,
  Data.DB,
  DataSet.Serialize,
  System.JSON,
  System.SysUtils,
  uEntity.Cliente;

type
  TUtilBanco = class
    private
      class var FConexao: TFDConnection;
      class procedure AbrirConexao;
      class procedure FecharConexao;
    public

      class function PesquisarRegistroCliente({const aCodCliente: Integer;} aNomCliente: String): TCliente;
      class function AdicionarRegistroCliente(const aClasseCliente: TCliente): Boolean;
  end;

implementation

{ TUtilBanco }


class procedure TUtilBanco.AbrirConexao;
var
  xDriver: TFDPhysMySQLDriverLink;
begin
  xDriver := TFDPhysMySQLDriverLink.Create(nil);
  FConexao  := TFDConnection.Create(nil);
  //Driver de Conexão do MySQL
  xDriver.VendorLib := ExtractFilePath(ParamStr(0)) + 'libmysql.dll';
  //Parâmetros de Configuração do banco
  FConexao.DriverName  := 'MySQL';
  FConexao.LoginPrompt := False;
  FConexao.Params.Add('Database=NOVA_VISAO');
  FConexao.Params.Add('User_Name=root');
  FConexao.Params.Add('Password=root');
  FConexao.Params.Add('Server=localhost');
  FConexao.Params.Add('DriverID=MySQL');
  FConexao.Open;
end;

class function TUtilBanco.AdicionarRegistroCliente(const aClasseCliente: TCliente): Boolean;
var
  xQuery: TFDQuery;
begin
  Result := True;

  Self.AbrirConexao;

  xQuery := TFDQuery.Create(nil);
  try
    try
      xQuery.CLose;
      xQuery.Connection := FConexao;
      xQuery.sql.Clear;
      xQuery.SQL.Add('INSERT INTO CLIENTE');
      xQuery.SQL.Add('(NOME, EMAIL, NUM_TELEFONE)');
      xQuery.SQL.Add('VALUES');
      xQuery.SQL.Add('(:NOME, :EMAIL, :NUM_TELEFONE);');
      xQuery.ParamByName('NOME').AsString := aClasseCliente.Nome;
      xQuery.ParamByName('EMAIL').AsString := aClasseCliente.Email;
      xQuery.ParamByName('NUM_TELEFONE').AsString := aClasseCliente.Telefone;
      xQuery.ExecSQL;

    except
    on e: Exception do
    begin
      raise Exception.Create('Não foi possível incluir o cliente. ' + e.Message);
        Result := False;
    end;
    end;

  finally
    FreeAndNil(xQuery);
    Self.FecharConexao;
  end;
end;


class function TUtilBanco.PesquisarRegistroCliente({const aCodCliente: Integer;} aNomCliente: String): TCliente;
var
  qry_Aux: TFDQuery;
begin
  Self.AbrirConexao;
  Result := nil;
  qry_Aux := TFDQuery.Create(nil);
  try
    try
      qry_Aux.Close;
      qry_Aux.Connection := FConexao;
      qry_Aux.sql.Clear;
      qry_Aux.SQL.Add('SELECT ID, NOME, EMAIL, NUM_TELEFONE FROM CLIENTE');

//      if aCodCliente <> 0 then
//      begin
//        qry_Aux.SQL.Add('WHERE ID = :ID');
//        qry_Aux.ParamByName('ID').AsInteger := aCodCliente;
//      end
//      else
//      begin
        qry_Aux.SQL.Add('WHERE NOME LIKE ' + QuotedStr('%' + aNomCliente + '%')+ ''); //:NOME');

        //qry_Aux.ParamByName('NOME').AsString := aNomCliente;//+ QuotedStr('%' + aNomCliente + '%');
//      end;

      qry_Aux.Open;
      if not qry_Aux.Eof then
      begin
        Result := TCliente.Create(qry_Aux.FieldByName('NOME').AsString,
                                  qry_Aux.FieldByName('EMAIL').AsString,
                                  qry_Aux.FieldByName('NUM_TELEFONE').AsString);
      end;

    finally
      FreeAndNil(qry_Aux);
      Self.FecharConexao;
    end;

  except
    on e: Exception do
    begin
      raise Exception.Create('Erro ao pesquisar cliente. ' + e.Message);
    end;
  end;
end;

class procedure TUtilBanco.FecharConexao;
begin
  if Assigned(FConexao) and (FConexao.Connected) then
  begin
    FConexao.Close;
    FreeAndNil(FConexao);
  end;
end;
end.
