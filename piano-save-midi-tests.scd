

(
var file = "nite";
m = SimpleMIDIFile.read("/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Vieille musique/Midis pas de moi/compositions/" ++ file ++ ".MID");
)

m.midiEvents[206 + 6]
m.midiEvents[122]
m.midiEvents.size
m.midiEvents
m.sortMIDIEvents
m.tempo


n = m.midiEvents.sort({ |a, b| a[1].size > b[1].size });

(
// A multi-track MIDI flattened to a single track.

var file = "solodepiano";
var path = "/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Vieille musique/Midis pas de moi/compositions/";
m = SimpleMIDIFile.read(path ++ file ++ ".MID");
n = [];
m.midiEvents.do({
    | item, i |
    if ((item[2] == \noteOn) || (item[2] == \noteOff), {
        n = n.add([item[0], item[1], item[2], item[3], item[4], item[5]]);
    });
});
n = n.sort({ |a, b| a[1] < b[1] });
)

(
~playMidi = Routine.new({
    var arr = n;
    ~i = 0;
    arr.do({
        | item, i |
        ~i = i;
        if (item[2] == \noteOn, {
            ~noteOn.(0, 0, item[4] + 0, item[5]);
        });
        if ((item[2] == \noteOff) || (item[5] == 0), {
            ~noteOff.(0, 0, item[4] + 0);
            // "off!".postln;
        });
        if (i < (arr.size - 1), {
            wait((arr[i + 1][1] - arr[i][1]) / 2048 * 32);
        });
    });
});
)
~i
m.midiEvents.size
m.midiEvents[4]

~playedNotes.size
~playMidi.reset; ~playMidi.play;

(
~playMidi.stop;
~playedNotes.do({
    | item, i |
    if (item.size > 0, {
        item.do({
            | synth |
            if (synth.isNil == false, {
                // synth.postln;
               synth.set(\releaseGate, 1);
            })
        });
    });
});
)







(
var a = [10, 20, 12];
var b = [15, 19, 20];
var c = [0, 18, 32];
var arr = [a, b, c];
arr = arr.sort({ |aa, bb| aa[1] < bb[1] });
arr;
)

n;
n[150]