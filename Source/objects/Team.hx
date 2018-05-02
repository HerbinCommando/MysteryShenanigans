package objects;

import haxe.Json;
import objects.MysteryTour;
import objects.Shennanagen;
import objects.TeamMember;

// A Team is a list of people who are doing, or have done a MysteryTour.
class Team {

    //public var id:Int;
    public var name:String;
    public var currentMysteryTour:MysteryTour;
    public var teamMembers:Array<TeamMember>;

    public function new (n:String) {

        name = n;
        teamMembers = new Array<TeamMember>();
    }

    public function addMember(tm:TeamMember):Void {

        if (teamMembers.indexOf(tm) != -1) {
            //TODO: warn of duplicate team member
            return;
        }

        teamMembers.push(tm);

    }

    public function removeMember(tm:TeamMember):Void {

        if (teamMembers.indexOf(tm) != -1) {
            teamMembers.remove(tm);
        }

    }

    /*
    public function getScore():Int {

        var score:Int = 0;
        for (tm in TeamMember) {
            score += tm.getScore();
        }

        return score;

    }
    */

}
