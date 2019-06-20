unit uTestDLL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    edtName: TEdit;
    edtPhone: TEdit;
    btnSearch: TButton;
    Label1: TLabel;
    Label2: TLabel;
    rb1: TRadioButton;
    rb2: TRadioButton;
    btnclose: TButton;
    rb3: TRadioButton;
    procedure btnSearchClick(Sender: TObject);
    procedure btncloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
procedure openRegCardForm(pType: integer; pCardNo: string; pIDNO: string); stdcall; external 'dllGhRegCard.dll';

procedure TForm1.btnSearchClick(Sender: TObject);
begin
  if rb1.Checked then openRegCardForm(0, Trim(edtName.Text), '');
  if rb2.Checked then openRegCardForm(1, Trim(edtName.Text), '');
  if rb3.Checked then openRegCardForm(4, Trim(edtName.Text), '');//Trim(edtPhone.Text)
end;

procedure TForm1.btncloseClick(Sender: TObject);
begin
  Close;
end;

end.

