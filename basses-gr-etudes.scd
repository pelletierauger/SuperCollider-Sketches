(
y.set(\gate, 0, \fadeTime, 0.1);
y = {
    | trigGate = 1 |
    // var sig = WhiteNoise.ar();
    // sig = VA1Pole.ar(sig, freq: 12500, feedback: -0.1, type:1);
    // sig = VADiodeFilter.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 500.0), res: 0.5, overdrive: 0.9);
    var t = Impulse.kr(0.25 * 4) * trigGate;
    var bl = Demand.kr(t, 0, Dseq([1, 0, 0, 0, 1, 0, 1, 1], inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.125, 15], [2, 'lin', 'lin']), t * bl);
    var f = Demand.kr(t * bl, 0, Dseq([0, 1, -2, -7, 0, 1, 5, 3], inf)).lag(0.35);
    var sig = MiBraids.ar(31 + 12 + f, timbre: 0, color: env, model: 17) * env;
    var freq = 10 + (env.lag(3) * 150);
    // SinOsc.kr(0.1).exprange(80.0, 1000.0)
    // sig = VAKorg35.ar(sig * Line.kr(0, 1, 0.85), freq: freq, res: 0.1, overdrive: 0.05);
/*    sig = AnalogPhaser.ar(
        sig,
        SinOsc.ar(0.022 * [1, 1.1]),
        skew: SinOsc.kr(5.59 * [1, 1.1]),
        feedback: SinOsc.kr(0.005 * [1, 1.1], 1pi).range(0.8,0.85),
        modulation: SinOsc.kr(2.0192 * [1, 1.1], 2pi).unipolar,
        // modulation: 0.25,
        stages: 50
    );*/
    // sig = sig + (VadimFilter.ar(sig, 3000, resonance: 0, type: 5) * 200);
    // sig = VASEM12.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 15000.0), res:0.9, transition: LFSaw.kr(0.01).unipolar);
    // sig = VALadder.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 1000.0), res:0.5, overdrive:0.5, type:0);

    sig!2 * 0.25 * Line.kr(0, 1, 0.35);
}.play;
)

~toMidi.("G2")