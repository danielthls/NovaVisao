unit UService.NotificacaoApp;

interface

uses
  Notify,
  System.Classes;

type
  TNotificacaoApp = class
    private

    public
      class procedure EnviarNotificacao(aTelefoneCliente: String;
                     aUrlImagem: TStringList);
  end;

implementation

uses
  System.SysUtils, Fmx.Dialogs;


{ TNotificacaoApp }

class procedure TNotificacaoApp.EnviarNotificacao(aTelefoneCliente: String;
  aUrlImagem: TStringList);
var
  I: Integer;
  xCorpoDaMensagem: String;
begin
  for I := 0 to pred(aUrlImagem.Count) do
  begin
    xCorpoDaMensagem := xCorpoDaMensagem + (I+1).ToString + 'ª Url da imagem: '
                        + aUrlImagem[I] + #1310;
  end;

  try
    Ntfy.Notification(
      New.Notification
        .Topic(aTelefoneCliente)
        .Title('Suas variações de imagem já estão prontas!')
        .MessageContent('Seguem os links de acesso:' + xCorpoDaMensagem)
    );
    Ntfy.Publish;

    ShowMessage('Sua solicitação de notificação foi registrada!');
  except on E: Exception do
      raise Exception.Create('Erro ao enviar notificação: ' + E.Message);
  end;
end;

end.
