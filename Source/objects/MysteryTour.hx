package objects;

import haxe.Json;
import objects.Shennanagen;
import objects.Team;

// A mystery tour is a list of one or more Shennanagens.
// A mystery tour has the list of Team(s) and TeamMembers participating.
// A Shennanagen is something Teams or TeamMembers can do, and submit for points.
class MysteryTour {

    // static data
    //public var id:Int;
    public var name:String;
    public var desc:String;
    public var date:String;// Strict format, 24Hr  Mo/Dy/Yr/Hr:Mn
    public var shennanagens:Array<Shennanagen>;

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

        shennanagens = new Array<Shennanagen>();
        for (shennany in Reflect.fields(jsonObj.Shennanagens)) {
            trace(Reflect.field(jsonObj.Shennanagens, shennany));
            shennanagens.push(new Shennanagen(Reflect.field(jsonObj.Shennanagens, shennany)));
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
        for (shennany in shennanagens) {
            for (member in t.teamMembers) {
                score += shennany.getScore(member);
            }
        }
        return score;
    }

}
