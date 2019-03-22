unit fMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, fMyButton, FMX.Controls.Presentation, FMX.StdCtrls, System.Rtti,
  FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, FMX.Edit, fMyLife, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.Bind.EngExt, FMX.Bind.DBEngExt, FMX.Bind.Grid,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, FireDAC.Stan.StorageJSON, FMX.Menus;

type
  TForm1 = class(TForm)
    frmHome: TLayout;
    frmGame: TLayout;
    frmGameOver: TLayout;
    frmHallOfFame: TLayout;
    frmCredits: TLayout;
    frmOptions: TLayout;
    Image1: TImage;
    VertScrollBox1: TVertScrollBox;
    btnPlay: TMyButton;
    btnQuit: TMyButton;
    btnCredits: TMyButton;
    btnOptions: TMyButton;
    btnHallOfFame: TMyButton;
    VertScrollBox2: TVertScrollBox;
    btnOptionsBack: TMyButton;
    lblOptions: TLabel;
    VertScrollBox3: TVertScrollBox;
    btnCreditsBack: TMyButton;
    lblCredits: TLabel;
    VertScrollBox4: TVertScrollBox;
    btnHallOfFameBack: TMyButton;
    StringGrid1: TStringGrid;
    VertScrollBox5: TVertScrollBox;
    btnGameOverBack: TMyButton;
    lblGameOverScore: TLabel;
    edtGameOverUserName: TEdit;
    btnGameOverSaveScore: TMyButton;
    lblGameScore: TLabel;
    Life3: TLife;
    Life1: TLife;
    Life2: TLife;
    tabScores: TFDMemTable;
    tabScoresusername: TStringField;
    tabScoresscore: TIntegerField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    GameLoop: TTimer;
    MainMenu1: TMainMenu;
    procedure btnCreditsBackClick(Sender: TObject);
    procedure btnGameOverBackClick(Sender: TObject);
    procedure btnGameOverSaveScoreClick(Sender: TObject);
    procedure btnHallOfFameBackClick(Sender: TObject);
    procedure btnOptionsBackClick(Sender: TObject);
    procedure btnCreditsClick(Sender: TObject);
    procedure btnHallOfFameClick(Sender: TObject);
    procedure btnOptionsClick(Sender: TObject);
    procedure btnPlayClick(Sender: TObject);
    procedure btnQuitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GameLoopTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InitPlay;
    procedure GameScoreChange;
    procedure GameLifesChange;
    procedure ChangeScreen(NewScreen: TLayout);
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses System.IOutils, dmScores, fMyBadSprite, fMyGoodSprite, fMySprite;
{ TForm1 }

procedure TForm1.btnCreditsBackClick(Sender: TObject);
begin
  ChangeScreen(frmHome);
end;

procedure TForm1.btnCreditsClick(Sender: TObject);
begin
  ChangeScreen(frmCredits);
end;

procedure TForm1.btnGameOverBackClick(Sender: TObject);
begin
  ChangeScreen(frmHome);
end;

procedure TForm1.btnGameOverSaveScoreClick(Sender: TObject);
begin
  if edtGameOverUserName.Text.Trim.Length > 0 then
  begin
    tabScores.Insert;
    tabScores.FieldByName('username').AsString := edtGameOverUserName.Text.Trim;
    tabScores.FieldByName('score').asinteger := playerscore.score;
    tabScores.Post;
    ChangeScreen(frmHallOfFame);
  end;
end;

procedure TForm1.btnHallOfFameBackClick(Sender: TObject);
begin
  ChangeScreen(frmHome);
end;

procedure TForm1.btnHallOfFameClick(Sender: TObject);
begin
  ChangeScreen(frmHallOfFame);
end;

procedure TForm1.btnOptionsBackClick(Sender: TObject);
begin
  ChangeScreen(frmHome);
end;

procedure TForm1.btnOptionsClick(Sender: TObject);
begin
  ChangeScreen(frmOptions);
end;

procedure TForm1.btnPlayClick(Sender: TObject);
begin
  ChangeScreen(frmGame);
end;

procedure TForm1.btnQuitClick(Sender: TObject);
begin
  close;
end;

procedure TForm1.ChangeScreen(NewScreen: TLayout);
begin
  frmHome.Visible := false;
  frmGame.Visible := false;
  GameLoop.Enabled := false;
  frmGameOver.Visible := false;
  frmHallOfFame.Visible := false;
  frmCredits.Visible := false;
  frmOptions.Visible := false;
  if NewScreen = frmGame then
    InitPlay;
  NewScreen.Visible := true;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tabScores.close;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  folder: string;
begin
  ChangeScreen(frmHome);
{$IF Defined(ANDROID) or Defined(IOS)}
  btnQuit.Visible := false;
{$ELSE}
  btnQuit.Visible := true;
{$ENDIF}
  tabScores.close;
  folder := tpath.Combine(tpath.GetDocumentsPath, 'CodeRage2018');
  if not tdirectory.Exists(folder) then
    tdirectory.CreateDirectory(folder);
  tabScores.ResourceOptions.PersistentFileName :=
    tpath.Combine(folder, 'ChristmasGame.json');
  tabScores.ResourceOptions.Persistent := true;
  tabScores.Open;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key in [vkHardwareBack, vkescape] then
  begin
    Key := 0;
    KeyChar := #0;
    ChangeScreen(frmHome);
  end;
end;

procedure TForm1.GameLifesChange;
begin
  Life1.Visible := playerscore.lifes > 0;
  Life2.Visible := playerscore.lifes > 1;
  Life3.Visible := playerscore.lifes > 3;
  if playerscore.lifes < 1 then
    ChangeScreen(frmGameOver);
end;

procedure TForm1.GameLoopTimer(Sender: TObject);
var
  i: integer;
  nbsprite: integer;
begin
  if frmGame.Visible then
  begin
    i := 0;
    nbsprite := 0;
    while (i < frmGame.ChildrenCount) do
    begin
      if (frmGame.Children[i] is tsprite) then
      begin
        if (frmGame.Children[i] as tsprite).CanBeKilled then
          frmGame.RemoveObject(i)
        else
        begin
          (frmGame.Children[i] as tsprite).MoveSprite;
          inc(i);
          inc(nbsprite);
        end;
      end
      else
        inc(i);
    end;
    if (nbsprite < 10) and (random(100) < 10) then
      if random(100) < 80 then
        TGoodSprite.Create(frmGame)
      else
        TBadSprite.Create(frmGame);
  end;
end;

procedure TForm1.GameScoreChange;
begin
  lblGameScore.Text := 'Score : ' + playerscore.score.ToString;
  lblGameOverScore.Text := 'Score : ' + playerscore.score.ToString;
end;

procedure TForm1.InitPlay;
begin
  playerscore.score := 0;
  playerscore.lifes := 3;
  playerscore.onLifesChange := GameLifesChange;
  playerscore.onScoreChange := GameScoreChange;
  GameLoop.Enabled := true;
end;

end.
