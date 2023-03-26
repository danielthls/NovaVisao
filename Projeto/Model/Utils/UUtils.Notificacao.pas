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
begin
  case OpEnumEnviar(aTipoNotificacao) of
    opEnviarPorApp:
      TNotificacaoApp.EnviarNotificacao(Self.FCliente.Telefone, Self.FUrlImagem);
    opEnviarPorEmail :
      TNotificacaoEmail.EnviarNotificacao(Self.FCliente.Email, Self.FUrlImagem);
    opEnviarAmbos :
    begin
      TNotificacaoEmail.EnviarNotificacao(Self.FCliente.Email, Self.FUrlImagem);;
      TNotificacaoApp.EnviarNotificacao(Self.FCliente.Telefone, Self.FUrlImagem);
    end;
  end;
end;


end.
