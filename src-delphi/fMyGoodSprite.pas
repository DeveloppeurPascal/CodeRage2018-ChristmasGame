unit fMyGoodSprite;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  fMySprite, FMX.Ani, FMX.Objects;

type
  TGoodSprite = class(TSprite)
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;
  end;

var
  GoodSprite: TGoodSprite;

implementation

{$R *.fmx}

{ TGoodSprite }

constructor TGoodSprite.Create(AOwner: TComponent);
begin
  inherited;
GoodOrBad:=good;
end;

end.
