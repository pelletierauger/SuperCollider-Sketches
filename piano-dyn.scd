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
1.isRest
~toMidi.("C4")
~piano.(~toMidi.("F8") + -2);
p.(104);
~toMidi.("F8") + -2;
(
Event.addEventType(\playPiano, {
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
([0, 4, 7]!2).flatten;
(
t.sched(t.timeToNextBeat + t.beatDur, {
    var c1 = ~toMidi.("F5");
    var c2 = ~toMidi.("G5");
    var c3 = ~toMidi.("A5");
    var maj = ([4, 7, 12]!2).flatten;
    var min1 = ([0, 3, 7]!2).flatten;
    var min2 = ([0, 7, 3]!2).flatten;
    var deg = min1 ++ maj ++ min2 ++ maj;
    ~pianoA.stop;
    ~pianoA = Pbind(
        \type, \playPiano,
        \dur, Pseq([4, 2, 2], inf),
    //     \num, ~toMidi.("F3") + Pseq([0, 4, 7], inf)
        \num, Pseq([c3, c1, c2, c1].stutter(6), inf)
        + Pseq(deg, inf)
        + (Pwrand([0, 12], [0.9, 0.1], inf) * Pdefn(\pProb, 0))
        + Pdefn(\pShift, 0),
    ).play(t, quant: 4);
    ~shimmerD2.stop;
    ~shimmerD2 = Pbind(
        \instrument, \guitare,
        \dur, 0.25,
        \spos, Pseq([0.141, 0.2545, 0.141, 0.2545].stutter(64), inf)
        + Pdefn(\shimPos, 0.001) + Pwhite(0.001, 0.002, inf),
        \rel, 0.1,
        \atk, 0.7,
        \rate, Pseq([-4, -4, -6, -4].midiratio.stutter(64), inf)
        * 0.midiratio,
        \amp, 6 * Pdefn(\shimmerAmp, 1),
        \pan, Pwhite(-1.0, 1.0, inf),
        \out, ~highPassBus
    ).play(t, quant: [4, -0.5]);
    ~vagueHaute.free;
    ~vagueHaute = {
    arg gate = 1, atk = 4, rel = 16;
    var sig, env;
    env = EnvGen.ar(Env.new(
        [0, 1.0, 0.00001],
        [atk, rel],
        [\linear, \exponential], 1), gate, doneAction: 2);
    sig = Resonz.ar(
        BrownNoise.ar([0.5, 0.5]), ~toFreq.("F6"), 0.01)
        * 6 * SinOsc.kr(0.1, [0, pi], mul:0.5, add:0.5);
    sig = sig * SinOsc.kr(0.05).range(0.25, 1);
    sig = sig * env * 0.75;
    Out.ar(~limitBus, sig);
}.play;
});
)
Pdefn(\shimPos, 0.000);
Pdefn(\pProb, 1);
(
~pianoB.stop;
~pianoB = Pbind(
    \type, \playPiano,
    \dur, Pseq([Rest(1), 1, 1, 1, Rest(1), 1, Rest(1), 1], inf),
    \num, ~toMidi.("F6")
        + Prand([0, 2, 4, 5, 7, 9, 11], inf)
        + Pwrand([Rest(), 0], [0.8, 0.2], inf)
        + Pwrand([0, 12], [0.5, 0.5], inf)
        + Pdefn(\pShift, 0),
).play(t, quant: 4);
)

~mousse.setn(\amp, 8);

(
~buildVoiceA.stop;
~buildVoiceA = Pbind(
    \instrument, \vox,
    \dur, Pseq([0.5] * 2, inf),
    \spos, Pseq([0.2, 0.201, 0.3035, 0.5, 0.58, 0.24, 0.2414, 0.2415, 0.242, 0.244, 0.2445].stutter(8), inf),
    \spos, Pfunc(~calcPosA),
    \rel, Pdefn(\voxRelA, 0.3),
    \atk, Pdefn(\voxAtkA, 0.05),
    \amp, 3 * max(Pdefn(\voxFloorA, 0), Pseq(Pgeom(0.1, 1.15, 16).asStream.nextN(16).mirror2, inf)) * Pseq([1, 0.5, 0.5, 0.25], inf) * Pdefn(\voxAmpA, 3) * Pseq([1, 0.15], inf),
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, ~reverbBus
).play(t, quant: [4, 2]);
~buildVoiceB.stop;
~buildVoiceB = Pbind(
    \instrument, \vox,
    \dur, Pseq([0.5] * 2, inf),
    \spos, Pseq([0.2, 0.201, 0.3035, 0.5, 0.58, 0.24, 0.2414, 0.2415, 0.242, 0.244, 0.2445].stutter(8), inf),
    \spos, Pfunc(~calcPosB),
    \rel, Pdefn(\voxRelB, 0.3),
    \atk, Pdefn(\voxAtkB, 0.05),
    \amp, 3 * max(Pdefn(\voxFloorB, 0), Pseq(Pgeom(0.1, 1.2, 16).asStream.nextN(16).mirror2, inf)) * Pseq([1, 0.5, 0.5, 0.25], inf) * Pdefn(\voxAmpB, 3) * Pseq([0.15, 1], inf),
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, ~reverbBus
).play(t, quant: [4, 2]);
)






(
~p1.stop;
~p2.stop;
)

Pdefn(\pShift, 0);

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

