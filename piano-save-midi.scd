(
m = SimpleMIDIFile( "/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/SuperCollider-Sketches/midifiletest.mid"); // create empty file
)
m.write
m.midiEvents


(
m = SimpleMIDIFile("/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/SuperCollider-Sketches/midifiletest.mid"); // create empty file
m.init1( 3, 120, "4/4" );    // init for type 1 (multitrack); 3 tracks, 120bpm, 4/4 measures
m.timeMode = \seconds;  // change from default to something useful

((0,(1/8)..95)).do({ |starttime| // add random notes
        m.addNote( 36 + 50.rand, 32 + 96.rand, starttime, [0.1,0.05].choose, 127, track: 1 )
});

((0,(1/4)..95)).do({ |starttime| // add random notes to next track
        m.addNote( 36 + 50.rand, 64 + 64.rand, starttime, [0.1,0.025].choose, 127,
                channel: 1,  // note: = midi channel 2
                track: 2 )
    });
)



(
m = SimpleMIDIFile("/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/SuperCollider-Sketches/midifiletest.mid"); // create empty file
m.init1( 2, 120, "4/4" );    // init for type 1 (multitrack); 3 tracks, 120bpm, 4/4 measures
m.timeMode = \seconds;  // change from default to something useful

((0,(1/8)..95)).do({ |starttime| // add random notes
    m.addNote( 36 + 50.rand, 32 + 96.rand, starttime, [0.1,0.05].choose, 127, track: 1 )
});
)
m.midiEvents
m.midiEvents.size
m.timeMode
m.write


(
m = SimpleMIDIFile("/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/SuperCollider-Sketches/montagnes-bleues-3.mid");
m.init1(2, 120, "4/4");    // init for type 1 (multitrack); 3 tracks, 120bpm, 4/4 measures
m.timeMode = \seconds;
)
k[3]
k.size



(
var baseTime = k[0][0];
k.do({
    |item, index|
    var type = if (item[3] == 1, {\noteOn}, {\noteOff});
    var tracknumber = 1;
    var channel = 1;
    var event = [tracknumber, item[0] - baseTime, type, channel, item[1], item[2]];
    m.addMIDIEvent(event);
});
)


(
~writeMIDI = {
    arg fileName;
    var m, k, path, baseTime;
    path = "~/Desktop/Dropbox/Art/SuperCollider/SuperCollider-Sketches/sessions-au-piano/";
    m = SimpleMIDIFile(path ++ fileName ++ ".mid");
    m.init1(2, 120, "4/4");    // init for type 1 (multitrack); 3 tracks, 120bpm, 4/4 measures
    m.timeMode = \seconds;
    k = ~keyboardRecord;
    baseTime = k[0][0];
    k.do({
        |item, index|
        var absTime = (item[0] - baseTime);
        var type = if (item[3] == 1, {\noteOn}, {\noteOff});
        var tracknumber = 1;
        var channel = 1;
        var event = [tracknumber, absTime, type, channel, item[1], item[2]];
        m.addMIDIEvent(event, false);
    });
    m.write;
}
)

~writeMIDI.("pluie-maternelle")
~keyboardRecord = k;

(
~readMIDI = {
    arg fileName;
    var path;
    path = "~/Desktop/Dropbox/Art/SuperCollider/SuperCollider-Sketches/sessions-au-piano/";
    path = path ++ fileName ++ ".mid";
    m = SimpleMIDIFile.read(path);
}
)

~readMIDI.("pluie-maternelle")


m.write
m.sortMIDIEvents
m.correctTempoEvents
m.write("/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/SuperCollider-Sketches/montagnes-bleues-3.mid");
)
1 tick = 1024 of a beat, and we are at 120 BPM
120 * 1024 / 60 //ticks per second
2048 ticks per second
1167877 / 2048

m = SimpleMIDIFile.read("Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/SuperCollider-Sketches/montagnes-bleues-3.mid");
k[2501][0] - k[0][0]
m
m.midiEvents
m.midiEvents[2501]
m.midiEvents = []
m.midiEvents.size
m.shiftTime
m.addMIDIEvent([0, 600.251231231231, "noteOn", 0, 62, 128]);
(
100.do({
    m.addMIDIEvent([0, (0,(1/8)..95).choose, "noteOn", 0, 62, 128]);
})
)
m.division
m.format
m.tracks
k[0]

m.midiEvents[200][2] == \noteOn

(
~playMidi = Routine.new({
    ~i = 0;
    m.midiEvents.do({
        | item, i |
        ~i = i;
        if (item[2] == \noteOn, {
            ~noteOn.(0, 0, item[4], item[5]);
        });
        if (item[2] == \noteOff, {
            ~noteOff.(0, 0, item[4]);
        });
        if (i < (m.midiEvents.size - 1), {
            wait((m.midiEvents[i + 1][1] - m.midiEvents[i][1]) / 2048);
        });
    });
});
)


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