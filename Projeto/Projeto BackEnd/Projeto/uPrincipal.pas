unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  Vcl.StdCtrls, FireDAC.Phys.ODBCBase, Vcl.Mask, Vcl.DBCtrls;

type
  TForm2 = class(TForm)
    GroupBox1: TGroupBox;
    FDConnection1: TFDConnection;
    edtNome: TEdit;
    edtEmail: TEdit;
    edtFone: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnGravar: TButton;
    GroupBox2: TGroupBox;
    btnPesquisar: TButton;
    edtNomeConsulta: TEdit;
    Label4: TLabel;
    edtCodigo: TEdit;
    Label5: TLabel;
    FDTransaction1: TFDTransaction;
    fdConect: TFDTransaction;
    tfdConectDataBase: TFDConnection;
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses UDaoCliente, uEntity.Cliente, UUtils.Banco;

procedure TForm2.btnGravarClick(Sender: TObject);
var
  DaoCliente : TDAOCliente;
  Cliente: TCliente;
begin
  DaoCliente := TDAOCliente.Create;
  try
    Cliente := TCliente.Create(0,edtNome.Text,edtEmail.Text,edtFone.Text);
    try
      if DaoCliente.AdicionarRegistro(Cliente) then
        ShowMessage('Cliente Adicionado!');
    finally
      FreeAndNil(Cliente);
    end;

  finally
    FreeAndNil(DaoCliente);
  end;
end;

procedure TForm2.btnPesquisarClick(Sender: TObject);
var
  DaoCliente : TDAOCliente;
  Cliente: TCliente;
begin
  DaoCliente := TDAOCliente.Create;
  try
    Cliente := nil;
    if (Trim(edtCodigo.Text) <> EmptyStr) and (StrToIntDef(Trim(edtCodigo.Text),0) <> 0) then
      Cliente := DaoCliente.ProcurarCliente(StrToIntDef(Trim(edtCodigo.Text),0), EmptyStr)
    else
      Cliente := DaoCliente.ProcurarCliente(0,edtNomeConsulta.Text);
    try
      if Cliente <> nil then
      begin
        ShowMessage('Cliente "'+ IntToStr(Cliente.Id) + ' - ' + Cliente.Nome + '" foi encontrado!');
        edtNome.Text := Cliente.Nome;
        edtCodigo.Text := Cliente.Id.ToString;
      end
      else
        ShowMessage('Nenhum registro encontrado!');
    finally
      FreeAndNil(Cliente);
    end;
  finally
    FreeAndNil(DaoCliente);
  end;
end;

end.
