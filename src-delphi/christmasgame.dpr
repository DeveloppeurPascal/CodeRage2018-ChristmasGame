program christmasgame;

uses
  System.StartUpCopy,
  FMX.Forms,
  fMain in 'fMain.pas' {Form1},
  fMyButton in 'fMyButton.pas' {MyButton: TFrame},
  fMySprite in 'fMySprite.pas' {Sprite: TFrame},
  fMyGoodSprite in 'fMyGoodSprite.pas' {GoodSprite: TFrame},
  fMyBadSprite in 'fMyBadSprite.pas' {BadSprite: TFrame},
  fMyLife in 'fMyLife.pas' {Life: TFrame},
  dmScores in 'dmScores.pas' {PlayerScore: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TPlayerScore, PlayerScore);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
