package objects;

import haxe.Json;
import objects.Shennanagen;

// A mystery tour is a list of one or more Shennanagens.
// A Shennanagen is something people do, and submit for points.
class MysteryTour {

    public var name:String;
    public var desc:String;
    public var shennanagens:Array<Shennanagen>;

    public function new (jsonStr:String) {

        trace("Parsing MysteryTour json:\n" + jsonStr);
        var jsonObj:Dynamic = Json.parse(jsonStr);
        name = jsonObj.MysteryTourName;
        desc = jsonObj.MysteryTourDescription;

        shennanagens = new Array<Shennanagen>();
        for (shennany in Reflect.fields(jsonObj.Shennanagens)) {
            trace(Reflect.field(jsonObj.Shennanagens, shennany));
            shennanagens.push(new Shennanagen(Reflect.field(jsonObj.Shennanagens, shennany)));
        }

    }

}
