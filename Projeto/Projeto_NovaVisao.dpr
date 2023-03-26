program Projeto_NovaVisao;

uses
  System.StartUpCopy,
  FMX.Forms,
  UfrmHome in 'views\UfrmHome.pas' {frmHome},
  UUtils.Enum in 'Utils\UUtils.Enum.pas',
  UfrmEnviar in 'views\UfrmEnviar.pas' {Form1},
  UService.Imagem in 'service\UService.Imagem.pas',
  UfrmCadastrar in 'views\UfrmCadastrar.pas' {frmCadastro},
  UfrmSistema in 'views\UfrmSistema.pas' {frmSistema},
  UfrmImagens in 'views\UfrmImagens.pas' {frmImagens},
  UService.ChatGPT in 'service\UService.ChatGPT.pas',
  UDao.Cliente in 'Dao\UDao.Cliente.pas',
  uEntity.Cliente in 'Entities\uEntity.Cliente.pas',
  UUtils.Banco in 'Utils\UUtils.Banco.pas',
  UUtils.Consts in 'Utils\UUtils.Consts.pas',
  UDM in 'service\UDM.pas' {DM: TDataModule},
  UService.NotificacaoApp in 'service\UService.NotificacaoApp.pas',
  UService.NotificacaoEmail in 'service\UService.NotificacaoEmail.pas',
  UUtils.Notificacao in 'Utils\UUtils.Notificacao.pas';

{$R *.res}

begin
  //ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TfrmHome, frmHome);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
