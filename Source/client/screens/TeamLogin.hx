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


class TeamLogin extends Sprite {

    public var screenBg:Bitmap;
    public var screenTitleBg:Sprite;
    public var screenTitle:TextField;
    public var teamNameBg:Sprite;
    public var teamName:TextField;
    public var passwordBg:Sprite;
    public var password:TextField;
    public var loginButton:TextButton;
    public var onTeamLoginComplete:Void->Void;

    public function new (teamLoginCompleteCb:Void->Void) {

        super();

        onTeamLoginComplete = teamLoginCompleteCb;

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
        screenTitle.text = "Team Login";
        screenTitle.width = 600;
        screenTitle.height = 80;
        screenTitle.autoSize = TextFieldAutoSize.CENTER;
        screenTitleBg.addChild(screenTitle);

        teamName = new TextField();
        teamName.setTextFormat(TextFormats.FORM_PROPMPS);
        teamName.width = 400;
        teamName.height = 50;
        teamName.text = "Team Name...";
        teamName.multiline = false;
        teamName.type = TextFieldType.INPUT;
        teamName.borderColor = 0xFFFFFF;
        teamName.border = true;
        teamName.addEventListener(MouseEvent.CLICK, function(e:MouseEvent){ teamName.setSelection(0,teamName.text.length); });
        teamName.addEventListener(TextEvent.TEXT_INPUT, function(e:TextEvent){ });
        addChild(teamName);
        teamName.y = 75;

        password = new TextField();
        password.setTextFormat(TextFormats.FORM_PROPMPS);
        password.width = 400;
        password.height = 50;
        password.text = "Password...";
        password.multiline = false;
        password.displayAsPassword = false;
        password.type = TextFieldType.INPUT;
        password.borderColor = 0xFFFFFF;
        password.border = true;
        password.addEventListener(MouseEvent.CLICK, function(e:MouseEvent){ password.setSelection(0,password.text.length); });
        password.addEventListener(TextEvent.TEXT_INPUT, function(e:TextEvent){ password.displayAsPassword = true; });
        addChild(password);
        password.y = 180;

        loginButton = new TextButton("Login", 300, 40);
        loginButton.addEventListener(MouseEvent.CLICK, onClickLogin);
        addChild(loginButton);
        loginButton.x = Lib.current.stage.stageWidth - 320;
        loginButton.y = Lib.current.stage.stageHeight - 60;

    }

    public function onClickLogin(e:MouseEvent):Void {

        // TODO: Send login request to server
        onTeamLoginComplete();

    }

}
