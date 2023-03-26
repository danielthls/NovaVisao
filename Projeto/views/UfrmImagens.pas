unit UfrmImagens;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, UDM,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TfrmImagens = class(TForm)
    rectPrincipal: TRectangle;
    rectVoltar: TRectangle;
    Label5: TLabel;
    recImagens: TRectangle;
    Label1: TLabel;
    lytImagens: TLayout;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    imgNovavisao: TImage;
    procedure rectVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    procedure AdicionaImagensATela(aListaLinks: TStringList);
    procedure LimpaTImage;
    procedure VoltarSistema;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImagens: TfrmImagens;

implementation

{$R *.fmx}

uses
  UfrmEnviar,
  uBitmapHelper;

procedure TfrmImagens.AdicionaImagensATela(aListaLinks: TStringList);
var
  // variaveis de controle
  i, j: integer;
begin
  // For percorrendo o Stringlist com urls,importando elas para um TImage
  // as redimensionando enquanto coloca os componentes visiveis
  try
    j := -1;
     for i := 0 to aListaLinks.Count - 1 do
    begin
      inc(j);
      while not(frmImagens.Components[j] is TImage) or
        (frmImagens.Components[i] = imgNovavisao) do
        inc(j);
      if frmImagens.Components[j] is TImage then
      begin
        TImage(frmImagens.Components[j]).Bitmap.LoadFromUrl(aListaLinks[i]);
      end;
    end;
  finally
   // aListaLinks.Free;
  end;
end;

procedure TfrmImagens.FormActivate(Sender: TObject);
begin
  Self.LimpaTImage;
  Self.AdicionaImagensATela(dm.xServiceChatGPT.ListaLinks);
end;

procedure TfrmImagens.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TfrmImagens.LimpaTImage;
var
  i: integer;
begin
  // Limpa todos o TImage, novamente exceto o frmImagens (LOGO)
  for i := 0 to frmImagens.ComponentCount - 1 do
    if (frmImagens.Components[i] is TImage) and
      not(frmImagens.Components[i] = imgNovavisao) then
    begin
      TImage(frmImagens.Components[i]).Bitmap := nil;
    end;
end;

procedure TfrmImagens.VoltarSistema;
begin
  if not Assigned(frmEnviar) then
  begin
    Application.CreateForm(TfrmEnviar, frmEnviar);
  end;
  frmEnviar.Show();
  Self.Hide;
end;

procedure TfrmImagens.rectVoltarClick(Sender: TObject);
begin
  Self.LimpaTImage;
  Self.VoltarSistema;
end;

end.
