(
// G, B, D, F#
// G, A, E, F#
~shimmerC.stop;
~shimmerC = Pbind(
    \instrument, Pseq([\sampler, \samplerFlip], inf),
        \dur, Pseq([0, 0.0625], inf),
    \spos, Pseq([0.45], inf) + Pwhite(0.001, 0.01, inf),
    \rel, 0.65,
    \atk, 0.5,
    \rate, Pseq(
        [0, -5].wrapExtend(64 * 2) ++
        [0, -7].wrapExtend(64 * 2) ++
        [2, -3].wrapExtend(64 * 2)
        , inf).midiratio * 0.midiratio * [1] * 6.midiratio
    * Pwhite(0.995, 1.005, inf) * Pseq(1!63 ++ (1!2), inf),
    \amp, 1,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play();
)
(
x.free;
x = {
    var sig = MiPlaits.ar(38 + -7 + 7 + -4 + [0, 0.1], 5, harm: SinOsc.kr(0.1).range(0.1, 0.25), morph: 0, mul: 0.2);
    HPF.ar(sig, 4900) * 2 / 8;
}.play;
)
z.free;
z = Synth.new(\toGrain2, [\freq, ~toFreq.("D#3")]);
(
SynthDef.new(\toGrain2, {
    var trig = Impulse.ar([0.5, 0.5]);
    // var env = EnvGen.kr(Env.new([0, 1, 0], [1, 4]), doneAction: 2);
    var sig = MiPlaits.ar(31 + 24 + 11 + [0, 0.1],
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

(
w.free;
w = {
    var trig, env, amp, fil;
    trig = Impulse.ar(0.5!2);
    // trig = trig + Impulse.ar(1!2, 0.25);
    // trig = trig;
    fil = SinOsc.ar(0.5!2).range(1, 0);
    env = EnvGen.ar(Env.new([0, 0.5, 0], [0.1, 1]), trig);
    amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.2, 0.3]), trig);
    MiPlaits.ar(31 + 24 + 0 + -11 - 7 + [0, 0.1],
        engine: 6,
        harm: 0.5,
        timbre: env,
        morph: 0.1,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 0,
        mul: 2 * amp * 1);
}.play;
)
(
v.free;
v = {
    var trig, env, amp, fil;
    trig = Impulse.ar(0.5!2);
    // trig = trig + Impulse.ar(1!2, 0.25);
    // trig = trig;
    fil = SinOsc.ar(0.5!2).range(1, 0);
    env = EnvGen.ar(Env.new([0, 0.15, 0], [0.1, 1]), trig);
    amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.2, 0.9]), trig);
    MiPlaits.ar(31 + 24 + 0 + -11 - 12 + [0, 0.1],
        engine: 6,
        harm: 0.25,
        timbre: env,
        morph: 0.1,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 0,
        mul: 2 * amp * 1);
}.play;
)

(
u.free;
u = {
    var trig, env, amp, fil, sig;
    trig = Impulse.ar(0.5!2);
    // trig = trig + Impulse.ar(1!2, 0.25);
    // trig = trig;
    fil = SinOsc.ar(0.5!2).range(1, 0);
    env = EnvGen.ar(Env.new([0, 0.15, 0], [0.1, 1]), trig);
    amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.2, 0.9]), trig);
    sig = MiPlaits.ar(31 + 24 + 0 + -11 + 12 - 0 + [0, 0.1],
        engine: 6,
        harm: 0.25,
        timbre: 0,
        timbre: SinOsc.ar(0.05).range(0, 0.025),
        morph: 0.1,
        trigger: trig,
        usetrigger: 0,
        decay: 0.9,
        lpg_colour: 0,
        mul: 2 * 0.25);
    LPF.ar(sig, SinOsc.ar(0.05).range(400, 600));
}.play;
)