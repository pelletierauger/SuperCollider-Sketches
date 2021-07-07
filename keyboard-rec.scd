~keyboardRecord = [];
~keyboardRecord;
~keyboardRecord.size;

(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
MIDIIn.removeFuncFrom(\noteOff, ~noteOff);
~noteOn = {
    arg src, chan, num, vel;
    ~mainCaller.value(num, vel, ~curAlg);
    ~keyboardRecord = ~keyboardRecord.add([SystemClock.seconds, num, vel, ~curAlg]);
};
~noteOff = {
    arg src, chan, num, vel;
    ~mainCaller.value(num, 0);
    ~keyboardRecord = ~keyboardRecord.add([SystemClock.seconds, num, 0, ~curAlg]);
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
MIDIIn.addFuncTo(\noteOff, ~noteOff);
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
        ~mainCaller.value(n[1], n[2], n[3]);
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
var f, s, k;
k = ~keyboardRecord;
s = "";
k.size.do({|i, item|
    k[i].size.do({|j|
        s = s ++ k[i][j] ++ " ";
    });
});
s.postln;
f = File("~/Desktop/Dropbox/Art/SuperCollider/SuperCollider-Sketches/clavier/craquelle.txt".standardizePath, "w");
f.write(s);
f.close;
)

// ----------------------------------------------------------------------
// Read the recorded array from a file on disk.
// ----------------------------------------------------------------------

(
var f;
f = FileReader.read("~/Desktop/Dropbox/Art/SuperCollider/SuperCollider-Sketches/clavier/craquelle.txt".standardizePath).postcs;
k = [];
(f[0].size / 4).do({|i|
    var n = f[0];
    var j = i * 4;
    k = k.add([n[j].asFloat, n[j + 1].asFloat, n[j + 2].asFloat, n[j + 3].asFloat]);
});
)

k;

// ----------------------------------------------------------------------
// Play back the results
// ----------------------------------------------------------------------

(
r = Routine.new({
    k.size.do({ |i, item|
        var n = k[i];
        var num = n[1];
        var vel = n[2];
        var alg = n[3];
        ~mainCaller.value(num, vel, alg);
        if (i < (k.size - 1), {
            var delta = k[i + 1][0] - k[i][0];
            wait(delta);
        });
    });
});
)
r.stop;
r.reset; r.play;