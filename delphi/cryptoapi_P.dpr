program cryptoapi_P;

uses
  Vcl.Forms,
  cryptoapi_U in 'cryptoapi_U.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
