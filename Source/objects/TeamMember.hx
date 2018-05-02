package objects;

import haxe.Json;
import objects.MysteryTour;
import objects.Shenanigan;
import objects.Team;

// A TeamMember is an individual.
class TeamMember {

    public var name:String;
    public var team:Team;
    public var currentMysteryTour:MysteryTour;

    public function new (mt:MysteryTour, t:Team, n:String) {

        team = t;
        name = n;
        currentMysteryTour = mt;

    }

}
