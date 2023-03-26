unit UfrmCadastrar;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, Udao.Cliente, uEntity.Cliente,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts, FMX.Edit;

type
  TfrmCadastrar = class(TForm)
    rectPrincipal: TRectangle;
    lytContainer: TLayout;
    imgNovavisao: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    rectCadastrar: TRectangle;
    Label4: TLabel;
    rectVoltar: TRectangle;
    Label5: TLabel;
    edtNome: TEdit;
    edtCelular: TEdit;
    edtEmail: TEdit;
    procedure AdicionarCliente;
    procedure rectVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rectCadastrarClick(Sender: TObject);
  private
    { Private declarations }
    procedure VoltarSistema;
  public
    { Public declarations }
  end;

var
  frmCadastrar: TfrmCadastrar;

implementation

uses
  UfrmSistema,
  uBitmapHelper;

{$R *.fmx}
{ TfrmCadastro }

procedure TfrmCadastrar.VoltarSistema;
begin
  if not Assigned(frmSistema) then
  begin
    Application.CreateForm(TfrmSistema, frmSistema);
  end;
  frmSistema.Show();
  Self.Hide;
end;

procedure TfrmCadastrar.AdicionarCliente;
var
xDaoCliente : TDAOCliente;
xCliente : TCliente;
begin
  xDaoCliente := TDAOCliente.Create;
  xCliente := TCliente.Create(edtNome.Text, edtEmail.Text, edtCelular.text);
  try
   xDaoCliente.AdicionarRegistro(xCliente);

  finally
    xCliente.Free;
    xDaoCliente.Free;
  end;

end;

procedure TfrmCadastrar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  Action := TCloseAction.caFree;
  FreeAndNil(frmCadastrar);
end;

procedure TfrmCadastrar.rectCadastrarClick(Sender: TObject);
begin
    self.AdicionarCliente;
end;

procedure TfrmCadastrar.rectVoltarClick(Sender: TObject);
begin
  Self.VoltarSistema;
end;

end.
