unit UService.NotificacaoEmail;

interface

uses
  Fmx.Dialogs, System.SysUtils, System.Classes,
  UUtils.Consts, IniFiles,
  IdSMTP,
  IdMessage,
  IdSSLOpenSSL,
  IdExplicitTLSClientServerBase,
  UEntity.Email,
  System.IOUtils;

type
  TNotificacaoEmail = class
  private
    FContaEmail: TContaEmail;
    procedure CarregarConfig;
    function ValidarConfig: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure EnviarNotificacao(aEmailCliente: String;
      aUrlImagem: TStringList);
    procedure CriarConfig(aEmail, aSenha, aSMTP: String; aPorta: Integer);

  end;

implementation

{ TNotificacaoEmail }

procedure TNotificacaoEmail.CarregarConfig;
var
  xArquivoIni: TIniFile;
  xCaminhoArquivo: string;
  xSenha: String;
begin
  xCaminhoArquivo := ExpandFileName(ARQUIVO_INI);
  xArquivoIni := TIniFile.Create(xCaminhoArquivo);
  try
    FContaEmail.Email := xArquivoIni.ReadString(SECAO_INI_CONTA_EMAIL, CHAVE_INI_EMAIL, '');
    //xSenha := xArquivoIni.ReadString('ContaEmail', 'Senha', '');
    FContaEmail.Senha := xArquivoIni.ReadString(SECAO_INI_CONTA_EMAIL, CHAVE_INI_SENHA, '');
    FContaEmail.Porta := xArquivoIni.ReadString(SECAO_INI_CONTA_EMAIL, CHAVE_INI_PORTA, '').ToInteger;
    FContaEmail.SMTP  := xArquivoIni.ReadString(SECAO_INI_CONTA_EMAIL, CHAVE_INI_SMTP , '');
    //FSenha := TBcrypt.
  finally
    FreeAndNil(xArquivoIni);
  end;

end;

constructor TNotificacaoEmail.Create;
begin
  FContaEmail := TContaEmail.Create;
  if ValidarConfig then
    CarregarConfig;

end;

procedure TNotificacaoEmail.CriarConfig(aEmail, aSenha, aSMTP: String; aPorta: Integer);
var
  xEmailConfig: TIniFile;
  xCaminhoArquivo: String;
begin
  xCaminhoArquivo := ExpandFileName(ARQUIVO_INI);
  TFile.Create(xCaminhoArquivo);
  xEmailConfig := TIniFile.Create(xCaminhoArquivo);
  try
    xEmailConfig.WriteString(SECAO_INI_CONTA_EMAIL, CHAVE_INI_EMAIL, aEmail);
    xEmailConfig.WriteString(SECAO_INI_CONTA_EMAIL, CHAVE_INI_SENHA, aSenha);
    xEmailConfig.WriteInteger(SECAO_INI_CONTA_EMAIL, CHAVE_INI_PORTA, aPorta);
    xEmailConfig.WriteString(SECAO_INI_CONTA_EMAIL, CHAVE_INI_SMTP, aSMTP);
    xEmailConfig.UpdateFile;
    CarregarConfig;
  finally
    FreeAndNil(xEmailConfig);
  end;
end;

destructor TNotificacaoEmail.Destroy;
begin
  FreeAndNil(FContaEmail);
  inherited;
end;

procedure TNotificacaoEmail.EnviarNotificacao(
  aEmailCliente: String; aUrlImagem: TStringList);
var
  xSMTP: TIdSMTP;
  xMessage: TIdMessage;
  xSocketSSL : TIdSSLIOHandlerSocketOpenSSL;
  I: Integer;
begin
    xSMTP := TIdSMTP.Create;
    xMessage := TIdMessage.Create;
    xSocketSSL := TIdSSLIOHandlerSocketOpenSSL.Create;

  try
    xSocketSSL.SSLOptions.Mode := sslmClient;
    xSocketSSL.SSLOptions.Method := sslvTLSv1_2;
    xSocketSSL.Host := FContaEmail.SMTP;
    xSocketSSL.Port := FContaEmail.Porta;
    xSMTP.IOHandler := xSocketSSL;
    xSMTP.Host := FContaEmail.SMTP;
    xSMTP.Port := FContaEmail.Porta;
    xSMTP.AuthType := satDefault;
    xSMTP.Username := FContaEmail.Email;
    xSMTP.Password := FContaEmail.Senha;
    xSMTP.UseTLS := utUseExplicitTLS;
    xMessage.From.Address := aEmailCliente;                       //destinatario
    xMessage.Recipients.Add;
    xMessage.Recipients.Items[0].Address := aEmailCliente;        //destinatario
    xMessage.Subject := 'Suas variações de imagem estão prontas!';//assunto email
    for I := 0 to pred(aUrlImagem.Count) do
    begin
      xMessage.Body.Add((I+1).ToString + 'ª Url da imagem: '
                                       + aUrlImagem[I]);        //corpo do email
      xMessage.Body.Add(' ');                      // espacamento entre as url's
    end;
    try
      xSMTP.Connect;
      xSMTP.Send(xMessage);
      ShowMessage('Menssagem enviada com sucesso');
    except on E: Exception do
      raise Exception.Create('Erro ao enviar email: ' + E.Message);
    end;
  finally
    FreeAndNil(xSMTP);
    FreeAndNil(xMessage);
    FreeAndNil(xSocketSSL);
  end;
end;

function TNotificacaoEmail.ValidarConfig: Boolean;
var
  xArquivoIni: TInifile;
  xCaminhoArquivo: string;
begin
  xCaminhoArquivo := ExpandFileName(ARQUIVO_INI);
  if not FileExists(xCaminhoArquivo) then
  begin
    Result := False;
    Exit;
  end
  else
  begin
    xArquivoIni := TInifile.Create(xCaminhoArquivo);
    try
      xArquivoIni.UpdateFile;
      if (not xArquivoIni.SectionExists(SECAO_INI_CONTA_EMAIL) or not
        (xArquivoIni.ValueExists(SECAO_INI_CONTA_EMAIL, CHAVE_INI_EMAIL) and
        xArquivoIni.ValueExists( SECAO_INI_CONTA_EMAIL, CHAVE_INI_SENHA) and
        xArquivoIni.ValueExists( SECAO_INI_CONTA_EMAIL, CHAVE_INI_PORTA) and
        xArquivoIni.ValueExists( SECAO_INI_CONTA_EMAIL, CHAVE_INI_SMTP ))) then
      begin
        Result := false;
      end
      else
      Result := true;
    finally
      FreeAndNil(xArquivoIni);
    end;
  end;
end;

end.
