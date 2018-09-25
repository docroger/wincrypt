unit cryptoapi_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, wincrypt, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
(*
  function DecryptStringW(instr, pwd: WideString): WideString;
  // password based decryption of a string using WinCrypt API, WideString version
    var
      Key: tCryptKey;
      Hash: tCryptHash;
      Prov: tCryptProv;
      DataLen, skip, Flags: DWord;
      DataBuf: Pointer;
      outstr: WideString;
    begin
      CryptAcquireContext(Prov, nil, nil, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT);
      CryptCreateHash(Prov, CALG_SHA, nil, 0, hash);
      CryptHashData(hash, @pwd[1], Length(Pwd), 0);
      CryptDeriveKey(Prov, CALG_3DES, hash, 0, key);
      CryptDestroyHash(hash);

      CryptStringToBinaryW(pointer(instr), Length(instr), CRYPT_STRING_BASE64, nil, DataLen, skip, Flags);
      GetMem(databuf, DataLen);
      try
        CryptStringToBinaryW(pointer(instr), Length(instr), CRYPT_STRING_BASE64, DataBuf,
             DataLen, skip, Flags);
        CryptDecrypt(Key, nil, True, 0, DataBuf, Datalen);
        SetLength(outstr, datalen);
        Move(DataBuf^, outstr[1], DataLen);
        CryptReleaseContext(Prov, 0);
        Result := outstr;
      finally
        FreeMem(databuf);
      end;
   end;

   function EncryptStringW(instr, pwd: WideString): WideString;
   // password based encryption of a string, WideString version
     var
      Key: TCryptKey;
      Hash: TCryptHash;
      Prov: TCryptProv;
      DataLen, bufsize: DWord;
      databuf: PByte;
      outstr: WideString;
    begin
      CryptAcquireContext(Prov, nil, nil, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT);
      CryptCreateHash(Prov, CALG_SHA, nil, 0, hash);
      CryptHashData(hash, @pwd[1], Length(Pwd), 0);
      CryptDeriveKey(Prov, CALG_3DES, hash, 0, key);
      CryptDestroyHash(hash);
      bufsize := 0;
      DataLen := 0;
      CryptEncrypt(Key, nil, True, 0, nil, bufsize, Length(instr));
      GetMem(databuf, bufsize*8);
      try
        Move(instr[1], databuf^, Length(instr));
        DataLen := Length(instr);
        CryptEncrypt(Key, nil, True, 0, databuf, DataLen, bufsize*8);
        CryptReleaseContext(Prov, 0);
        CryptBinaryToStringW(databuf, DataLen, CRYPT_STRING_BASE64 or
                CRYPT_STRING_NOCRLF, nil, bufsize);
        SetLength(outstr, bufsize);
        CryptBinaryToStringW(databuf, DataLen, CRYPT_STRING_BASE64 or
                CRYPT_STRING_NOCRLF, @outstr[1], bufsize);

       // result, kill the three characters after the final one the base64 returns    ($D$A$0)
       // CRYPT_STRING_NOCRLF seems to mean nothing on XP, it might on other systems
       // you will need to change to the commented line if you are on Vista, 7, or 8
       // Result := Copy(outstr, 1, Length(outstr) - 3);
        Result := Outstr;
      finally
        FreeMem(databuf);
      end;
    end;

*)
//
function DecryptStringA(instr, pwd: ansiString): ansiString;
  // password based decryption of a string using WinCrypt API, ANSI VERSION.
    var
      Key: TCryptKey;
      Hash: TCryptHash;
      Prov: TCryptProv;
      DataLen, skip, Flags, bufsize: DWord;
      DataBuf: Pointer;
      outstr: ansiString;
      param:longint;
    begin
     param:=CRYPT_MODE_CBC;
     CryptAcquireContext(Prov, nil, nil, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT);
      CryptCreateHash(Prov, CALG_sha1, nil, 0, hash);
      CryptHashData(hash, @pwd[1], Length(Pwd)*sizeof(ansichar), 0);
      CryptDeriveKey(Prov, CALG_rc4, hash, 0, key);
      Cryptsetkeyparam(key,KP_MODE,@param,0);
      CryptDestroyHash(hash);
      datalen:=length(instr)+1;
      bufsize:=0;
      CryptStringToBinaryA(@instr[1], datalen, CRYPT_STRING_base64, nil, bufsize, skip, Flags);
      GetMem(databuf, bufsize);
      zeromemory(databuf,bufsize);
      try
        CryptStringToBinaryA(@instr[1], datalen, CRYPT_STRING_base64, DataBuf, bufsize, skip, Flags);
        CryptDecrypt(Key, nil, True, 0, DataBuf, bufsize);
        cryptdestroykey(key);
        SetLength(outstr, bufsize);
        Move(DataBuf^, outstr[1], bufsize);
        CryptReleaseContext(Prov, 0);
        param:=0;
        Result := outstr;
      finally
        FreeMem(databuf);
      end;
end;

function EncryptStringA(instr, pwd: ansiString): ansiString;
   // password based encryption of a string, ANSI version
    var
      Key: TCryptKey;
      Hash: TCryptHash;
      Prov: TCryptProv;
      DataLen, bufsize: DWord;
      databuf: PByte;
      outstr: ansiString;
      param:longint;
   begin
    param:=CRYPT_MODE_CBC;
    CryptAcquireContext(Prov, nil, nil, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT );
     CryptCreateHash(Prov, CALG_sha1, nil, 0, hash);
     CryptHashData(hash, @pwd[1], Length(Pwd)*sizeof(ansichar), 0);
     CryptDeriveKey(Prov, CALG_rc4, hash, CRYPT_EXPORTABLE, key);
     Cryptsetkeyparam(key,KP_MODE,@param,0);
     //
     CryptDestroyHash(hash);
     //
     DataLen := length(instr);
     //CryptEncrypt(Key, hash, True, 0, nil, @bufsize, pointer(bufsize));
     bufsize:=datalen+1;
     GetMem(databuf, bufsize);
     zeromemory(databuf,bufsize);
     try
       Move(instr[1], databuf^, datalen);
       CryptEncrypt(key, nil, true, 0, databuf, datalen, bufsize);
       cryptdestroykey(key);
       //
       CryptReleaseContext(Prov, 0);
       bufsize:=0;
       CryptBinaryToStringA(databuf, datalen, CRYPT_STRING_BASE64 or
              CRYPT_STRING_NOCRLF, nil, bufsize);
       SetLength(outstr, bufsize);
       CryptBinaryToStringA(databuf, DataLen, CRYPT_STRING_BASE64 or
              CRYPT_STRING_NOCRLF, @outstr[1], bufsize);
     // result, kill the three characters after the final one the base64 returns    ($D$A$0)
     // CRYPT_STRING_NOCRLF seems to mean nothing on XP, it might on other systems
     // you will need to change to the commented line if you are on Vista, 7, or 8
     // Result := Copy(outstr, 1, Length(outstr)*sizeof(ansichar) - 3);
     Result := Outstr;
    finally
       FreeMem(databuf);
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
     password1: String;

   begin
     password1 := 'Test123456789';
     memo2.Text := EncryptStringa(memo1.Text, password1);
     memo1.clear;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
     password1: ansiString;
   begin
     password1 := 'Test123456789';
     memo1.text := DecryptStringa(memo2.Text, password1);
     memo2.clear;

end;

end.
