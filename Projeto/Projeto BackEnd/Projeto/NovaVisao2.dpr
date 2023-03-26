program NovaVisao2;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {Form2},
  uEntity.Cliente in 'uEntity.Cliente.pas',
  UUtils.Banco in 'UUtils.Banco.pas',
  UDaoCliente in 'UDaoCliente.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
