package objects;

import haxe.Json;
import objects.Shennanagen;

// A mystery tour is a list of one or more Shennanagens.
// A Shennanagen can be one or more Activities.
// An Activity, (or a Shennanagen with one Activity), is something people do, and submit for points.
class MysteryTour {

    public var name:String;
    public var desc:String;
    public var shennanagens:Array<Shennanagen>;

    public function new (jsonStr:String) {

        trace(jsonStr);
        var jsonObj:Dynamic = Json.parse(jsonStr);
        trace(jsonObj);

        name = jsonObj.MysteryTourName;
        desc = jsonObj.MysteryTourDescription;

        shennanagens = new Array<Shennanagen>();
        for (shennanagen in Reflect.fields(jsonObj.Shennanagens)) {
            trace(Reflect.field(jsonObj.Shennanagens, shennanagen));
            shennanagens.push(new Shennanagen(Reflect.field(jsonObj.Shennanagens, shennanagen)));
        }

    }

}
