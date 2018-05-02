package objects;

import haxe.Json;
import objects.Shenanigan;
import objects.Team;

// A mystery tour is a list of one or more Shenanigans.
// A mystery tour has the list of Team(s) and TeamMembers participating.
// A Shenanigan is something Teams or TeamMembers can do, and submit for points.
class MysteryTour {

    // static data
    //public var id:Int;
    public var name:String;
    public var desc:String;
    public var date:String;// Strict format, 24Hr  Mo/Dy/Yr/Hr:Mn
    public var shenanigans:Array<Shenanigan>;

    public static function serialize(tour:MysteryTour):Void {
        // TODO: Write out to file
    }

    public static function deserialize(filename:String):Void {
        // TODO: Read in from file
    }

    //runtime
    public var teams:Array<Team>;

    public function new (jsonStr:String) {

        trace("Parsing MysteryTour json:\n" + jsonStr);
        var jsonObj:Dynamic = Json.parse(jsonStr);
        name = jsonObj.MysteryTourName;
        desc = jsonObj.MysteryTourDescription;

        teams = new Array<Team>();

        //TODO: setup date

        shenanigans = new Array<Shenanigan>();
        for (shenani in Reflect.fields(jsonObj.Shenanigans)) {
            trace(Reflect.field(jsonObj.Shenanigans, shenani));
            shenanigans.push(new Shenanigan(Reflect.field(jsonObj.Shenanigans, shenani)));
        }

    }

    public function addTeam(t:Team):Void {

        if (teams.indexOf(t) != -1) {
            // TODO warn of existing team
            return;
        }

        teams.push(t);

    }

    public function getTeamScore(t:Team):Int {
        var score:Int = 0;
        for (shenani in shenanigans) {
            for (member in t.teamMembers) {
                score += shenani.getScore(member);
            }
        }
        return score;
    }

}
