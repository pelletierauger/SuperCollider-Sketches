
(   // phasing
w.free;
w = {
    var shape = 0.2;
    var slope = 0.0;
    var trig = Impulse.ar(220 * -5.midiratio);
    var shift = LFNoise1.ar(0.3).range(0,1);
    var env = EnvGen.kr(Env.circle([200, 8000], [0.2, 0.5] * 8));
    var env2 = EnvGen.kr(Env.circle([0.5, 0.9], [0.2, 0.5] * 16));
    var out = MiTides.ar(
        freq: 110 * -11.midiratio,
        shape: 0.4,
        slope: 0.6,
        smooth: SinOsc.ar(0.05, pi).range(0.5, 0.9),
        shift: SinOsc.ar(0.05).range(0.1, 0.2),
        trig: 0,
        output_mode: 2
        // ramp_mode: 0
    );
    out = Splay.ar(out);  // 4 channel output mixed to stereo
    out = LPF.ar(out, SinOsc.ar(0.02).range(200, 8000)) * 0.25;
    // MiVerb.ar(out, time: 0.7, amount: 0.25, diff: 0.7, damp: 0.9) * 1 * XLine.kr(0.001, 1, 3);
}.play;
)


(   // phasing
k.free;
k = {
    var shape = 0.2;
    var slope = 0.0;
    var trig = Impulse.ar(220 * -5.midiratio);
    var shift = LFNoise1.ar(0.3).range(0,1);
    var env = EnvGen.kr(Env.circle([200, 8000], [0.2, 0.5] * 8));
    var env2 = EnvGen.kr(Env.circle([0.5, 0.9], [0.2, 0.5] * 16));
    var out = MiTides.ar(
        freq: 110 * -11.midiratio + 12,
        shape: 0.4,
        slope: 0.6,
        smooth: SinOsc.ar(0.05, pi).range(0.5, 0.9),
        shift: SinOsc.ar(0.05).range(0.1, 0.2),
        trig: 0,
        output_mode: 2
        // ramp_mode: 0
    );
    out = Splay.ar(out);  // 4 channel output mixed to stereo
    out = LPF.ar(out, SinOsc.ar(0.02).range(200, 8000)) * 0.5;
    out = HPF.ar(out, 800) * 1;
}.play;
)