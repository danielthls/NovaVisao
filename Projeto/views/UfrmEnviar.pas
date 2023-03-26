unit UfrmEnviar;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, UService.ChatGPT,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox,
  FMX.MultiView, UEntity.Cliente, UUtils.Enum;

type
  TfrmEnviar = class(TForm)
    rectPrincipal: TRectangle;
    lytContainer: TLayout;
    imgNovavisao: TImage;
    gbFormasEnvio: TGroupBox;
    rbEmail: TRadioButton;
    rbCelular: TRadioButton;
    rbAmbos: TRadioButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblNome: TLabel;
    lblCelular: TLabel;
    lblEmail: TLabel;
    rectEnviar: TRectangle;
    Label4: TLabel;
    rectVoltar: TRectangle;
    Label5: TLabel;
    rectExibirImagens: TRectangle;
    Label6: TLabel;
    procedure rectVoltarClick(Sender: TObject);
    procedure rectExibirImagensClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rectEnviarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    procedure VoltarSistema;
    procedure ObterLinks;
    procedure SolicitarNotificacao;
    function DefinirTipoNotificacao: opEnumEnviar;
  public
    { Public declarations }
  end;

var
  frmEnviar: TfrmEnviar;

implementation

uses
  UfrmSistema,
  UDM,
  UfrmImagens,
  UUtils.Notificacao;

{$R *.fmx}

procedure TfrmEnviar.VoltarSistema;
begin
  if not Assigned(frmSistema) then
  begin
    Application.CreateForm(TfrmSistema, frmSistema);
  end;
  frmSistema.Show();
  Self.Hide;
end;

procedure TfrmEnviar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;

  frmEnviar := nil;
end;

procedure TfrmEnviar.FormCreate(Sender: TObject);
begin
  ObterLinks;

  end;

procedure TfrmEnviar.FormShow(Sender: TObject);
begin
  if DM.xCliente <> nil then
  begin
  lblNome.Text := DM.xCliente.Nome;
  lblEmail.Text := DM.xCliente.Email;
  lblCelular.Text := DM.xCliente.Telefone;
  end;
end;



{Definir tipo de notificação}
function TfrmEnviar.DefinirTipoNotificacao: opEnumEnviar;
begin
  if rbEmail.IsChecked then
      Result := opEnumEnviar.opEnviarPorEmail
  else if rbCelular.IsChecked then
    Result := opEnumEnviar.opEnviarPorApp
  else
    Result := opEnumEnviar.opEnviarAmbos;
end;

{Solicitar o Service de notificação}
procedure TfrmEnviar.SolicitarNotificacao;
var
  aNotificacao: TNotificacao;
begin
  aNotificacao := TNotificacao.Create(DM.xCliente, DM.xServiceChatGPT.ListaLinks);
  try
    aNotificacao.SolicitarNotificacao(DefinirTipoNotificacao);
  finally
    FreeAndNil(aNotificacao);
  end;
end;

procedure TfrmEnviar.ObterLinks;
begin
  if not (Assigned(DM.xServiceChatGPT)) then
    DM.xServiceChatGPT := TServiceChatGPT.Create(frmSistema.cmbVariacoes.Items[frmSistema.cmbVariacoes.ItemIndex]);

  if not (DM.xServiceChatGPT.LinksGerados) then
    DM.xServiceChatGPT.FormarRequest;

end;

{Instancia ChatGPT, gera links e solicita a notificação}
procedure TfrmEnviar.rectEnviarClick(Sender: TObject);
begin

  SolicitarNotificacao;

end;

procedure TfrmEnviar.rectExibirImagensClick(Sender: TObject);
begin
  if not Assigned(frmImagens) then
  begin
    Application.CreateForm(TfrmImagens, frmImagens);
  end;
  frmImagens.Show();
  Self.Hide;
end;

procedure TfrmEnviar.rectVoltarClick(Sender: TObject);
begin
  Self.VoltarSistema;
end;

end.
