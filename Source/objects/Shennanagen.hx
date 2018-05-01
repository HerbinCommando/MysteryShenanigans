package objects;

import haxe.Json;

class Shennanagen {

    public var name(default, null):String;
    public var desc(default, null):String;
    public var pointsPerCompletion(default, null):Int;
    public var timesToBeCompleted(default, null):Int;
    public var timesCompleted(default, null):Int;
    public var shennanagens:Array<Shennanagen>;

    public var canBeCompletedMoreThanOnce(get, never):Bool;
    public function get_canBeCompletedMoreThanOnce():Bool {
        var flag:Bool = timesToBeCompleted != 0;
        for (shennany in shennanagens) {
            flag = (flag || shennany.canBeCompletedMoreThanOnce);
        }
        return flag;
    }

    public var pointsPossible(get, never):Int;
    public function get_pointsPossible():Int {
        var sum:Int = timesCompleted == 0 ? pointsPerCompletion : timesToBeCompleted * pointsPerCompletion;
        for (shennany in shennanagens) {
            sum += shennany.pointsPossible;
        }
        return sum;
    }

    public var pointsEarned(get, never):Int;
    public function get_pointsEarned():Int {
        var sum:Int = timesCompleted * pointsPerCompletion;
        for (shennany in shennanagens) {
            sum += shennany.pointsEarned;
        }
        return sum;
    }

    public function new (jsonObj:Dynamic) {

        name = jsonObj.ShennanagenName;
        desc = jsonObj.ShennanagenDescription;
        timesToBeCompleted = jsonObj.TimesToBeCompleted;
        pointsPerCompletion = jsonObj.PointsPerCompletion;

        timesCompleted = 0;

        shennanagens = new Array<Shennanagen>();
        for (shennany in Reflect.fields(jsonObj.Shennanagens)) {
            shennanagens.push( new Shennanagen(Reflect.field(jsonObj.Shennanagens, shennany)) );
        }

    }

    public function completeShennanagen():Void {

        // TODO: Send the required data to the server, and get a valid response back.
        shennanagenCompleted();

    }

    public function shennanagenCompleted():Void {

        if (canBeCompletedMoreThanOnce && timesCompleted >= timesToBeCompleted) {
            // Trying to complete an activity more times than allowed. Cheaters? Bad internets?
            return;
        }

        // Actually complete activity
        ++timesCompleted;

    }

}
