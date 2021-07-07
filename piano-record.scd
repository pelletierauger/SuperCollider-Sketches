~keyboardRecord = [];
~keyboardRecord;
~keyboardRecord.size;

(\type: \pianoEvent, \num: 40, \dyn: 0, \amp: 2).play;
~noteOn.(0, 0, 60, 60);
~noteOff.(0, 0, 60);

(
MIDIIn.removeFuncFrom(\noteOn, ~noteOnRecord);
MIDIIn.removeFuncFrom(\noteOff, ~noteOffRecord);
~noteOnRecord = {
    arg src, chan, num, vel;
    ~keyboardRecord = ~keyboardRecord.add([SystemClock.seconds, num, vel, 1]);
};
~noteOffRecord = {
    arg src, chan, num, vel;
    ~keyboardRecord = ~keyboardRecord.add([SystemClock.seconds, num, 0, 0]);
};
MIDIIn.addFuncTo(\noteOn, ~noteOnRecord);
MIDIIn.addFuncTo(\noteOff, ~noteOffRecord);
)

(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
MIDIIn.removeFuncFrom(\noteOff, ~noteOff);
)

(
r = Routine.new({
    var k = ~keyboardRecord;
    k.size.do({ |i, item|
        var n = k[i];
        if (n[3] == 1, {
            ~noteOn.(0, 0, n[1], n[2]);
        }, {
            ~noteOff.(0, 0, n[1]);
        });
        // ~mainCaller.value(n[1], n[2], n[3]);
        if (i < (k.size - 1), {
            wait(k[i + 1][0] - k[i][0]);
        });
    });
});
)

r.reset;r.play;

// ----------------------------------------------------------------------
// Write the recorded array to a file on disk.
// ----------------------------------------------------------------------

(
~writeRecording = {
    arg fileName;
    var f, s, k, path;
    k = ~keyboardRecord;
    s = "";
    k.size.do({|i, item|
        k[i].size.do({|j|
            s = s ++ k[i][j] ++ " ";
        });
    });
    s.postln;
    path = "~/Desktop/Dropbox/Art/SuperCollider/SuperCollider-Sketches/sessions-au-piano/";
    f = File((path ++ fileName ++ ".txt").standardizePath, "w");
    f.write(s);
    f.close;
};
)

~writeRecording.("la-qui-ondule");

// ----------------------------------------------------------------------
// Read the recorded array from a file on disk.
// ----------------------------------------------------------------------

(
~readRecording = {
    arg fileName;
    var f, path;
    path = "~/Desktop/Dropbox/Art/SuperCollider/SuperCollider-Sketches/sessions-au-piano/";
    path = path ++ fileName ++ ".txt";
    f = FileReader.read(path.standardizePath).postcs;
    k = [];
    (f[0].size / 4).do({|i|
        var n = f[0];
        var j = i * 4;
        k = k.add([n[j].asFloat, n[j + 1].asFloat, n[j + 2].asFloat, n[j + 3].asFloat]);
    });
});
)

~readRecording.("c-lydien");

k;


// Read the contents of the folder where the recording sessions are stored.
(
var path;
path = PathName.new("~/Desktop/Dropbox/Art/SuperCollider/SuperCollider-Sketches/sessions-au-piano/");
path.filesDo{|aFile|aFile.fileNameWithoutExtension.postln};
nil;
)

// ----------------------------------------------------------------------
// Play back the results
// ----------------------------------------------------------------------

(
~i = 0;
r = Routine.new({
    k.size.do({ |i, item|
        var n = k[i];
        ~i = i;
        if (n[3] == 1, {
            ~noteOn.(0, 0, n[1], n[2]);
        }, {
            ~noteOff.(0, 0, n[1]);
        });
        if (i < (k.size - 1), {
            wait(k[i + 1][0] - k[i][0]);
        });
    });
});
)
r.stop;
r.reset; r.play;

~i

k[~i][0] - k[0][0];


"Total time: " ++ ~formatTime.((k[k.size - 1][0] - k[0][0]));

// Get the current time played in the recorded session.
"Current time: " ++ ~formatTime.(k[~i][0] - k[0][0]);

(
~formatTime = {
    | longVal |
    var hours, remainder, mins, secs, ints, hoursStr, minsStr, secsStr;
    hours = (longVal / 3600).floor;
    remainder = (longVal - (hours * 3600)).floor;
    mins = (remainder / 60).floor;
    remainder = remainder - (mins * 60);
    secs = (remainder).floor;
    hoursStr = hours.asString;
    if (hoursStr.size < 2, {hoursStr = "0" ++ hoursStr});
    minsStr = mins.asString;
    if (minsStr.size < 2, {minsStr = "0" ++ minsStr});
    secsStr = secs.asString;
    if (secsStr.size < 2, {secsStr = "0" ++ secsStr});
    ints = hoursStr ++ ":" ++ minsStr ++ ":" ++ secsStr;
};
)
"00".size
(
(115.asString ++ ":" ++ 12 ++ ":").postln;
)

(
r = Routine.new({
    arg inval;
    var i = 0;
    inval.postln;
    loop {
        var n = k[i];
        // i.postln;
        inval[0].postln;
        inval[1].postln;
        i = i + 1;
        1.0.yield;
    }
});
)
r.play.([12344, 22]);

r.play;
r.stop;