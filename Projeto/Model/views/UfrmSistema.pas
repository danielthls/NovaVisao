unit UfrmSistema;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, UDao.Cliente, UEntity.Cliente,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.ListBox, FMX.Edit, FMX.Controls.Presentation, FMX.Layouts,
  FMX.MultiView, UService.Imagem, FireDAC.UI.Intf, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Intf, FireDAC.Comp.UI;

type
  TfrmSistema = class(TForm)
    rectPrincipal: TRectangle;
    btnMenu: TSpeedButton;
    lytContainer: TLayout;
    imgNovaVisao: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtCliente: TEdit;
    edtCaminhoIMG: TEdit;
    cmbVariacoes: TComboBox;
    rectAvancar: TRectangle;
    Label4: TLabel;
    MultiView1: TMultiView;
    Rectangle1: TRectangle;
    lytLogo: TLayout;
    imgLogo: TImage;
    lstMenu: TListBox;
    rectVoltar: TRectangle;
    Label5: TLabel;
    btnProcurar1: TButton;
    btnBuscar1: TButton;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure rectAvancarClick(Sender: TObject);
    procedure rectVoltarClick(Sender: TObject);
    procedure lstMenuItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure btnProcurar1Click(Sender: TObject);
    procedure imgNovaVisaoClick(Sender: TObject);
    procedure btnBuscar1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }

    procedure btnBuscarClick(Sender: TObject);
    function BuscarCliente(aCliente: String): boolean;
    //
    procedure ProcurarImagem;
  public
    { Public declarations }
    procedure AbrirCadastro;
    procedure AbrirEnviar;
  end;

var
  frmSistema: TfrmSistema;

implementation

uses
  UDM, UUtils.Enum, UfrmEnviar, UfrmCadastrar;

{$R *.fmx}
{ TForm2 }

procedure TfrmSistema.AbrirCadastro;
begin
  if not Assigned(frmCadastrar) then
  begin
    Application.CreateForm(TfrmCadastrar, frmCadastrar);
  end;
  frmCadastrar.Show();
  Self.Hide;
end;

procedure TfrmSistema.AbrirEnviar;
begin
  if not Assigned(frmEnviar) then
  begin
    Application.CreateForm(TfrmEnviar, frmEnviar);
  end;
  frmEnviar.Show();
  Self.Hide;
end;

procedure TfrmSistema.btnBuscar1Click(Sender: TObject);
begin
  if (buscarCliente(edtCliente.Text)) then


end;

procedure TfrmSistema.btnBuscarClick(Sender: TObject);
begin

end;

procedure TfrmSistema.btnProcurar1Click(Sender: TObject);
begin
  ProcurarImagem;
end;

function TfrmSistema.BuscarCliente(aCliente: String): Boolean;
var
  xDaoCliente : TDAOCliente;
begin
  xDaoCliente := TDAOCliente.Create;
  try
    DM.xCliente := xDaoCliente.ProcurarCliente(edtCliente.Text);
    try
      if DM.xCliente <> nil then
      begin
        ShowMessage('Cliente "'+ DM.xCliente.Nome + '" foi encontrado!');
        edtCliente.Text := DM.xCliente.Nome;
        if assigned(DM.xServiceChatGPT) then
          FreeAndNil(DM.xServiceChatGPT);
        Result := True
      end
      else
        ShowMessage('Nenhum registro encontrado!');
        Result := False
    finally
  //    FreeAndNil(xCliente);
    end;
  finally
    FreeAndNil(xDaoCliente);
  end;
end;

procedure TfrmSistema.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;

  frmSistema := nil;
end;

procedure TfrmSistema.imgNovaVisaoClick(Sender: TObject);
begin
  MultiView1.HideMaster;
end;

procedure TfrmSistema.lstMenuItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin

  case TEnumMenu(Item.Index) of
    mnuHome:
      Self.Close;
    mnuCadastrar:
      Self.AbrirCadastro;
    mnuSair:
      Self.Close;
  end;

  MultiView1.HideMaster;
end;


procedure TfrmSistema.ProcurarImagem;
var
  xImagem: TServiceImagem;
begin
  xImagem := TServiceImagem.Create;
  try
    xImagem.CarregarImagem;
    edtCaminhoIMG.Text := xImagem.CaminhoImagem;
    xImagem.CriarImagemTemporaria;
    if not((xImagem.BitmapOriginal.Width = 0) and
      (xImagem.BitmapOriginal.Height = 0)) then
    begin
   // showMessage('abilitou');
      rectAvancar.Enabled := True;
    end;
  finally
    FreeAndNil(xImagem);
  end;
end;

procedure TfrmSistema.rectAvancarClick(Sender: TObject);
begin
  Self.AbrirEnviar;
end;

procedure TfrmSistema.rectVoltarClick(Sender: TObject);
begin
  Self.Close;
end;

end.
