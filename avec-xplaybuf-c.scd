(
{
  var start = LFNoise0.kr(1).range(0,BufDur.ir(b));
    var t = Impulse.kr(0.125 * 8);
    var f = Demand.kr(t, 0, Dseq([0, -2, 2, -3].midiratio, inf));
    var env = EnvGen.kr(Env([0, 1, 0.25, 0], [0.025, 0.5, 4], [-8, -8, -8]), t);
var cutoff = 100 + (4000 * env);
    var po = Demand.kr(t, 0, Dxrand((0..10)/100, inf));
  var sig = XPlayBuf.ar(2, b, trigger: 1, startPos: 0.5, loopDur: 12e-3, loop:1) * env;
    sig = VadimFilter.ar(
        input: sig,
        type: 1,
        freq: cutoff,
        resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 8 * env.lag(0.1) * 4;
    // MiVerb.ar(sig, drywet: 1, damp: 0.7) * 4;
}.play;
{
  var start = LFNoise0.kr(1).range(0,BufDur.ir(b));
    var t = Impulse.kr(0.0625 * 8);
    var f = Demand.kr(t, 0, Dseq([0, -2, 2, -3].midiratio, inf));
    var env = EnvGen.kr(Env([0, 1, 0.25, 0], [0.025, 0.5, 4], [2, 'lin', 'lin']), t);
var cutoff = 100 + (4000 * env);
    var po = Demand.kr(t, 0, Dxrand((0..10)/100, inf));
  var sig = XPlayBuf.ar(2, b, trigger: 1, startPos: 0.533, loopDur: 10e-3, loop:1) * env;
    sig = VadimFilter.ar(
        input: sig,
        type: 5,
        freq: cutoff,
        resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 8 * env.lag(0.1) * 4;
    // MiVerb.ar(sig, drywet: 1, damp: 0.7) * 4;
}.play;
)


(
{
  var start = LFNoise0.kr(1).range(0,BufDur.ir(b));
    var t = Impulse.kr(0.125 * 8);
    var f = Demand.kr(t, 0, Dseq([0, -2, 2, -3].midiratio, inf));
    var env = EnvGen.kr(Env([0, 1, 0.25, 0], [0.025, 0.5, 4], [-8, -8, -8]), t);
var cutoff = 100 + (4000 * env);
    var po = Demand.kr(t, 0, Dxrand((0..10)/100, inf));
    var bo = Demand.kr(t, 0,
        Dseq([0.5, 0.4] - 0.05, inf) + Dseq([0, -0.01].stutter(4), inf)
    );
  var sig = XPlayBuf.ar(2, b, trigger: t, startPos: bo, loopDur: 12e-3, loop:1) * env;
    sig = VadimFilter.ar(
        input: sig,
        type: 1,
        freq: cutoff,
        resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 8 * env.lag(0.1) * 4;
    // MiVerb.ar(sig, drywet: 1, damp: 0.7) * 4;
}.play;
)


(
{
  var start = LFNoise0.kr(1).range(0,BufDur.ir(b));
    var t = Impulse.kr(0.25 * 8);
    var f = Demand.kr(t, 0, Dseq([0, -2, 2, -3].midiratio, inf));
    var env = EnvGen.kr(Env([0, 1, 0.25, 0], [0.025, 0.5, 1], [-8, -8, -8]), t);
var cutoff = 100 + (4000 * env);
    var po = Demand.kr(t, 0, Dxrand((0..10)/100, inf));
    var bo = Demand.kr(t, 0,
        Dseq([0.5, 0.4] - 0.05, inf) + Dseq([-0.5, -0.05, -0.01].stutter(2), inf)
    );
  var sig = XPlayBuf.ar(2, b, trigger: t, startPos: bo, loopDur: 6e-3, loop:1) * env;
    sig = VadimFilter.ar(
        input: sig,
        type: 5,
        freq: cutoff,
        resonance: 2 - (env.lag(0.2) * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env.lag(0.2)))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 8 * env * 4;
    sig = AnalogPhaser.ar(
            sig,
            SinOsc.ar(0.022),
            skew: SinOsc.kr(5.59),
            feedback: SinOsc.kr(0.005, 1pi).range(0.8,0.85),
            modulation: SinOsc.kr(2.0192, 2pi).unipolar,
            stages: 1
        );
    // sig = AnalogVintageDistortion.ar(
        // sig, drivegain: 0.0, bias: 0, lowgain: 0.1, shelvingfreq: 200, oversample: 4);
    // MiVerb.ar(sig, drywet: 1, damp: 0.7) * 4;
    sig;
}.play;
)