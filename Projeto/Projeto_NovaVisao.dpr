program Projeto_NovaVisao;

uses
  FastMM4,
  FastMM4Messages,
  System.StartUpCopy,
  FMX.Forms,
  UDao.Cliente in 'Model\Dao\UDao.Cliente.pas',
  uEntity.Cliente in 'Model\Entities\uEntity.Cliente.pas',
  UDM in 'Model\service\UDM.pas' {DM: TDataModule},
  UService.ChatGPT in 'Model\service\UService.ChatGPT.pas',
  UService.Imagem in 'Model\service\UService.Imagem.pas',
  UService.NotificacaoApp in 'Model\service\UService.NotificacaoApp.pas',
  UService.NotificacaoEmail in 'Model\service\UService.NotificacaoEmail.pas',
  UUtils.Banco in 'Model\Utils\UUtils.Banco.pas',
  UUtils.Consts in 'Model\Utils\UUtils.Consts.pas',
  UUtils.Enum in 'Model\Utils\UUtils.Enum.pas',
  UUtils.Notificacao in 'Model\Utils\UUtils.Notificacao.pas',
  UfrmCadastrar in 'Model\views\UfrmCadastrar.pas' {frmCadastrar},
  UfrmEnviar in 'Model\views\UfrmEnviar.pas' {frmEnviar},
  UfrmHome in 'Model\views\UfrmHome.pas' {frmHome},
  UfrmImagens in 'Model\views\UfrmImagens.pas' {frmImagens},
  UfrmSistema in 'Model\views\UfrmSistema.pas' {frmSistema},
  UEntity.Email in 'Model\Entities\UEntity.Email.pas';

{$R *.res}

begin
  //ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmHome, frmHome);
  Application.Run;
end.
