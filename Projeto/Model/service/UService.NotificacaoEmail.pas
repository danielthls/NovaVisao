unit UService.NotificacaoEmail;

interface

uses
  Fmx.Dialogs, System.SysUtils, System.Classes,
  UUtils.Consts,
  IdSMTP,
  IdMessage,
  IdSSLOpenSSL,
  IdExplicitTLSClientServerBase;

type
  TNotificacaoEmail = class
    private

    public
      class procedure EnviarNotificacao(aEmailCliente: String;
        aUrlImagem: TStringList);
  end;

implementation

{ TNotificacaoEmail }

class procedure TNotificacaoEmail.EnviarNotificacao(
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
    xSocketSSL.Host := SMTP;
    xSocketSSL.Port := PORTA;
    xSMTP.IOHandler := xSocketSSL;
    xSMTP.Host := SMTP;
    xSMTP.Port := PORTA;
    xSMTP.AuthType := satDefault;
    xSMTP.Username := EMAIL;
    xSMTP.Password := PASSWORD;
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

end.
