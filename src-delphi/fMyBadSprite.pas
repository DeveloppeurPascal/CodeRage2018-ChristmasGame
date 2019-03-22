unit fMyBadSprite;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  fMySprite, FMX.Ani, FMX.Objects;

type
  TBadSprite = class(TSprite)
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

var
  BadSprite: TBadSprite;

implementation

{$R *.fmx}
{ TBadSprite }

constructor TBadSprite.Create(AOwner: TComponent);
begin
  inherited;
  goodorbad := bad;
end;

end.
