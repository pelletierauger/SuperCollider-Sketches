
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});

(
SynthDef.new(\toGrain, {
    var trig = Impulse.ar([0.5, 0.5]);
    var env = EnvGen.kr(Env.new([0, 1, 0], [1, 4]), doneAction: 2);
    var sig = MiPlaits.ar(31 + 24 + 0 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.0,
        morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 1,
        lpg_colour: 0,
        mul: 3);
    RecordBuf.ar(sig, 3);
    Out.ar(0, sig);
}).add;
)

Synth.new(\toGrain, [\freq, ~toFreq.("D#3")]);


s.record;
s.stopRecording;
b = Buffer.alloc(s, 44100 * 6.0, 2); // a four second 2 channel Buffer;
b.bufnum;
b.play;
b = Buffer.read(s, "/Users/guillaumepelletier/Music/SuperCollider Recordings/SC_200415_041724.aiff");
b.numFrames;
(
SynthDef(\sampler, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, b, rate * BufRateScale.ir(buf), startPos: spos * 300032);
    sig = sig * env;
    sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)
(
SynthDef(\samplerFlip, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, b, rate * BufRateScale.ir(buf), startPos: spos * 300032);
    sig = sig * env;
    sig = sig * amp;
    sig = Balance2.ar(sig[1], sig[0], pan, 1);
    Out.ar(out, sig);
}).add;
)
1/16
(
// G, B, D, F#
// G, A, E, F#
~shimmerC.stop;
~shimmerC = Pbind(
    \instrument, Pseq([\sampler, \samplerFlip], inf),
        \dur, Pseq([0, 0, 0, 0.0625], inf),
    \spos, Pseq([0.45], inf) + Pwhite(0.001, 0.01, inf),
    \rel, 0.1,
    \atk, 0.5,
    \rate, Pseq(
        [0, -5, 4, 14].wrapExtend(64 * 4)
        , inf).midiratio * 0.midiratio * [1] * 3.midiratio
    * Pwhite(0.995, 1.005, inf) * Pseq(1!63 ++ (1!2), inf),
    \amp, 8,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play();
)
(
x.free;
x = {
    var sig = MiPlaits.ar(38 + -7 + 7 + -7 + [0, 0.1], 5, harm: SinOsc.kr(0.1).range(0.1, 0.25), morph: 0, mul: 0.2);
    HPF.ar(sig, 4900) * 2;
}.play;
)


(
SynthDef.new(\toGrain2, {
    var trig = Impulse.ar([0.5, 0.5]);
    // var env = EnvGen.kr(Env.new([0, 1, 0], [1, 4]), doneAction: 2);
    var sig = MiPlaits.ar(31 + 24 + 12 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.0,
        morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 1,
        lpg_colour: 0,
        mul: 3);
    // RecordBuf.ar(sig, 3);
    Out.ar(0, sig);
}).add;
)


Synth.new(\toGrain2, [\freq, ~toFreq.("D#3")]);

(
y.free;
y = {
    var trig, env, amp, fil;
    trig = Impulse.ar(4!2);
    // trig = trig + Impulse.ar(1!2, 0.25);
    // trig = trig;
    fil = SinOsc.ar(0.5!2).range(1, 0);
    env = EnvGen.ar(Env.new([0, 0.5, 0], [0.1, 1]), trig);
    amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.2, 0.3]), trig);
    MiPlaits.ar(31 + 24 + 0 + 48 + [0, 0.1],
        engine: 9,
        harm: 0.5,
        timbre: env,
        morph: 0.1,
        trigger: trig,
        usetrigger: 1,
        decay: 0.4,
        lpg_colour: 0,
        mul: 2 * amp * 4);
}.play;
)