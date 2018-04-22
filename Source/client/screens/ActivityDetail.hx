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

import client.utils.TextButton;
import client.utils.TextFormats;


class ActivityDetail extends Sprite {

    public var screenBg:Bitmap;
    public var screenTitleBg:Sprite;
    public var screenTitle:TextField;

    public function new () {

        super();

        screenBg = new Bitmap (Assets.getBitmapData ("assets/images/Buy Lame Souvenirs.png"));
        addChild(screenBg);

        screenTitleBg = new Sprite();
        screenTitleBg.graphics.beginFill(0x000000);
        screenTitleBg.graphics.drawRect(0, 0, 600, 80);
        screenTitleBg.graphics.endFill();
        addChild(screenTitleBg);
        screenTitleBg.x = (1080-600)/2;
        screenTitleBg.y = 15;

        screenTitle = new TextField();
        screenTitle.setTextFormat(TextFormats.SIZE_46);
        screenTitle.text = "Activity Details";
        screenTitle.width = 600;
        screenTitle.height = 80;
        screenTitle.autoSize = TextFieldAutoSize.CENTER;
        screenTitleBg.addChild(screenTitle);

    }

}
