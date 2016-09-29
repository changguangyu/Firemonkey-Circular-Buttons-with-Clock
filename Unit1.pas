// ==============================================================================
//
// 描述： Firemonkey 环形按钮加时钟
// 作者： 牧马人
//
// Description： Firemonkey Circular Buttons with Clock
// Author： Chang
//
// ==============================================================================
unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Forms;

type
  TForm3 = class(TForm)
    StyleBook1: TStyleBook;
    Panel1: TPanel;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses AnonymousEvent, System.Rtti, System.DateUtils, System.Math;

{$R *.fmx}

procedure TForm3.FormShow(Sender: TObject);
begin
  Timer1Timer(nil);

  // 设置按钮点击事件
  // 八个按钮分别为: Green LightSeaGreen SteelBlue Purple DeepPink Yellow Orange OrangeRed
  Panel1.StylesData['SteelBlue.OnClick'] := TAnonymousEvent.CreateAsTValue(
    procedure(Sender: TObject)
    begin
      Application.Terminate;
    end);
end;

procedure TForm3.Timer1Timer(Sender: TObject);
begin
  // 时钟
  with Panel1 do
  begin
    // 时针角度
    StylesData['Hour.RotationAngle'] := IfThen(HourOf(Now) > 12,
      HourOf(Now) - 12, HourOf(Now)) * 30;
    // 分针角度
    StylesData['Minute.RotationAngle'] := MinuteOf(Now) * 6;
    // 秒针角度
    StylesData['Second.RotationAngle'] := SecondOf(Now) * 6;
  end;
end;

end.
