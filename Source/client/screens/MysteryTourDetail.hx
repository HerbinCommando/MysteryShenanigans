package client.screens;


import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.events.MouseEvent;
import openfl.events.TextEvent;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFieldType;

import client.screens.ShennanagenDetail;
import client.utils.TextButton;
import client.utils.TextFormats;

import objects.MysteryTour;
import objects.Shenanigan;


class MysteryTourDetail extends Sprite {

    public var screenBg:Bitmap;
    public var mysteryTour:MysteryTour;
    public var mysteryTourNameBg:Sprite;
    public var mysteryTourName:TextField;
    public var mysteryTourDescBg:Sprite;
    public var mysteryTourDesc:TextField;
    public var shennanagenButtonContainer:Sprite;
    public var shennanyNameBg:Sprite;
    public var shennanyName:TextField;
    public var shennanyDescBg:Sprite;
    public var shennanyDesc:TextField;
    public var shenanigans:Array<TextButton>;
    public var maxButtonYPos:Int = 185;
    public var shennanagenDetailScreen:ShennanagenDetail;
    
    public function new (mysteryTour:MysteryTour) {

        super();

        screenBg = new Bitmap (Assets.getBitmapData ("assets/images/Buy Lame Souvenirs.png"));
        addChild(screenBg);

        mysteryTourNameBg = new Sprite();
        mysteryTourNameBg.graphics.beginFill(0x000000);
        mysteryTourNameBg.graphics.drawRect(0, 0, 600, 80);
        mysteryTourNameBg.graphics.endFill();
        addChild(mysteryTourNameBg);
        mysteryTourNameBg.x = (Lib.current.stage.stageWidth-600)/2;
        mysteryTourNameBg.y = 15;

        mysteryTourName = new TextField();
        mysteryTourName.setTextFormat(TextFormats.SIZE_46);
        mysteryTourName.text = mysteryTour.name;
        mysteryTourName.width = 600;
        mysteryTourName.height = 80;
        mysteryTourName.autoSize = TextFieldAutoSize.CENTER;
        mysteryTourNameBg.addChild(mysteryTourName);

        mysteryTourDescBg = new Sprite();
        mysteryTourDescBg.graphics.beginFill(0x000000);
        mysteryTourDescBg.graphics.drawRect(0, 0, 600, 200);
        mysteryTourDescBg.graphics.endFill();
        addChild(mysteryTourDescBg);
        mysteryTourDescBg.x = (Lib.current.stage.stageWidth-600)/2;
        mysteryTourDescBg.y = 110;

        mysteryTourDesc = new TextField();
        mysteryTourDesc.setTextFormat(TextFormats.SIZE_24);
        mysteryTourDesc.text = mysteryTour.desc;
        mysteryTourDesc.width = 760;
        mysteryTourDesc.height = 200;
        mysteryTourDesc.autoSize = TextFieldAutoSize.CENTER;
        mysteryTourDescBg.addChild(mysteryTourDesc);

        this.mysteryTour = mysteryTour;
        if (mysteryTour.shenanigans == null || mysteryTour.shenanigans.length == 0) {
            //dont crash
        }
        else if (mysteryTour.shenanigans.length == 1) {
            layoutShennanagen();
        }
        else {
            layoutShennanagens();
        }
        
    }

