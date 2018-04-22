package client;


import haxe.Json;

//import lime.app.Application;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.Lib;

import client.screens.TeamLogin;
import client.screens.MysteryTourDetail;

import client.utils.TextButton;

import objects.MysteryTour;

class Main extends Sprite {

    public var stageBg:Sprite;

    public var teamLoginScreen:TeamLogin;
    public var mysteryTourDetailScreen:MysteryTourDetail;

    public var mysteryTours:Array<MysteryTour>;
    public var currentMysteryTour:MysteryTour;

	public function new () {

		super ();

		trace("running");

        mysteryTours = new Array<MysteryTour>();

        // TODO: Load available shennanagens from the server. Probably auto log in to the current shennanagen.
        loadTestShennanagens();

        stageBg = new Sprite();
        stageBg.graphics.beginFill(0x000000);
        stageBg.graphics.drawRect(0, 0, Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
        stageBg.graphics.endFill();
        addChild(stageBg);

        teamLoginScreen = new TeamLogin(onTeamLoginComplete);
        addChild(teamLoginScreen);
        teamLoginScreen.x = (Lib.current.stage.stageWidth - teamLoginScreen.width)/2;

	}

    public function loadTestShennanagens():Void {
        /*
        var data = Assets.loadText("assets/data/TheSimpleTestMysteryTour.json");
        data.onComplete(function (jsonData:String) {
            trace(jsonData);
            var tour:MysteryTour = new MysteryTour(jsonData);
            mysteryTours.push(tour);
            //var jsonObj:Dynamic = Json.parse(jsonData);
            //trace(jsonObj);
            //shennanagenActivities = jsonObj;
        });
        */
        var data = Assets.loadText("assets/data/TheJamPackedTestMysteryTour.json");
        data.onComplete(function (jsonData:String) {
            trace(jsonData);
            var tour:MysteryTour = new MysteryTour(jsonData);
            mysteryTours.push(tour);
            //var jsonObj:Dynamic = Json.parse(jsonData);
            //trace(jsonObj);
            //shennanagenActivities = jsonObj;
        });
    }

    public function onTeamLoginComplete():Void {

        removeChild(teamLoginScreen);
        teamLoginScreen = null;

        //TODO: load a MysteryTour selection screen
        currentMysteryTour = mysteryTours[0];
        mysteryTourDetailScreen = new MysteryTourDetail(currentMysteryTour);
        addChild(mysteryTourDetailScreen);
    }

}
