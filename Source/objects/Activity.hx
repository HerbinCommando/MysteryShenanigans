package objects;

class Activity {

    public var name:String;
    public var desc:String;
    public var pointsPerCompletion:Int;
    public var timesActivityCanBeCompleted:Int;
    public var numTimesActivityCompleted:Int;

    public function new (jsonObj:Dynamic) {

        name = jsonObj.ActivityName;
        desc = jsonObj.ActivityDescription;
        pointsPerCompletion = jsonObj.PointsPerCompletion;
        timesActivityCanBeCompleted = jsonObj.TimesActivityCanBeCompleted;

        numTimesActivityCompleted = 0;

    }

    public function submitActivityForCompletion():Void {

        // TODO: Send the required data to the server, and get a valid response back.

    }

    public function activityCompleted():Void {

        if (canBeCompletedMoreThanOnce() && numTimesActivityCompleted >= timesActivityCanBeCompleted) {
            // Trying to complete an activity more times than allowed. Cheaters? Bad internets?
            return;
        }

        // Actually complete activity
        ++numTimesActivityCompleted;

    }

    public function pointsEarned():Int {

        return numTimesActivityCompleted * pointsPerCompletion;

    }

    public function canBeCompletedMoreThanOnce():Bool {

        return timesActivityCanBeCompleted != 0;
    }

}
