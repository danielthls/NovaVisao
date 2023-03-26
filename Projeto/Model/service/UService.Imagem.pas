unit UService.Imagem;

interface

uses fmx.Dialogs, SysUtils, fmx.Graphics, Classes, System.Types;

type
  TServiceImagem = class
  private

    FBitmapOriginal: TBitmap;
    FBitmapCopia: TBitmap;
    FOpenDialog: TOpenDialog;

    FCaminhoImagem: String;
    function GetCaminhoImagem: String;
    function GetBitmapOriginal: TBitmap;
    function GetBitmapCopia: TBitmap;

  public

    property BitmapOriginal: TBitmap read GetBitmapOriginal;
    property BitmapCopia: TBitmap read GetBitmapCopia;
    property CaminhoImagem: String read GetCaminhoImagem;
    constructor Create;
    destructor Destroy; override;
    procedure CarregarImagem;
    procedure RedimensionarImagem;
    procedure CriarImagemTemporaria;
    class procedure ExcluirImagemTemporaria;
  end;

implementation

{ TImagem }

procedure TServiceImagem.CarregarImagem;
begin
  if FOpenDialog.Execute then
  begin
    FCaminhoImagem := FOpenDialog.FileName;
    FBitmapOriginal.LoadFromFile(FCaminhoImagem);
  end;
end;

constructor TServiceImagem.Create;
begin
  FCaminhoImagem := 'Nenhuma imagem selectionada';
  FOpenDialog := TOpenDialog.Create(nil);
  FOpenDialog.Filter := 'Arquivos PNG (*.png)|*.png';
  FBitmapOriginal := TBitmap.Create;
  FBitmapCopia := TBitmap.Create;

end;

procedure TServiceImagem.CriarImagemTemporaria;
const
  IMAGEM_TEMPORARIA = 'imagemTemporaria.png';
begin
  if not((FBitmapOriginal.Width = 0) and (FBitmapOriginal.Height = 0)) then
  begin
    { FBitmapCopia.SetSize(FBitmapOriginal.Width, FBitmapOriginal.Height);
      FBitmapCopia.Canvas.BeginScene;
      try
      FBitmapCopia.Canvas.DrawBitmap(FBitmapOriginal, RectF(0, 0, FBitmapOriginal.Width, FBitmapOriginal.Height),
      RectF(0, 0, FBitmapCopia.Width, FBitmapCopia.Height), 1);
      finally
      FBitmapCopia.Canvas.EndScene;
      end; }

    // FBitmapCopia.Assign(FBitmapOriginal);
    RedimensionarImagem;
    FBitmapCopia.SaveToFile(IMAGEM_TEMPORARIA)
  end
  {else
    raise Exception.Create('Erro: Nenhuma imagem foi carregada');}
end;

destructor TServiceImagem.Destroy;
begin
  FreeAndNil(FBitmapOriginal);
  FreeAndNil(FBitmapCopia);
  FreeAndNil(FOpenDialog);
  inherited;
end;

class procedure TServiceImagem.ExcluirImagemTemporaria;
begin
  if FileExists('ImagemTemporaria.png') then
    DeleteFile('ImagemTemporaria.png')

end;

function TServiceImagem.GetBitmapCopia: TBitmap;
begin
  Result := FBitmapCopia;
end;

function TServiceImagem.GetBitmapOriginal: TBitmap;
begin
  Result := FBitmapOriginal;
end;

function TServiceImagem.GetCaminhoImagem: String;
begin
  Result := FCaminhoImagem;
end;

procedure TServiceImagem.RedimensionarImagem;
const
  ALTURA = 256;
  LARGURA = 256;
var
    xBitmapTemp: TBitmap;
    SrcRect, DstRect: TRectF;
begin
    xBitmapTemp:= TBitmap.Create;
    try
    xBitmapTemp.SetSize(LARGURA, ALTURA);
    SrcRect := TRectF.Create(0, 0, FBitmapOriginal.Width, FBitmapOriginal.Height);
    DstRect := TRectF.Create(0, 0, LARGURA, ALTURA);
    xBitmapTemp.Canvas.BeginScene;
    xBitmapTemp.Canvas.DrawBitmap(FBitmapOriginal, SrcRect, DstRect, 1);
    xBitmapTemp.Canvas.EndScene;

    // Copy the resized bitmap to the target bitmap
    FBitmapCopia.Assign(xBitmapTemp);
  finally
    xBitmapTemp.Free;
  end;
{begin
  FBitmapCopia.Assign(FBitmapOriginal);
  FBitmapCopia.SetSize(256, 256); // Altera as dimensões do TBitmap vazio}
end;

end.
