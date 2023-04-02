unit UUtils.Notificacao;

interface

uses
   System.Classes,
   UEntity.Cliente,
   UUtils.Enum;
type
  TNotificacao = class
    private
      FCliente: TCliente;
      FUrlImagem: TStringList;
    public
      constructor Create(aCliente : TCliente; aUrlImagem: TStringList);
      destructor Destroy; override;

      procedure SolicitarNotificacao(aTipoNotificacao: OpEnumEnviar);
  end;

implementation

{ TNotificacao }

uses
   UService.NotificacaoApp,
   UService.NotificacaoEmail,
   System.SysUtils;

{Constructor}
constructor TNotificacao.Create(aCliente: TCliente; aUrlImagem: TStringList);
begin
  Self.FCliente   := aCliente;
  Self.FUrlImagem := aUrlImagem;
end;

{Destructor}
destructor TNotificacao.Destroy;
begin
  //FreeAndNil(Self.FCliente);
  //FreeAndNil(Self.FUrlImagem);
  inherited;
end;

{Solicitar notificação}
procedure TNotificacao.SolicitarNotificacao(aTipoNotificacao: OpEnumEnviar);
var
  xNotificacaoEmail: TNotificacaoEmail;
begin
  xNotificacaoEmail := TNotificacaoEmail.Create;
  try
  case OpEnumEnviar(aTipoNotificacao) of
    opEnviarPorApp:
      TNotificacaoApp.EnviarNotificacao(Self.FCliente.Telefone, Self.FUrlImagem);
    opEnviarPorEmail :
      xNotificacaoEmail.EnviarNotificacao(Self.FCliente.Email, Self.FUrlImagem);
    opEnviarAmbos :
    begin
      xNotificacaoEmail.EnviarNotificacao(Self.FCliente.Email, Self.FUrlImagem);;
      TNotificacaoApp.EnviarNotificacao(Self.FCliente.Telefone, Self.FUrlImagem);
    end;
  end;
  finally
    FreeAndNil(xNotificacaoEmail);
  end;
end;


end.
