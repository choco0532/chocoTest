unit uMzRegCard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, SUIButton, SUIComboBox, ExtCtrls, Grids, IniFiles,
  DBGridEh, DB, ADODB, DBCtrls, Mask;

type
  TFMzRegCard = class(TForm)
    adoConn: TADOConnection;
    lblTitle: TLabel;
    Shape1: TShape;
    qryCard: TADOQuery;
    qryCardDetail: TADOQuery;
    qryTemp: TADOQuery;
    tmrclose: TTimer;
    grp01: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    lblMSG: TLabel;
    edtCardNo: TEdit;
    edtCardID: TEdit;
    edtName: TEdit;
    cbbType: TComboBox;
    edtTelePhone: TEdit;
    edtAddress: TEdit;
    edtIDNO: TEdit;
    Panel2: TPanel;
    Shape2: TShape;
    btnSave: TsuiButton;
    btnExit: TsuiButton;
    btnReadIDCard: TsuiButton;
    edtEncryptCardNo: TEdit;
    spGetNextVoucher: TADOStoredProc;
    pnl1: TPanel;
    dtpBirthday: TDateTimePicker;
    Label9: TLabel;
    rb2: TRadioButton;
    rb1: TRadioButton;
    Label8: TLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmrcloseTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    
  public
    
  end;

var
  FMzRegCard: TFMzRegCard;

procedure openRegCardForm(pType: integer; pCardNo: string; pIDNO: string); stdcall;

exports
  openRegCardForm;

implementation

{$R *.dfm}
var
  strSQL, strCardNo, strCardID, strIDNO: string;
  intType: Integer;  
  intSex:Integer;
function IsValidPID(const pAPID: string; var pBirthDate: string): string;

  function GetVerifyBit(sIdentityNum: string): Char;
  var
    nNum: Integer;
  begin
    Result := #0;
    nNum := StrToInt(sIdentityNum[1]) * 7 + StrToInt(sIdentityNum[2]) * 9 + StrToInt(sIdentityNum[3]) * 10 + StrToInt(sIdentityNum[4]) * 5 + StrToInt(sIdentityNum[5]) * 8 + StrToInt(sIdentityNum[6]) * 4 + StrToInt(sIdentityNum[7]) * 2 + StrToInt(sIdentityNum[8]) * 1 + StrToInt(sIdentityNum[9]) * 6 + StrToInt(sIdentityNum[10]) * 3 + StrToInt(sIdentityNum[11]) * 7 + StrToInt(sIdentityNum[12]) * 9 + StrToInt(sIdentityNum[13]) * 10 + StrToInt(sIdentityNum[14]) * 5 + StrToInt(sIdentityNum[15]) * 8 + StrToInt(sIdentityNum[16]) * 4 + StrToInt(sIdentityNum[17]) * 2;
    nNum := nNum mod 11;
    case nNum of
      0:
        Result := '1';
      1:
        Result := '0';
      2:
        Result := 'X';
      3:
        Result := '9';
      4:
        Result := '8';
      5:
        Result := '7';
      6:
        Result := '6';
      7:
        Result := '5';
      8:
        Result := '4';
      9:
        Result := '3';
      10:
        Result := '2';
    end;
  end;

var
  L: Integer;
  sCentury: string;
  sYear2Bit, sYear4Bit: string;
  sMonth: string;
  sDate: string;
  iCentury: Integer;
  iMonth: Integer;
  iDate: Integer;
  CRCFact: string; 
  CRCTh: string; 
  FebDayAmt: Byte; 
