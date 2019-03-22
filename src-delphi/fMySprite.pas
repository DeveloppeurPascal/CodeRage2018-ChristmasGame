unit fMySprite;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Ani, FMX.Objects;

type
  TGoodOrBad = (Good, Bad);

  TSprite = class(TFrame)
    Rectangle1: TRectangle;
    aniClicked: TBitmapListAnimation;
    procedure FrameClick(Sender: TObject);
    procedure aniClickedFinish(Sender: TObject);
  private
    Fvx: single;
    Fvy: single;
    FCanBeKilled: boolean;
    FGoodOrBad: TGoodOrBad;
    procedure SetCanBeKilled(const Value: boolean);
    procedure SetGoodOrBad(const Value: TGoodOrBad);
    procedure Setvx(const Value: single);
    procedure Setvy(const Value: single);
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property vx: single read Fvx write Setvx;
    property vy: single read Fvy write Setvy;
    property GoodOrBad: TGoodOrBad read FGoodOrBad write SetGoodOrBad;
    property CanBeKilled: boolean read FCanBeKilled write SetCanBeKilled;
    procedure MoveSprite;
  end;

implementation

{$R *.fmx}

uses dmScores;
{ TSprite }

procedure TSprite.aniClickedFinish(Sender: TObject);
begin
  CanBeKilled := true;
end;

constructor TSprite.Create(AOwner: TComponent);
begin
  inherited;
  if (AOwner is tcontrol) then
  begin
    name := '';
    parent := AOwner as tcontrol;
    position.X := random(trunc((parent as tcontrol).Width)) - Width;
    position.Y := -height;
  end;
  vx := (random(40) - 20) / 10;
  vy := random(40) / 5;
  CanBeKilled := false;
  GoodOrBad := Good;
end;

procedure TSprite.FrameClick(Sender: TObject);
begin
  hittest := false;
  if GoodOrBad = Good then
    PlayerScore.score := PlayerScore.score + 1
  else
    PlayerScore.lifes := PlayerScore.lifes - 1;
  aniClicked.Enabled := true;
end;

procedure TSprite.MoveSprite;
var
  layout: tcontrol;
begin
  position.X := position.X + vx;
  position.Y := position.Y + vy;
  layout := parent as tcontrol;
  if (position.X < -Width) or (position.X > layout.Width) or
    (position.Y > layout.height) then
    CanBeKilled := true;
end;

procedure TSprite.SetCanBeKilled(const Value: boolean);
begin
  FCanBeKilled := Value;
end;

procedure TSprite.SetGoodOrBad(const Value: TGoodOrBad);
begin
  FGoodOrBad := Value;
end;

procedure TSprite.Setvx(const Value: single);
begin
  Fvx := Value;
end;

procedure TSprite.Setvy(const Value: single);
begin
  Fvy := Value;
end;

initialization

randomize;

end.
