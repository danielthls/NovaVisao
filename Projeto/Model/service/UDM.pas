unit UDM;

interface

uses
  UEntity.Cliente, UService.ChatGPT, System.SysUtils, System.Classes;

type
  TDM = class(TDataModule)
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
  var
    xCliente: TCliente;
    xServiceChatGPT: TServiceChatGPT;
    xStringList: TStringList;
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(xCliente) then
    FreeAndNil(xCliente);
  if Assigned(xServiceChatGPT) then
    FreeAndNil(xServiceChatGPT);
end;

end.
