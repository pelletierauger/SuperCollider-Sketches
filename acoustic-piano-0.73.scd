(
var pianoSamples, pianoFolder, makeLookUp, indices, pitches,
packLocation = "/Users/guillaumepelletier/Downloads/21055__samulis__vsco-2-ce-keys-upright-piano/";

pianoSamples = Array.new;
pianoFolder = PathName.new(packLocation);
pianoFolder.entries.do({
    |path|
    pianoSamples = pianoSamples.add(Buffer.read(s, path.fullPath));
});

makeLookUp = {
    |note, dynamic|
    var octave = floor(note / 12) - 1;
    var degree = note - 24 % 12;
    var noteDeltas = [-1, 0,  1,  2, -1,  0,  1, -2, -1,  0,  1,  2];
    var sampledNote = [1,  1,  1,  1,  2,  2,  2,  3,  3,  3,  3,  3];
    var sampleToGet = (octave - 1) * 3 + sampledNote[degree];
    var dynamicOffset = dynamic - 1 * 23;
    var pitch = noteDeltas[degree];
    sampleToGet = sampleToGet + dynamicOffset;
    [sampleToGet, pitch];
};
indices = 3.collect({|j| (20..110).collect({|i| makeLookUp.(i, j + 1)[0]})}).flat;
pitches = 3.collect({|j| (20..110).collect({|i| makeLookUp.(i, j + 1)[1]})}).flat;

Event.addEventType(\pianoEvent, {
    var index;
    if (~num.isNil, {~num = 60}, {~num = min(max(20, ~num), 110)});
    if (~dyn.isNil, {~dyn = 0}, {~dyn = floor(min(max(0, ~dyn), 2))});
    index = floor(~num) - 20 + (~dyn * 91);
    ~buf = pianoSamples[indices[index]];
    ~rate = (pitches[index] + frac(~num)).midiratio;
    ~instrument = \pianoSynth;
    ~type = \note;
    currentEnvironment.play;
});

SynthDef(\pianoSynth, {
    arg buf = pianoSamples[0], rate = 1, spos = 0, pan = 0, amp = 1, out = 0, atk = 0, sus = 0, rel = 8;
    var sig, env;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, sus, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos, doneAction: 2);
    sig = sig * amp * 18 * env;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

(
var key = 62;
var notes = key + ([0, 3, 7, 10] ++ [-5, 2, 3, 9]);
~pianoRiff.stop;
~pianoRiff = Pbind(
    \type, \pianoEvent,
    \dur, Pseq(0.5!1 ++ (0.25!3), inf),
    \num, Pseq(notes, inf),
    \dyn, Pseq([1, 0, 0, 1], inf),
    \amp, Pseq([0.5, 2, 2, 0.5], inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 4
).play(quant: [2]);
)

(
var key = 62 + 36;
var notes = key + [2, -5, 0, -2];
~pianoRiff2.stop;
~pianoRiff2 = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([0.25, 1.75], inf),
    \num, Pseq(notes, inf),
    \dyn, Pseq([1, 1, 1, 1], inf),
    \amp, Pseq([0.5, 1, 1, 0.5], inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 4
).play(quant: [2]);
)