begin
  L := Length(pAPID);
  if (L in [15, 18]) = False then
  begin
    Result := Format('身份证号不是15位或18位(%0:s, 输入位数:%1:d)', [pAPID, L]);
    pBirthDate := '';
    Exit;
  end;
  CRCFact := '';
  if L = 18 then
  begin
    sCentury := Copy(pAPID, 7, 2);
    iCentury := StrToInt(sCentury);
    if (iCentury in [18..20]) = False then
    begin
      Result := Format('身份证号码无效:18位证号的年份前两位必须在18-20之间(输入为%0:S)', [sCentury]);
      pBirthDate := '';
      Exit;
    end;
    sYear2Bit := Copy(pAPID, 9, 2);
    sYear4Bit := sCentury + sYear2Bit;
    sMonth := Copy(pAPID, 11, 2);
    sDate := Copy(pAPID, 13, 2);
    CRCFact := Copy(pAPID, 18, 1);
  end
  else
  begin
    sCentury := '19';
    sYear2Bit := Copy(pAPID, 7, 2);
    sYear4Bit := sCentury + sYear2Bit;
    sMonth := Copy(pAPID, 9, 2);
    sDate := Copy(pAPID, 11, 2);
  end;
  iMonth := StrToInt(sMonth);
  iDate := StrToInt(sDate);
  if (iMonth in [01..12]) = False then
  begin
    Result := Format('身份证号码无效:月份必须在01-12之间(输入为%0:s)', [sMonth]);
    pBirthDate := '';
    Exit;
  end;
  if (iMonth in [1, 3, 5, 7, 8, 10, 12]) then
  begin
    if (iDate in [01..31]) = False then
    begin
      Result := Format('身份证号码无效:日期无效,不能为零或超出当月最大值(输入为%0:s)', [sDate]);
      pBirthDate := '';
      Exit;
    end;
  end;
  if (iMonth in [4, 6, 9, 11]) then
  begin
    if (iDate in [01..30]) = False then
    begin
      Result := Format('身份证号码无效:日期无效,不能为零或超出当月最大值(输入为%0:s)', [sDate]);
      pBirthDate := '';
      Exit;
    end;
  end;
  if IsLeapYear(StrToInt(sCentury + sYear2Bit)) = True then
  begin
    FebDayAmt := 29;
  end
  else
  begin
    FebDayAmt := 28;
  end;
  if (iMonth in [2]) then
  begin
    if (iDate in [01..FebDayAmt]) = False then
    begin
      Result := Format('身份证号码无效:日期无效,不能为零或超出当月最大值(输入为%0:s)', [sDate]);
      pBirthDate := '';
      Exit;
    end;
  end;
  if CRCFact <> '' then
  begin
    CRCTh := GetVerifyBit(pAPID);
    if CRCFact <> CRCTh then
    begin
      Result := Format('身份证号码无效:校验位(第18位)错:(输入为%0:s)', [pAPID]);
      pBirthDate := '';
      Exit;
    end;
  end;
  if pBirthDate <> '' then
  begin
    if pBirthDate <> (sYear4Bit + '-' + sMonth + '-' + sDate) then
    begin
      Result := Format('身份证号码无效:出生日期错误,输入的出生日期和身份证的出生日期不同(输入为%0:s)', [pBirthDate]);
      pBirthDate := sYear4Bit + '-' + sMonth + '-' + sDate;
      Exit;
    end;
  end;
  pBirthDate := sYear4Bit + '-' + sMonth + '-' + sDate;
  Result := '';
end;

function GetNextVoucher(pVoucherType: SmallInt; pMustSerail: Boolean = False): string;
begin
  try
    with FMzRegCard.spGetNextVoucher do
    begin
      if Active then Close;
      Parameters.ParamByName('@iFlag').Value := pVoucherType;
      Parameters.ParamByName('@bMustSeria').Value := pMustSerail;
      ExecProc();
      Result := Parameters.ParamByName('@cTyBh').Value;
    end;
  except

  end;
end;

procedure openRegCardForm(pType: integer; pCardNo: string; pIDNO: string);
begin
  strCardNo := pCardNo;
  strIDNO := pIDNO;
  intType := pType;
  if not Assigned(FMzRegCard) then
    FMzRegCard := TFMzRegCard.Create(nil);
  FMzRegCard.ShowModal;
  FMzRegCard.Free;
end;

procedure TFMzRegCard.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFMzRegCard.FormCreate(Sender: TObject);
var
  IniFile: TIniFile;
  DataServerName, DataBaseName, LoginDBUserID, LoginDBPassWord, strConn: string;
  showSearchText: Integer;
