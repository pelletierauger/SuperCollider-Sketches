
(
{
    v.set(\gate, 0, \fadeTime, 0.1);
v = {
    var trig, amp, sig;
    trig = Impulse.ar(1);
    amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.0125, 2]), trig);
    sig = MiPlaits.ar(25 + 12 - 2,
        engine: 13,
        harm: 0.5,
        timbre: 0.9,
        morph: 0.4,
        trigger: trig,
        decay: 0.2,
        lpg_colour: 0,
        mul: 2) * 0.25;
    sig = sig[0];
    sig = VAKorg35.ar(sig, freq: 200, res: 0.1, overdrive: 0.05);
    sig!2;
}.play(fadeTime: 0);
    0.5.wait;
    ~chen.set(\gate, 0, \fadeTime, 0.1);
~chen = {

    var t = Impulse.kr(0.5 * 4);
    var dem = Demand.kr(t, 0, Dseq([1, 0.5], inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.01, 2.5], [-8, -8, 'lin']), t) * dem;
    var lfo = SinOsc.kr([1, 1.01]).range(-0.01, 0.01);
    var lfo2 = env * -0.04;
    var sig = Chen.ar(0.1 + lfo2, 0.69, 0.2 + (lfo2 * 4), 0.01);
    sig = sig[2]!2;
    // sig.size.poll;
    sig = sig * 1 + (VadimFilter.ar(
        input: sig,
        type: 5,
        freq: 700,
        resonance: 0.25
        // resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 24);
    sig * 2 * env;
}.play;
}.fork;
)


(
~chen2.set(\gate, 0, \fadeTime, 0.1);
~chen2 = {

    var t = Impulse.kr(1 * 1);
    var env = EnvGen.kr(Env([0, 1, 0], [0.01, 0.5], [-8, -8, 'lin']), t);
    var lfo = SinOsc.kr([1, 1.01]).range(-0.01, 0.01);
    var sig = Chen.ar(0.19, 0.55, 0.2, 0.4);
    sig = sig + (VadimFilter.ar(
        input: sig,
        type: 5,
        freq: 5000,
        resonance: 0.25
        // resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 40);
    sig * 4.8 * env * 0.5;
}.play;
)


(
if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

~crushedNoise = {
    | trigGate = 1 |
    var trig, sig, env, block, decay, timbre, delrd, note, r, n;
    trig = Impulse.kr(1 * 1);
    block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
    timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
    note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
    r = 0.01;
    n = (1 * 0.5).reciprocal;
    env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    // timbre = timbre.lag(0.07);
    // delrd = LocalIn.ar(2);
    sig = MiBraids.ar(
        pitch: 12,
        timbre: 1,
        color: [0.8, 0.95],
        model: 37,
        resamp: 2,
        decim: 32,
        bits: 2,
        ws: 0
    ) * [env, 1 - env];
    sig = VadimFilter.ar(sig, 1700 + SinOsc.ar(0.1).range(0, 7000), 0, 1);
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
    // sig = LPF.ar(sig, 2700);
    sig!2 * 0.25 * 4;
}.play(fadeTime: 0.01).register;
)
