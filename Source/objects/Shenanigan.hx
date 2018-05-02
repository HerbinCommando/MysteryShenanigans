package objects;

import haxe.Json;
import objects.Team;
import objects.TeamMember;

class Shenanigan {

    // static data
    public var name(default, null):String;
    public var desc(default, null):String;
    public var pointsPerCompletion(default, null):Int;
    public var timesToBeCompleted(default, null):Int; // -1 for infinite times
    public var canBeCompletedByEachTeamMember(default, null):Bool;
    public var canBeCompletedByEachTeam(default, null):Bool; // False implies competitive, only one team can complete
    public var shenanigans:Array<Shenanigan>;

    /*
    public var canBeCompletedMoreThanOnce(get, never):Bool;
    public function get_canBeCompletedMoreThanOnce():Bool {
        var flag:Bool = timesToBeCompleted != 0;
        for (shenani in shenanigans) {
            flag = (flag || shenani.canBeCompletedMoreThanOnce);
        }
        return flag;
    }
    */

    public function canBeCompletedInfiniteTimes():Bool {
        var flag:Bool = timesToBeCompleted == -1;
        for (shenani in shenanigans) {
            flag = (flag || shenani.canBeCompletedInfiniteTimes());
        }
        return flag;
    }

    public var pointsPossible(get, never):Int;
    public function get_pointsPossible():Int {
        var sum:Int = timesToBeCompleted == -1 ? pointsPerCompletion : timesToBeCompleted * pointsPerCompletion;
        for (shenani in shenanigans) {
            sum += shenani.pointsPossible;
        }
        return sum;
    }

    public function getScore(tm:TeamMember):Int {
        var score:Int = 0;
        for (member in completedBy) {
            if (member == tm) {
                score += pointsPerCompletion;
            }
        }
        return score;
    }

    public function getTeamScore(t:Team):Int {
        var score:Int = 0;
        for (member in completedBy) {
            if (member.team == t) {
                score += pointsPerCompletion;
            }
        }
        return score;
    }

    // runtime data
    //public var timesCompleted(default, null):Int;
    public var completedBy:Array<TeamMember>; // Contains teams and team members. Contains duplicate team members if completed more than once.

    /*
    public var pointsEarned(get, never):Int;
    public function get_pointsEarned():Int {
        var sum:Int = timesCompleted * pointsPerCompletion;
        for (shenani in shenanigans) {
            sum += shenani.pointsEarned;
        }
        return sum;
    }
    */

    public function new (jsonObj:Dynamic) {

        name = jsonObj.ShenaniganName;
        desc = jsonObj.ShenaniganDescription;
        timesToBeCompleted = jsonObj.TimesToBeCompleted;
        pointsPerCompletion = jsonObj.PointsPerCompletion;

        //timesCompleted = 0;
        completedBy = new Array<TeamMember>();

        canBeCompletedByEachTeamMember = jsonObj.CanBeCompletedByEachTeamMember == "true" ? true : false;
        canBeCompletedByEachTeam = jsonObj.CanBeCompletedByEachTeam == "true" ? true : false;

        shenanigans = new Array<Shenanigan>();
        for (shenani in Reflect.fields(jsonObj.Shenanigans)) {
            shenanigans.push( new Shenanigan(Reflect.field(jsonObj.Shenanigans, shenani)) );
        }

    }

    // TODO: I may need more complicated logic here.
    public function canCompleteShennangen(tm:TeamMember):Bool {

        if (canBeCompletedByEachTeamMember) {
            var timesCompletedByMember:Int = 0;
            for (member in completedBy) {
                if (member == tm) {
                    ++timesCompletedByMember;
                }
            }

            return timesCompletedByMember < timesToBeCompleted;
        }

        if (canBeCompletedByEachTeam) {
            var timesCompletedByTeam:Int = 0;
            for (member in completedBy) {
                if (member.team == tm.team) {
                    ++timesCompletedByTeam;
                }
            }

            return timesCompletedByTeam < timesToBeCompleted;
        }

        return timesToBeCompleted == -1 || completedBy.length == 0;
    }

    public function completeShennanagen(tm:TeamMember):Void {

        canCompleteShennangen(tm);

        // TODO: Send the required data to the server, and get a valid response back.
        shennanagenCompleted(tm);

    }

    public function shennanagenCompleted(tm:TeamMember):Void {


        completedBy.push(tm);
        /*
        if (canBeCompletedMoreThanOnce && timesCompleted >= timesToBeCompleted) {
            // Trying to complete an activity more times than allowed. Cheaters? Bad internets?
            return;
        }

        // Actually complete activity
        ++timesCompleted;
        */

    }

}
