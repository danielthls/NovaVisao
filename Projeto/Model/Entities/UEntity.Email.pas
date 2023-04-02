unit UEntity.Email;

interface

uses
  iniFiles, sysUtils;

type
  TContaEmail = class
  private
    FEmail: String;
    FSenha: String;
    FPorta: Integer;
    FSMTP:  String;
    //procedure CarregarConfig;
    //function ValidarConfig: Boolean;
    function GetEmail: String;
    function GetPorta: Integer;
    function GetSenha: String;
    function GetSMTP: String;
    //procedure CriarArquivo;
    procedure SetEmail(const Value: String);
    procedure SetPorta(const Value: Integer);
    procedure SetSenha(const Value: String);
    procedure SetSMTP(const Value: String);
  public
    property Email: String read GetEmail write SetEmail;
    property Senha: String read GetSenha write SetSenha;
    property Porta: Integer read GetPorta write SetPorta;
    property SMTP:  String read GetSMTP  write SetSMTP;
    //procedure CriarConfig;
    constructor Create;
  end;

implementation

uses
  BCrypt;
{ TEmail }

{procedure TContaEmail.CarregarConfig;
var
  xArquivoIni: TIniFile;
  xSenha: String;
begin
  xArquivoIni := TIniFile.Create('EmailConfig.ini');
  try
    FEmail := xArquivoIni.ReadString('ContaEmail', 'Email', '');
    //xSenha := xArquivoIni.ReadString('ContaEmail', 'Senha', '');
    FSenha := xArquivoIni.ReadString('ContaEmail', 'Senha', '');
    FPorta := xArquivoIni.ReadString('ContaEmail', 'Porta', '');
    FSMTP  := xArquivoIni.ReadString('ContaEmail', 'SMTP' , '');
    //FSenha := TBcrypt.
  finally
    FreeAndNil(xArquivoIni);
  end;
end;}

constructor TContaEmail.Create;
begin

end;

{procedure TContaEmail.CriarArquivo;
begin

end;}

{procedure TContaEmail.CriarConfig;
begin

end;}

function TContaEmail.GetEmail: String;
begin
  Result := FEmail;
end;

function TContaEmail.GetPorta: Integer;
begin
  Result := FPorta;
end;

function TContaEmail.GetSenha: String;
begin
  Result := FSenha;
end;

function TContaEmail.GetSMTP: String;
begin
  Result := FSMTP;
end;

procedure TContaEmail.SetEmail(const Value: String);
begin
  FEmail := Value;
end;

procedure TContaEmail.SetPorta(const Value: Integer);
begin
  FPorta := Value;
end;

procedure TContaEmail.SetSenha(const Value: String);
begin
  FSenha := Value;
end;

procedure TContaEmail.SetSMTP(const Value: String);
begin
  FSMTP := Value;
end;

{function TContaEmail.ValidarConfig: Boolean;
begin

end;}

end.
