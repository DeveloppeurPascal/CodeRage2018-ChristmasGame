unit dmScores;

interface

uses
  System.SysUtils, System.Classes;

type
  tPlayerScoreProc = procedure of object;

  TPlayerScore = class(TDataModule)
  private
    FonScoreChange: tPlayerScoreProc;
    Fscore: integer;
    FonLifesChange: tPlayerScoreProc;
    Flifes: integer;
    procedure Setlifes(const Value: integer);
    procedure SetonLifesChange(const Value: tPlayerScoreProc);
    procedure SetonScoreChange(const Value: tPlayerScoreProc);
    procedure Setscore(const Value: integer);
    { Private declarations }
  public
    { Public declarations }
    property score: integer read Fscore write Setscore;
    property lifes: integer read Flifes write Setlifes;
    property onLifesChange: tPlayerScoreProc read FonLifesChange
      write SetonLifesChange;
    property onScoreChange: tPlayerScoreProc read FonScoreChange
      write SetonScoreChange;
  end;

var
  PlayerScore: TPlayerScore;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TPlayerScore }

procedure TPlayerScore.Setlifes(const Value: integer);
begin
  Flifes := Value;
  if assigned(onLifesChange) then
    onLifesChange;
end;

procedure TPlayerScore.SetonLifesChange(const Value: tPlayerScoreProc);
begin
  FonLifesChange := Value;
end;

procedure TPlayerScore.SetonScoreChange(const Value: tPlayerScoreProc);
begin
  FonScoreChange := Value;
end;

procedure TPlayerScore.Setscore(const Value: integer);
begin
  Fscore := Value;
  if assigned(onScoreChange) then
    onScoreChange;
end;

end.
