unit UService.ChatGPT;
interface
uses
  System.JSON, System.Net.HttpClient, Classes, UService.Imagem, SysUtils,
  System.Net.Mime, Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Dataset.Serialize,
  //TESTE
  System.IOUtils;
type
  TServiceChatGPT = class
  private
    FToken: String;
    FN: String;
    FLinksGerados: Boolean;
    FClient: THTTPClient;
    FJSONObject: TJSONObject;
    FJSONArray: TJSONArray;
    //FmtResponse: TFDMemTable;
    //mtData: TFDMemTable;
    //FdsResponse: TDataSource;
    FListaLinks: TStringList;
    //function GetN: string;
    function GetListaLinks: TStringList;
    procedure RemoverBarraJSON;
    //function GetmtData: TFDMemTable;
    //procedure SetmtData(const Value: TFDMemTable);
    function GetLinksGerados: Boolean;
    procedure CarregarToken;
    Const
      SIZE = '256x256';
      IMAGE = 'imagemTemporaria.png';
      URL = 'https://api.openai.com/v1/images/variations';
      ARQUIVO_TOKEN = 'token.jwt';
      DATA_KEY = 'data';
  public
    //property N: string read GetN;
    property ListaLinks: TStringList read GetListaLinks;
    property LinksGerados: Boolean read GetLinksGerados;
    //property mtData: TFDMemTable read mtData write SetmtData;
    //constructor Create(aN: String; aTabelaPrincipal, aTabelaData: TFDMemTable; aDataSource: TDataSource);
    constructor Create(aN: String);
    destructor Destroy; override;

    //procedure ConfigurarTabelas;
    procedure FormarRequest;
    function ObterLinks: TStringList;
    //function ObterMensagemErro(aResponse: String): String;


  end;
implementation
{ TServiceChatGPT }

procedure TServiceChatGPT.CarregarToken;
var
  xStringList: TStringList;
begin
  xStringList := TStringList.Create;
  xStringList.LoadFromFile(ARQUIVO_TOKEN);
  if xStringList.Count > 0 then
      FToken := xStringList[0];
end;

{procedure TServiceChatGPT.ConfigurarTabelas;
begin
  FdsResponse.DataSet := FmtResponse;

  // Set the dataset for mtData
  mtData.Active := true;
  mtData.Close;
  mtData.FieldDefs.Clear;
  mtData.FieldDefs.Assign(FmtResponse.FieldDefs);
  mtData.CreateDataSet;
  mtData.MasterSource := FdsResponse;
  mtData.MasterFields := 'data';

  FmtResponse.Open;
  mtData.Open;
end;}

constructor TServiceChatGPT.Create(aN: String);
//constructor TServiceChatGPT.Create(aN: String; aTabelaPrincipal, aTabelaData: TFDMemTable; aDataSource: TDataSource);
begin
  FClient := THTTPClient.Create;
  //FRequest := TStringStream.Create;
  FListaLinks := TStringList.Create;
  FLinksGerados := False;
  FN := aN;
  CarregarToken;
  {FmtResponse := aTabelaPrincipal;
  mtData := aTabelaData;
  FdsResponse := aDataSource;}

end;

destructor TServiceChatGPT.Destroy;
begin
  FreeAndNil(FClient);
  //FreeAndNil(FRequest);
  FreeAndNil(FListaLinks);
  //FreeAndNil(FmtResponse);
  //FreeAndNil(mtData);
  //FreeAndNil(FdsResponse);
  FreeAndNil(FJSONObject);
  inherited;
end;

procedure TServiceChatGPT.FormarRequest;
var
  xFormData: TMultipartFormData;
  xResponse: TStringStream;
  xStreamTest: TStreamReader;
  xResponseCode: Integer;
  //TESTE
  xJSONFile: String;
  xHTTPResponse: IHTTPResponse;
begin

  xFormData := TMultipartFormData.Create;
  xResponse :=  TStringStream.Create;
  //xStreamTest := TStreamReader.Create('file.json');
  try
    FClient.CustomHeaders['Authorization'] := 'Bearer ' + FToken;
    xFormData.AddFile('image', IMAGE);
    xFormData.AddField('n', FN);
    xFormData.AddField('size',SIZE);
    xHTTPResponse := FClient.Post(URL, xFormData, xResponse);
    TServiceImagem.ExcluirImagemTemporaria;
    xResponseCode := xHTTPResponse.StatusCode;

    xJSONFile := xResponse.DataString;
    TFile.WriteAllText('file.json', xJSONFile);
    //Comentar até aqui

    //Para testar sem puxar o API - Descomentar
    //xJSONFile := TFile.ReadAllText('file.json');
    FJSONObject := TJSONObject.ParseJSONValue(xJSONFile) as TJSONObject;

    xJSONFile := FJSONObject.ToString;

    TFile.WriteAllText('FJSONObject.json', xJSONFile);
    FJSONArray := FJSONObject.GetValue<TJSONArray>('data');

    xJSONFile := FJSONArray.ToString;

    TFile.WriteAllText('FJSONArray.json', xJSONFile);

    //FmtResponse.LoadFromJson(xResponse.DataString);

    //FmtResponse.LoadFromJSON(xJSONFile);
    //ConfigurarTabelas;
  finally
    FreeAndNil(xFormData);
    FreeAndNil(xResponse);
    //FreeAndNil(xStreamTest);
  end;

  ObterLinks;

end;

function TServiceChatGPT.GetLinksGerados: Boolean;
begin
  Result := FLinksGerados;
end;

function TServiceChatGPT.GetListaLinks: TStringList;
begin
  Result := FListaLinks;
end;

{function TServiceChatGPT.GetmtData: TFDMemTable;
begin
  Result := mtData;
end;}

{function TServiceChatGPT.GetN: string;
begin
  Result := FN;
end;}


function TServiceChatGPT.ObterLinks: TStringList;
var
  //xJSONArray: TJSONArray;
  i, j: Integer;
  ConteudoCampo: string;

begin


  {for i := 0 to mtData.RecordCount - 1 do
    begin
      mtData.RecNo := i + 1;
      for j := 0 to mtData.FieldCount - 1 do
      begin
        ConteudoCampo := mtData.Fields[j].AsString;
        FListaLinks.Add(ConteudoCampo);
      end;
    end;
  }

  for I := 0 to Pred(FJSONArray.Count) do
    FListaLinks.Add(FJSONArray.Get(I).GetValue<string>('url'));

  FLinksGerados := true;
  Result := FListaLinks;


end;

{function TServiceChatGPT.ObterMensagemErro(aResponse: String): String;
var
  xJSONError: TJSONObject;
  xJSONObject: TJSONObject;
begin
  xJSONObject := TJSONObject.ParseJSONValue(aResponse) as TJSONObject;
  xJSONError := xJsonObject.GetValue('error') as TJSONObject;
  Result := xJSONError.GetValue<String>('message');
  FreeAndNil(xJSONError);
  xJSONObject := nil;
end;}

procedure TServiceChatGPT.RemoverBarraJSON;
var
  I: Integer;
begin
  {for I := 0 to Pred(FListaLinks.Count) do
    FListaLinks[I].Replace('\/', '/', [rfReplaceAll]);}
end;

{procedure TServiceChatGPT.SetmtData(const Value: TFDMemTable);
begin
  mtData := Value;
end;}

end.
