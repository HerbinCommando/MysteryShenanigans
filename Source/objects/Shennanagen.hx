package objects;

import haxe.Json;
import objects.Activity;

class Shennanagen {

    public var name:String;
    public var desc:String;
    public var activities:Array<Activity>;

    public var canBeCompletedMoreThanOnce(get, never):Bool;
    public function get_canBeCompletedMoreThanOnce():Bool {
        var flag:Bool = true;
        for (activity in activities) {
            flag = (flag || activity.canBeCompletedMoreThanOnce());
        }
        return flag;
    }

    public var pointsEarned(get, never):Int;
    public function get_pointsEarned():Int {
        var sum:Int = 0;
        for (activity in activities) {
            sum += activity.pointsEarned();
        }
        return sum;
    }

    public function new (jsonObj:Dynamic) {

        trace(jsonObj);
        name = jsonObj.ShennanagenName;
        desc = jsonObj.ShennanagenDescription;

        activities = new Array<Activity>();
        for (activity in Reflect.fields(jsonObj.Activities)) {
            activities.push( new Activity(Reflect.field(jsonObj.Activities, activity)) );
        }

    }

}
