(   // phasing
{
    var shape = 0.2;
    var slope = 0.0;
    var trig = Impulse.ar(220 * -5.midiratio);
    var shift = LFNoise1.ar(0.3).range(0,1);
    var env = EnvGen.kr(Env.circle([100, 8000], [0.2, 0.5].reverse * 8));
    var env2 = EnvGen.kr(Env.circle([0.5, 0.9], [0.2, 0.5] * 1));
    var env3 = EnvGen.kr(Env.circle([0.0, 0.025], [0.2, 0.5] * 16));
    var out = MiTides.ar(
        freq: 110 * -12.midiratio,
        shape: 0.1,
        slope: 0.1,
        smooth: env2,
        shift: env3,
        trig: 0,
        output_mode: 2
        // ramp_mode: 0
    );
    out = Splay.ar(out);  // 4 channel output mixed to stereo
    out = LPF.ar(out, env) * 2;
    // out = MiRings.ar(out);
    out = GVerb.ar(out, taillevel: 0.25);
    out;
}.play;
)

{ MiVerb.ar(Impulse.ar(1)) }.play