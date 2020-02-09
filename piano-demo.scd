(
~pianoSamples = Array.new;
~pianoFolder = PathName.new("/Users/guillaumepelletier/Downloads/21055__samulis__vsco-2-ce-keys-upright-piano/");
~pianoFolder.entries.do({
    arg path;
    ~pianoSamples = ~pianoSamples.add(Buffer.read(s, path.fullPath));
});
)

(
~pianoFunction = {|i, dy = 1, am = 1|
    if (i <= 111, {
        var note = i;
        var dynamic = dy;
        var octave = floor(note / 12) - 1;
        var degree = note - 24 % 12;
        var noteDeltas = [-1, 0,  1,  2, -1,  0,  1, -2, -1,  0,  1,  2];
        var pitch = noteDeltas[degree];
        var sampledNote = [1,  1,  1,  1,  2,  2,  2,  3,  3,  3,  3,  3];
        var sampleToGet = (octave - 1) * 3 + sampledNote[degree];
        var dynamicOffset = dynamic - 1 * 23;
        sampleToGet = sampleToGet + dynamicOffset;
        Synth.new(\pianoSynth, [
            \buf, ~pianoSamples[sampleToGet],
            \rate, pitch.midiratio,
            \pan, rrand(-0.75, 0.75),
            \amp, am,
            \out, 0
        ]);
    });
}
)

(
Event.addEventType(\pianoEvent, {
    var no, dy, am;
    if (~num.isNil, {~num = 60});
    if (~dyn.isNil, {~dyn = 1});
    if (~amp.isNil, {~amp = 1});
    no = ~num;
    dy = ~dyn;
    am = ~amp;
    topEnvironment.use({~piano.(no, dy, am);});
})
)

(
SynthDef(\pianoSynth, {
    arg buf = ~pianoSamples[0], rate = 1, spos = 0, pan = 0, amp = 1, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([1, 0], [8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: 0, doneAction: 2);
    sig = sig * amp * 18 * env;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

(
var key = ~toMidi.("A4");
var notes = key + [0, 4, 7, 11];
~pianoRiff.stop;
~pianoRiff = Pbind(
    \type, \pianoEvent,
    \dur, 0.5,
    \num, Pseq(notes, inf),
    \dyn, Pseq([2, 1, 1, 2], inf),
    \amp, Pseq([1, 2, 2, 2], inf)
).play(quant: [4]);
)

(
SynthDef(\sineTest, {
    arg freq = 440, pan = 0, amp = 1, out = 0;
    var sig, env;
    env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 1]), doneAction: 2);
    sig = SinOsc.ar(freq!2);
    sig = sig * amp * 18 * env;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)


(
var key = ~toFreq.("A3");
var notes = key * [0, 4, 7, 11].midiratio;
~sineRiff.stop;
~sineRiff = Pbind(
    \instrument, \sineTest,
    \dur, 0.5,
    \freq, Pseq(notes, inf),
    \dyn, 2,
    \amp, 0.15
).play(quant: [4]);
)