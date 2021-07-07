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
var f, s, k;
k = ~keyboardRecord;
s = "";
k.size.do({|i, item|
    k[i].size.do({|j|
        s = s ++ k[i][j] ++ " ";
    });
});
s.postln;
f = File("~/Desktop/Dropbox/Art/SuperCollider/SuperCollider-Sketches/sessions-au-piano/c-lydien.txt".standardizePath, "w");
f.write(s);
f.close;
)

// ----------------------------------------------------------------------
// Read the recorded array from a file on disk.
// ----------------------------------------------------------------------

(
var f;
f = FileReader.read("~/Desktop/Dropbox/Art/SuperCollider/SuperCollider-Sketches/sessions-au-piano/c-lydien.txt".standardizePath).postcs;
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
r.stop;
r.reset; r.play;