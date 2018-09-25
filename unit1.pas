unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, contnrs;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    btnAddItems: TButton;
    btnClearListView: TButton;
    ListView1: TListView;
    procedure btnAddItemsClick(Sender: TObject);
    procedure btnClearListViewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListView1Data(Sender: TObject; Item: TListItem);
  private
    FMyObjectList: TObjectList;
  public
    { public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

type
  TMyObject = class
    Name: string;
    col1:string;
  end;

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.btnAddItemsClick(Sender: TObject);
begin
  //Poppulate the ObjectList with some TMyObjects
  while FMyObjectList.Count < 20000 do
  begin
    FMyObjectList.Add(TMyObject.Create);
    with TMyObject(FMyObjectList[FMyObjectList.Count-1]) do begin
      Name:='Item ' +IntToStr(FMyObjectList.Count);
    col1:= 'col1_' +IntToStr(FMyObjectList.Count);
    end;
  end;
  //Notify the ListView
  ListView1.Items.Count := FMyObjectList.Count
end;

procedure TfrmMain.btnClearListViewClick(Sender: TObject);
begin
  while FMyObjectList.Count > 0 do
  begin
    TMyObject(FMyObjectList[FMyObjectList.Count-1]).Free; //Delete stored object
    FMyObjectList.Delete(FMyObjectList.Count-1);          //Delete List Item
  end;
  ListView1.Items.Count := FMyObjectList.Count            //Tell ListView about it..
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FMyObjectList:= TObjectList.Create(False); //False means you have to free objects manually
end;

procedure TfrmMain.ListView1Data(Sender: TObject; Item: TListItem);
var ob: TMyObject;
begin
  ob := TMyObject(FMyObjectList.Items[Item.Index]);
  Item.Caption := ob.Name; // first column
    Item.SubItems.Add(ob.col1); // second column
//  Item.SubItems.Add(ob.Something2); // third column
//  ..Just add more columns in the ListView and more Fields in the TMyObject class.

end;

end.

