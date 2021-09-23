(
z.set(\gate, 0, \fadeTime, 0.1);
z = {
    | trigGate = 1 |
    // var sig = WhiteNoise.ar();
    // sig = VA1Pole.ar(sig, freq: 12500, feedback: -0.1, type:1);
    // sig = VADiodeFilter.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 500.0), res: 0.5, overdrive: 0.9);
    var t = Impulse.kr(0.25 * 4) * trigGate;
    var bl = Demand.kr(t, 0, Dseq([1, 0, 0, 0, 1, 0, 1, 1], inf));
    var env = EnvGen.kr(Env([0, 1, 0.125], [0.35, 3], [2, 'lin', 'lin']), t * bl);
    var env2 = EnvGen.kr(Env([0, 1, 1, 0.9], [0.125, 2, 1], [2, 'lin', 'lin']), t * bl);

    var f = Demand.kr(t * bl, 0, Dseq([0, 1, -2, -5], inf)).lag(0.25);
    var sig = MiBraids.ar(
        52 + f + env2 + SinOsc.kr(1.5).range(0, 0.5) - 12 + [0, 0.1],
        timbre: env * 0.125, color: env, model: 14);
    var freq = 80 + (500 - (env * 500));
    // SinOsc.kr(0.1).exprange(80.0, 1000.0)
    sig = sig * env;
    sig = VAKorg35.ar(sig, freq: 150 + SinOsc.kr(3).range(0, 50), res: 0, overdrive: 0.05);
    // sig = VAKorg35.ar(sig, freq: 1350 + SinOsc.kr(6).range(0, 50), res: 0, overdrive: 0.05);
/*    sig = AnalogPhaser.ar(
        sig,
        SinOsc.ar(0.022 * [1, 1.1]),
        skew: SinOsc.kr(0.59 * [1, 1.1]),
        feedback: SinOsc.kr(0.005 * [1, 1.1], 1pi).range(0.1, 0.15),
        modulation: SinOsc.kr(2.0192 * [1, 1.1], 2pi).unipolar,
        // modulation: 0.25,
        stages: 50
    );*/
    // sig = VadimFilter.ar(sig, (280 + (env * 500)).lag(1), resonance: 0, type: 1);
    // sig = VASEM12.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 15000.0), res:0.9, transition: LFSaw.kr(0.01).unipolar);
    // sig = VALadder.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 1000.0), res:0.5, overdrive:0.5, type:0);

    sig * 0.25;
}.play;
)