begin
  
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'ini\MzDoctor.ini');
  DataServerName := IniFile.ReadString('ADOConn', 'DataSource', '');
  DataBaseName := IniFile.ReadString('ADOConn', 'DataBaseName', '');
  LoginDBUserID := IniFile.ReadString('ADOConn', 'UserID', '');
  LoginDBPassWord := IniFile.ReadString('ADOConn', 'Password', '');
  
  strConn := 'Provider=SQLOLEDB.1;Data Source=' + DataServerName + ';Initial Catalog=' + DataBaseName + ';User ID=' + LoginDBUserID + ';Password=' + LoginDBPassWord + ';Persist Security Info=True';

  adoConn.Connected := False;
  adoConn.ConnectionString := strConn;
  adoConn.Connected := True;
  
  edtCardNo.Text := strCardNo;
  edtIDNO.Text := strIDNO;
  if intType = 0 then
    lblTitle.Caption := '发放诊疗卡';
  if intType = 1 then
    lblTitle.Caption := '医保卡快速注册';
  if intType = 4 then
    lblTitle.Caption := '诊疗卡信息修改';
  
end;

procedure TFMzRegCard.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FMzRegCard := nil;
end;

procedure TFMzRegCard.tmrcloseTimer(Sender: TObject);
begin
  tmrclose.Enabled := False;
  Self.Close;
end;

