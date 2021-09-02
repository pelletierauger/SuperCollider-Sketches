(
// z.set(\gate, 0, \fadeTime, 0.1);
z = {
    var cutoff = SinOsc.kr(1).range(4000, 2000);
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0.5, 0], [0.5, 0.2, 4 - 0.2] * 2, [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, -2, -5, -7].rotate(2), inf));
    var in = MiBraids.ar(
        60 + -24 - 12 + note,
        timbre: env * 0.5,
        color: env * 0.25,
        model: 22,
        resamp: 2,
        decim: 22,
        bits: 6,
        ws: 1
    );
        cutoff = 100 + (2000 * env);
    in = VadimFilter.ar(
        input: in,
        type: 1,
        freq: cutoff,
        resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 2 * 0.25;
    // MiRings.ar(in, pit: 60 - 24, model: 5);
    // LPF.ar(in, cutoff)!2;
}.play;
)


(
// z.set(\gate, 0, \fadeTime, 0.1);
z = {
    var cutoff = SinOsc.kr(1).range(4000, 2000);
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0.5, 0], [0.5, 0.2, 4 - 0.2] * 2, [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, -2, -5, -7].rotate(2), inf));
    var in = MiBraids.ar(
        60 + -24 - 12 + note,
        timbre: env * 0.5,
        color: env * 0.25,
        model: 0,
        resamp: 2,
        decim: 12,
        bits: 4,
        ws: 0
    ) * 0.25;
        cutoff = 100 + (2000 * env);
    in = VadimFilter.ar(
        input: in,
        type: 1,
        freq: cutoff,
        resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 2 * 0.25 * env * 2;
    // MiRings.ar(in, pit: 60 - 24, model: 5);
    // LPF.ar(in, cutoff)!2;
}.play;
{
  var start = LFNoise0.kr(1).range(0,BufDur.ir(b));
    var t = Impulse.kr(1 * 8);
    var f = Demand.kr(t, 0, Dseq([0, -2, 2, -3].midiratio, inf));
    var fenv = Demand.kr(t, 0, Dxrand([0.5, 1, 2, 0.5, 0.5, 1, 4, 8] * 0.25, inf));
    var env = EnvGen.kr(Env([0, 1, 0.0625, 0], [0.025, 0.0625, 0.0625] * fenv, [-8, -8, -8]), t);
    var cut = Demand.kr(t, 0, Dseq([4, 2, 4, 1].stutter(8) * 1e3, inf));
    var cutoff = 100 + (cut * env);
    // var po = Demand.kr(t, 0, Dxrand((0..10)/100, inf));
    var po = Demand.kr(t, 0, Dseq([0.533, 0.42, 0.533, 0.5], inf));
  var sig = XPlayBuf.ar(2, b, trigger: t, startPos: po, loopDur: 10e-3, loop:1) * env;
    sig = VadimFilter.ar(
        input: sig,
        type: 4,
        freq: cutoff,
        resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 8 * env.lag(0.1) * 2;
    // MiVerb.ar(sig, drywet: 1, damp: 0.7) * 4;
}.play;
)