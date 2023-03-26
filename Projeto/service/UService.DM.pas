unit UService.DM;

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
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(xCliente);
  FreeAndNil(xServiceChatGPT);
end;

end.