procedure TFMzRegCard.FormShow(Sender: TObject);
begin

  intSex := 1;
  case intType of
    0: 
      begin
        btnSave.Caption := '保存';
      end;
    1: 
      begin
        btnSave.Caption := '保存';
        edtEncryptCardNo.Text := strCardNo;
        edtCardNo.Text := '';
      end;
    4: 
      begin
        btnSave.Caption := '修改';
        strSQL := 'select * from tCardInfo where CardStatus=1 and (CardNo=''' + strCardNo + ''' or EncryptCardNo=''' + strCardNo + ''' )';
        with qryCard do
        begin
          Close;
          SQL.Clear;
          sql.Add(strSQL);
          Open;
          if Active and not IsEmpty then
          begin
            strCardID := FieldByName('cardid').AsString;
            edtCardID.Text := FieldByName('cardid').AsString;
            edtCardNo.Text := FieldByName('cardno').AsString;
            edtName.Text := FieldByName('Name').AsString;
            edtName.Hint := FieldByName('Name').AsString;
            edtEncryptCardNo.Text := FieldByName('EncryptCardNo').AsString;
            edtEncryptCardNo.Hint := FieldByName('EncryptCardNo').AsString;
            intSex := FieldByName('Sex').AsInteger;
            strSQL := 'select * from tcardDetailInfo where cardid=' + strCardID;
            qryCardDetail.Close;
            qryCardDetail.SQL.Clear;
            qryCardDetail.SQL.Add(strSQL);
            qryCardDetail.Open;
            if qryCardDetail.Active and not qryCardDetail.IsEmpty then
            begin
              edtIDNO.Text := qryCardDetail.FieldByName('PersonIDNO').AsString;
              edtIDNO.Hint := qryCardDetail.FieldByName('PersonIDNO').AsString;
              edtAddress.Text := qryCardDetail.FieldByName('HomeAddr').AsString;
              edtAddress.Hint := qryCardDetail.FieldByName('HomeAddr').AsString;
              edtTelePhone.Text := qryCardDetail.FieldByName('tele').AsString;
              edtTelePhone.Hint := qryCardDetail.FieldByName('tele').AsString;
            end;
          end;
        end;
      end;
  end;
end;

procedure TFMzRegCard.btnExitClick(Sender: TObject);
begin
  close;
end;

procedure TFMzRegCard.btnSaveClick(Sender: TObject);
var
  strName, strTele, strAddress, strIDNO: string;
  strSQLMain, strSQLDetail: string;
  strNewCardID,strNewCardNO:string;
  IDMessage,IDBirthDate:string;
  strSex:string;
  intSex:Integer;
begin
  
  IDMessage := IsValidPID(edtIDNo.Text, IDBirthDate);
  if (IDMessage <> '') then
  begin
    Application.MessageBox(PChar(IDMessage), '提示信息', MB_OK + MB_ICONINFORMATION);
    edtIDNO.SetFocus;
    edtIDNO.SelectAll;
    Exit;
  end;
  intSex := 1;
  if Trim(IDBirthDate)<>'' then
  begin
    dtpBirthday.Date := StrToDate(IDBirthDate);
    strSex := Copy(edtIDNo.Text,17,1);
    if strSex='' then strSex := '1';
    intSex := StrToInt(strSex);
    rb1.Checked := intSex mod 2=1;
    rb2.Checked := intSex mod 2=0;
    intSex := intSex mod 2;
    if intSex=0 then intSex := 2;
  end;

  if edtName.Text <> edtName.Hint then
    strName := Trim(edtName.Text)
  else
    strName := '';
  if edtTelePhone.Text <> edtTelePhone.Hint then
    strTele := Trim(edtTelePhone.Text)
  else
    strTele := '';
  if edtAddress.Text <> edtAddress.Hint then
    strAddress := Trim(edtAddress.Text)
  else
    strAddress := '';
  if edtIDNO.Text <> edtIDNO.Hint then
    strIDNO := Trim(edtIDNO.Text)
  else
    strIDNO := '';
  
  if intType = 4 then 
  begin
    if (strName <> '') then
    begin
      with qryCard do
      begin
        if Active then
          Edit;
        FieldByName('Name').AsString := strName;
        FieldByName('Sex').AsInteger := intSex;
        Post;
      end;
    end;
    if (strTele <> '') or (strAddress <> '') or (strIDNO <> '') then
    begin
      with qryCardDetail do
      begin
        if Active then
          Edit;
        if strTele <> '' then
          FieldByName('tele').AsString := strTele;
        if strAddress <> '' then
          FieldByName('HomeAddr').AsString := strAddress;
        if strIDNO <> '' then
        begin
          FieldByName('PersonIDNO').AsString := strIDNO;
          FieldByName('Csrq').AsDateTime := dtpBirthday.Date;
        end;
        Post;
      end;
    end;
  end
  else   
  begin
    strSQL := 'select * from tCardinfo where 1=2';
    with qryCard do
    begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      if edtName.Text <> edtName.Hint then strName := Trim(edtName.Text) else  strName := '';
      strNewCardID :=GetNextVoucher(10);
      if Trim(edtCardNo.Text) <> '' then strNewCardNO := Trim(edtCardNo.Text) else strNewCardNO := strNewCardID;
      Insert;
      FieldByName('cardid').AsString := strNewCardID;
      FieldByName('cardNO').AsString := strNewCardNO;
      if Trim(edtEncryptCardNo.Text)<>'' then FieldByName('EncryptCardNo').AsString := Trim(edtEncryptCardNo.Text);
      FieldByName('Name').AsString := strName;
      FieldByName('CardType').AsInteger := 1;
      FieldByName('lbh').AsInteger := 1;
      FieldByName('CardStatus').AsInteger := 1;
      FieldByName('Sex').AsInteger := intSex;
      Post;
    end;
    strSQL := 'select * from tCardDetailinfo where 1=2';
    with qryCardDetail do
    begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      Insert;
      FieldByName('cardid').AsString := strNewCardID;
      FieldByName('csrq').AsDateTime := Now;
      if strTele <> '' then
        FieldByName('tele').AsString := strTele;
      if strAddress <> '' then
        FieldByName('HomeAddr').AsString := strAddress;
      if strIDNO <> '' then
      begin
        FieldByName('PersonIDNO').AsString := strIDNO;
        FieldByName('Csrq').AsDateTime := dtpBirthday.Date;
      end;  
      Post;
    end;
  end;
  Application.MessageBox('保存成功!', '提示信息', MB_OK + MB_ICONINFORMATION);
  Close;
end;

end.


