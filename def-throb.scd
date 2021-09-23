

(   // shape
~defThrob.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~defThrob = {
    | trigGate = 1 |
    //     var shape = LFTri.ar(0.11).range(0,1);
    // var shape = Line.ar(1, 0.5, 4, doneAction: 0);
    // var env = Line.ar(1, 0, 3, doneAction: 0);
    var t0 = Impulse.kr(1.5 * 2) * trigGate;
    var tt = Demand.kr(t0, 0, Dseq([1, 0, 0, 1, 1, 1, 0, 1], inf));
    var t = t0 * tt;
    var d = Demand.kr(t, 0, Dseq([0.5, 0.45].stutter(2).wrapExtend(5), inf));
    var f = Demand.kr(t, 0,
        Dseq([0, 3, -2, -5, -7].stutter(1).midiratio, inf)
        * Dseq([0, 5].stutter(10).midiratio, inf)
    ).lag(0.1);
    var env = EnvGen.kr(Env([0, 1, 0], [0.01, 3], [-8, -8]), gate: t, doneAction: 2);
    var shape = EnvGen.kr(Env([1, 1, d], [0.01, 4], [-8, -4]), gate: t, doneAction: 0);
    var slope = Demand.kr(t, 0, Dseq([0.5, 0.75].stutter(2).wrapExtend(5), inf));
    var smooth = 0.5;
    var shift = 0.2;
    var sig = MiTides.ar(55 * -5.midiratio * f, shape, slope, smooth, shift, output_mode: 2) * env;
    sig = sig[0];
    sig = VAKorg35.ar(sig, freq: 200, res: 0.1, overdrive: 0.05);
    sig * 2!2;
}.play;
)





(
{
~defThrob.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~defThrob = {
    | trigGate = 1 |
    //     var shape = LFTri.ar(0.11).range(0,1);
    // var shape = Line.ar(1, 0.5, 4, doneAction: 0);
    // var env = Line.ar(1, 0, 3, doneAction: 0);
    var t0 = Impulse.kr(1.5 * 2) * trigGate;
    var tt = Demand.kr(t0, 0, Dseq([1, 0, 0, 1, 1, 1, 0, 1], inf));
    var t = t0 * tt;
    var d = Demand.kr(t, 0, Dseq([0.5, 0.45].stutter(2).wrapExtend(5), inf));
    var f = Demand.kr(t, 0,
        Dseq([0, 3, -2, -5, -7].stutter(1).midiratio, inf)
        * Dseq([0, 5].stutter(10).midiratio, inf)
    ).lag(0.1);
    var env = EnvGen.kr(Env([0, 1, 0], [0.01, 3], [-8, -8]), gate: t, doneAction: 2);
    var shape = EnvGen.kr(Env([1, 1, d], [0.01, 4], [-8, -4]), gate: t, doneAction: 0);
    var slope = Demand.kr(t, 0, Dseq([0.5, 0.75].stutter(2).wrapExtend(5), inf));
    var smooth = 0.5;
    var shift = 0.2;
    var sig = MiTides.ar(55 * -5.midiratio * f, shape, slope, smooth, shift, output_mode: 2) * env;
    sig = sig[0];
    sig = VAKorg35.ar(sig, freq: 200, res: 0.1, overdrive: 0.05);
    sig * 2!2;
}.play;
    2.wait;
    ~k.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~k = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var t = Impulse.kr(1.5 * 0.5) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10], inf));
        var sig = MiBraids.ar(
            pitch: 24 + 12 + Demand.kr(t, 0, Dseq([0, -1].stutter(4), inf)),
            timbre: 0.9,
            color: 0.3,
            model: 34,
            trig: t,
            resamp: [0, 2],
            decim: 32,
            bits: Demand.kr(t, 0, Dseq([2, 4, 6, 4], inf)),
            ws: 1
        );
        sig = (sig[0] + (sig[1] * 0.2 * sig[0]))!2;
        sig = LPF.ar(sig, 4400);
        sig * 2 * 8;
    }.play;
}.fork;
)

(
~k.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~defThrob.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
)


(
if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

~crushedNoise = {
    | trigGate = 1, relGate = 0 |
    var amp, trig, sig, env, block, decay, timbre, delrd, note, r, n;
    amp = EnvGen.ar(
        envelope: Env([1, 1, 0], [0, 5], ['lin', -8], releaseNode: 1),
        gate: Trig.kr(relGate),
        doneAction: 0
    );
    trig = Impulse.kr(2 * 1.5 * 1);
    block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
    timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
    note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
    r = 0.01;
    n = (2 * 1.5 * 0.5).reciprocal;
    env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    // timbre = timbre.lag(0.07);
    // delrd = LocalIn.ar(2);
    sig = MiBraids.ar(
        pitch: 12 + 12 + 5 + 12,
        timbre: 1,
        color: [0.8, 0.95],
        model: 4,
        resamp: 2,
        decim: 32,
        bits: 2,
        ws: 0
    ) * [env, 1 - env];
    sig = LPF.ar(sig, 1700 + SinOsc.ar(0.1).range(0, 7000)) * amp;
    // sig = ;
    sig = (sig * 0.1) + MiRings.ar((sig[0] + sig[1])!2,
        pit: 43 - 12,
        struct: 0.9,
        bright: 0.4 + (relGate.lag(4) * 0.5),
        damp: 0.7,
        pos: 0.25,
        model: 2
    );
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
    // sig = LPF.ar(sig, 2700);
    sig * 1 * 1;
}.play(fadeTime: 0.1).register;
)


(
o.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
o = {
    | trigGate = 1 |
    var envGate = EnvGate.new();
    // var cutoff = SinOsc.kr(1).range(4000, 2000);
    var t = Impulse.kr(0.25 * 0.5 * 1.5) * trigGate;
    var t2 = Impulse.kr(0.25 * 1.5) * trigGate;
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2] * 1, [2, 'lin', 'lin']), t2);
    var note = Demand.kr(t, 0, Dseq([0, -2, -5, -4], inf));
    var in = MiBraids.ar(60 + note + [0, 0.1], timbre: 1, color: 0.5, model: 26);
        var cutoff = 100 + (2000 * env);
    var sig = VadimFilter.ar(
        input: in,
        type: 5,
        freq: cutoff,
        resonance: 0.25
        // resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 0.125 * 1 * envGate * Line.ar(0, 1, 0.075);
    // LPF.ar(in, cutoff)!2;
    Out.ar(0, sig);
}.play;
)