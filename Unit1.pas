unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Advertising,
  FMX.Controls.Presentation, FMX.StdCtrls, DateUtils;

type
  TForm1 = class(TForm)
    BannerAd1: TBannerAd;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BannerAd1ActionCanBegin(Sender: TObject;
      var WillLeaveApplication: Boolean);
    procedure BannerAd1ActionDidFinish(Sender: TObject);
    procedure BannerAd1DidFail(Sender: TObject; const Error: string);
    procedure BannerAd1DidLoad(Sender: TObject);
  private
    { Private declarations }
    ActionBeginDate: TDateTime;
    WastedSeconds: Integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.BannerAd1ActionCanBegin(Sender: TObject;
  var WillLeaveApplication: Boolean);
begin
  ActionBeginDate := Now;
end;

procedure TForm1.BannerAd1ActionDidFinish(Sender: TObject);
var
  Seconds: Integer;
begin
  Seconds := SecondsBetween(ActionBeginDate, Now);
  WastedSeconds := WastedSeconds + Seconds;
  Label1.Text := IntToStr(WastedSeconds) + ' seconds wasted watching ads so far.'
end;

procedure TForm1.BannerAd1DidFail(Sender: TObject; const Error: string);
begin
  raise Exception.Create(Error);
end;

procedure TForm1.BannerAd1DidLoad(Sender: TObject);
begin
  ShowMessage('Good');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  BannerAd1.AdUnitID := 'ca-app-pub-1481683592983392/9932978268';
  BannerAd1.LoadAd;
end;

end.
