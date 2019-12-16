(
~pianoSamples = Array.new;
~pianoFolder = PathName.new("/Users/guillaumepelletier/Downloads/21055__samulis__vsco-2-ce-keys-upright-piano/");
~pianoFolder.entries.do({
    arg path;
    ~pianoSamples = ~pianoSamples.add(Buffer.read(s, path.fullPath));
});
)
~pianoSamples;
s.avgCPU;

The algorithm :
- Figure out which octave we are in.
- Figure out available note is the closest one...
- Figure out what is the pitch transposition ratio.

~pianoSamples[1];
// Octave 1 starts at sample 1.... with a "C#"
// octave 2 starts at sample 4....
// octave 3 starts at sample 7....
// so octave == ....
(
// i is the octave we are in...
i = 3;
(i - 1) * 3 + 1; // Index of the C# sample in this octave (if oct > 0), in ~pianoSamples
(i - 1) * 3 + 2; // index of the F in octave i
// (i - 1) * 3 + 3; // index of the A in octave i
)
// Inside the octave, the sampled positions are 1 (C#), 5 (F), and 9 (A);
(
// where i can be between 0 and 11
// make three substractions
//
[0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11]; // the note we are given
[1,  1,  1,  1,  5,  5,  5,  9,  9,  9,  9,  9]; // the closest sampled note
[-1, 0,  1,  2, -1,  0,  1, -2, -1,  0,  1,  2]  // the note delta for .midiratio
)

// we are given a note... we need two numbers : the octave, and the note within the octave
24 = "C1", octave 1, note 0
floor(35 / 12) - 1; // how to get the octave, where 35 is our original note and 24 = octave 1
56 - 24 % 12; // how to get the note within the octave, where 56 is our original note

(
~piano = {|i, dy = 1, am = 1|
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
        Synth.new(\piano, [
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
Event.addEventType(\playPiano, {
    if (~num.isNil, {~num = 60});
    if (~dyn.isNil, {~dyn = 1});
    if (~amp.isNil, {~amp = 1});
    // topEnvironment.use({~piano.(no, dy, am);});
    // "Being played!".postln;
    // ~num.postln;
    if (~num <= 111, {
        var note = ~num;
        var dynamic = ~dyn;
        var octave = floor(note / 12) - 1;
        var degree = note - 24 % 12;
        var noteDeltas = [-1, 0,  1,  2, -1,  0,  1, -2, -1,  0,  1,  2];
        var pitch = noteDeltas[degree];
        var sampledNote = [1,  1,  1,  1,  2,  2,  2,  3,  3,  3,  3,  3];
        var sampleToGet = (octave - 1) * 3 + sampledNote[degree];
        var dynamicOffset = dynamic - 1 * 23;
        sampleToGet = sampleToGet + dynamicOffset;
        // sampleToGet.postln;
        // ~delta.postln;
        "ceci".postln;
        // ~timingOffset.postln;
        // currentEnvironment.delta.postln;
        // currentEnvironment.lag.postln;
        // currentEnvironment.postln;
        // ~schedBundle.value(0, 0, nil, {
        // topEnvironment.use({
/*                Synth.new(\piano, [
            \buf, topEnvironment.use(~pianoSamples[sampleToGet]),
                    \rate, pitch.midiratio,
                    \pan, rrand(-0.75, 0.75),
                    \amp, 1,
                    \out, 0
                ]);*/
    // });
    // });
/*        ~schedBundle.({
            topEnvironment.use({
                Synth.new(\piano, [
                    \buf, ~pianoSamples[sampleToGet],
                    \rate, pitch.midiratio,
                    \pan, rrand(-0.75, 0.75),
                    \amp, 1,
                    \out, 0
                ]);
            });
        }, s, 0);*/
    });
})
)



(
~piaHaut2.stop;
~piaHaut2 = Pbind(
    \type, \playPiano,
    \dur, Pseq([0.01], 3),
    \num, Pseq(~toMidi.("A4") + [0, 2, 4], inf),
    \amp, Pseq([0.25], inf),
    \buf, Pfunc({Pkey(\dur).postln;})
).play(t, quant: [1]);
)


(
SynthDef(\piano, {
    arg buf = ~pianoSamples[0], rate = 1, spos = 0, pan = 0, amp = 1, out = ~limitBus;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([1, 0], [8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: 0, doneAction: 2);
    sig = sig * amp * 18 * env;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