    private function layoutShennanagen():Void {

        var shenani:Shenanigan = mysteryTour.shenanigans[0];

        shennanyNameBg = new Sprite();
        shennanyNameBg.graphics.beginFill(0x000000);
        shennanyNameBg.graphics.drawRect(0, 0, 700, 80);
        shennanyNameBg.graphics.endFill();
        addChild(shennanyNameBg);
        shennanyNameBg.x = (Lib.current.stage.stageWidth-700)/2;
        shennanyNameBg.y = 315;

        shennanyName = new TextField();
        shennanyName.setTextFormat(TextFormats.SIZE_32);
        shennanyName.text = shenani.name;
        shennanyName.width = 700;
        shennanyName.height = 80;
        shennanyName.autoSize = TextFieldAutoSize.CENTER;
        shennanyNameBg.addChild(shennanyName);

        shennanyDescBg = new Sprite();
        shennanyDescBg.graphics.beginFill(0x000000);
        shennanyDescBg.graphics.drawRect(0, 0, 700, 200);
        shennanyDescBg.graphics.endFill();
        addChild(shennanyDescBg);
        shennanyDescBg.x = (Lib.current.stage.stageWidth-700)/2;
        shennanyDescBg.y = 415;

        shennanyDesc = new TextField();
        shennanyDesc.setTextFormat(TextFormats.SIZE_24);
        shennanyDesc.text = shenani.desc;
        shennanyDesc.width = 700;
        shennanyDesc.height = 200;
        shennanyDesc.autoSize = TextFieldAutoSize.CENTER;
        shennanyDescBg.addChild(shennanyDesc);

        // TODO: Add a complete shenani button
        shennanyNameBg.addEventListener(MouseEvent.CLICK, onClickShennanagen);
        shennanyDescBg.addEventListener(MouseEvent.CLICK, onClickShennanagen);
    }

    private function layoutShennanagens():Void {

        shennanagenButtonContainer = new Sprite();
        addChild(shennanagenButtonContainer);
        shennanagenButtonContainer.y = 385;

        shenanigans = new Array<TextButton>();
        for (shenanny in mysteryTour.shenanigans) {

            var btn:TextButton = new TextButton(shenanny.name, 500, 40);
            btn.addEventListener(MouseEvent.CLICK, onClickShennanagen);
            btn.cargo = shenanny;
            shennanagenButtonContainer.addChild(btn);
            btn.x = 20;
            btn.y = shenanigans.length * 55;
            shenanigans.push(btn);

            var pointsText:String = /*shenanny.pointsEarned TODO: get points for the current team member +*/ "000 pts. / " + shenanny.pointsPossible + " pts." + (shenanny.canBeCompletedInfiniteTimes() ? " each" : "");
            var pointsBtn:TextButton = new TextButton(pointsText, 250, 40);
            pointsBtn.addEventListener(MouseEvent.CLICK, onClickShennanagen);
            pointsBtn.cargo = shenanny;
            pointsBtn.x = Lib.current.stage.stageWidth - 265;
            pointsBtn.y = btn.y;
            shennanagenButtonContainer.addChild(pointsBtn);

        }

        this.addEventListener(MouseEvent.MOUSE_WHEEL, onScrollMouseWheel);
    }

    public function onClickShennanagen(e:MouseEvent):Void {

        if (mysteryTour.shenanigans.length == 1) {
            shennanagenDetailScreen = new ShennanagenDetail(mysteryTour.shenanigans[0]);
            addChild(shennanagenDetailScreen);
        } else if (mysteryTour.shenanigans.length > 1) {
            var btn:TextButton = cast(e.currentTarget, TextButton);
            shennanagenDetailScreen = new ShennanagenDetail(cast(btn.cargo, Shenanigan));
            addChild(shennanagenDetailScreen);
        }

    }

    public function onScrollMouseWheel(e:MouseEvent):Void {

        // If the shenanigans element is large enough to drop off the bottom of the screen, calculate the bottom extreme position
        if (maxButtonYPos + shennanagenButtonContainer.height + 20 > Lib.current.stage.stageHeight) {
            shennanagenButtonContainer.y += e.delta;

            var minButtonYPos:Int = Math.ceil(Lib.current.stage.stageHeight - (shennanagenButtonContainer.height + 20));
            if (shennanagenButtonContainer.y > maxButtonYPos) shennanagenButtonContainer.y = maxButtonYPos;
            if (shennanagenButtonContainer.y < minButtonYPos) shennanagenButtonContainer.y = minButtonYPos;
        }

    }
    
}
