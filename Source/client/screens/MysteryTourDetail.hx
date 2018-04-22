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
import objects.Shennanagen;


class MysteryTourDetail extends Sprite {

    public var screenBg:Bitmap;
    public var mysteryTourNameBg:Sprite;
    public var mysteryTourName:TextField;
    public var mysteryTourDescBg:Sprite;
    public var mysteryTourDesc:TextField;
    public var shennanagenButtonContainer:Sprite;
    public var shennanagens:Array<TextButton>;
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
        mysteryTourNameBg.x = (1080-600)/2;
        mysteryTourNameBg.y = 15;

        mysteryTourName = new TextField();
        mysteryTourName.setTextFormat(TextFormats.SIZE_46);
        mysteryTourName.text = mysteryTour.name;
        mysteryTourName.width = 600;
        mysteryTourName.height = 80;
        mysteryTourName.autoSize = TextFieldAutoSize.CENTER;
        mysteryTourNameBg.addChild(mysteryTourName);

        // TODO: If the Shennanegan and the Activity list are size one, simplify the UI
        mysteryTourDescBg = new Sprite();
        mysteryTourDescBg.graphics.beginFill(0x000000);
        mysteryTourDescBg.graphics.drawRect(0, 0, 775, 200);
        mysteryTourDescBg.graphics.endFill();
        addChild(mysteryTourDescBg);
        mysteryTourDescBg.x = (1080-775)/2;
        mysteryTourDescBg.y = 150;

        mysteryTourDesc = new TextField();
        mysteryTourDesc.setTextFormat(TextFormats.SIZE_24);
        mysteryTourDesc.text = mysteryTour.desc;
        mysteryTourDesc.width = 760;
        mysteryTourDesc.height = 200;
        mysteryTourDesc.autoSize = TextFieldAutoSize.CENTER;
        mysteryTourDescBg.addChild(mysteryTourDesc);

        shennanagenButtonContainer = new Sprite();
        addChild(shennanagenButtonContainer);
        shennanagenButtonContainer.y = 385;

        shennanagens = new Array<TextButton>();
        for (shennanagen in mysteryTour.shennanagens) {

            trace(shennanagen);
            var btn:TextButton = new TextButton(shennanagen.name, 500, 40);
            btn.addEventListener(MouseEvent.CLICK, onClickShennanagen);
            btn.cargo = shennanagen;
            shennanagenButtonContainer.addChild(btn);
            btn.x = 20;
            btn.y = shennanagens.length * 55;
            shennanagens.push(btn);

        }

        this.addEventListener(MouseEvent.MOUSE_WHEEL, onScrollMouseWheel);
        
    }

    public function onClickShennanagen(e:MouseEvent):Void {

        var btn:TextButton = cast(e.currentTarget, TextButton);
        shennanagenDetailScreen = new ShennanagenDetail(cast(btn.cargo, Shennanagen));
        addChild(shennanagenDetailScreen);

    }

    public function onScrollMouseWheel(e:MouseEvent):Void {

        // If the shennanagens element is large enough to drop off the bottom of the screen, calculate the bottom extreme position
        if (maxButtonYPos + shennanagenButtonContainer.height + 20 > Lib.current.stage.stageHeight) {
            shennanagenButtonContainer.y += e.delta;

            var minButtonYPos:Int = Math.ceil(Lib.current.stage.stageHeight - (shennanagenButtonContainer.height + 20));
            if (shennanagenButtonContainer.y > maxButtonYPos) shennanagenButtonContainer.y = maxButtonYPos;
            if (shennanagenButtonContainer.y < minButtonYPos) shennanagenButtonContainer.y = minButtonYPos;
        }

    }
    
}
