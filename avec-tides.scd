MiTides


(   // nice chords
{
    var shape = LFTri.ar(0.11).range(0,1);
    var slope = LFTri.ar(0.2).range(0,1);
    var chord = LFNoise1.ar(0.1).range(0.5,1);
    var out = MiTides.ar(200, shape, slope, 0.3, chord);
    Splay.ar(out);  // 4 channel output mixed to stereo
}.play
)


(   // phasing
{
    var shape = 0.2;
    var slope = 0.0;
    var trig = Impulse.ar(220 * -5.midiratio);
    var shift = LFNoise1.ar(0.3).range(0,1);
    var env = EnvGen.kr(Env.circle([200, 8000], [0.2, 0.5]));
    var env2 = EnvGen.kr(Env.circle([0.5, 0.9], [0.2, 0.5] * 2));
    var out = MiTides.ar(
        freq: 110 * -12.midiratio,
        shape: 0.1,
        slope: 0.1,
        smooth: env2,
        shift: 0,
        trig: 0,
        output_mode: 2
        // ramp_mode: 0
    );
    out = Splay.ar(out);  // 4 channel output mixed to stereo
    out = LPF.ar(out, env);
}.play;
)



(   // phasing
{
    var shape = 0.2;
    var slope = 0.0;
    var trig = Impulse.ar(220 * -5.midiratio);
    var shift = LFNoise1.ar(0.3).range(0,1);
    var env = EnvGen.kr(Env.circle([200, 8000], [0.2, 0.5]));
    var env2 = EnvGen.kr(Env.circle([0.5, 0.9], [0.2, 0.5] * 2));
    var out = MiTides.ar(
        freq: 110 * -7.midiratio,
        shape: 0.4,
        slope: 0.1,
        smooth: env2,
        shift: 0,
        trig: 0,
        output_mode: 2
        // ramp_mode: 0
    );
    out = Splay.ar(out);  // 4 channel output mixed to stereo
    out = LPF.ar(out, env);
}.play;
)

(   // phasing
{
    var shape = 0.2;
    var slope = 0.0;
    var trig = Impulse.ar(220 * -5.midiratio);
    var shift = LFNoise1.ar(0.3).range(0,1);
    var env = EnvGen.kr(Env.circle([200, 8000], [0.2, 0.5] * 2));
    var env2 = EnvGen.kr(Env.circle([0.5, 0.9], [0.2, 0.5] * 4));
    var out = MiTides.ar(
        freq: 110 * -12.midiratio,
        shape: 0.4,
        slope: 0.6,
        smooth: env2,
        shift: 0,
        trig: 0,
        output_mode: 2
        // ramp_mode: 0
    );
    out = Splay.ar(out);  // 4 channel output mixed to stereo
    out = LPF.ar(out, env) * 2;
}.play;
)

(   // phasing
{
    var shape = 0.2;
    var slope = 0.0;
    var trig = Impulse.ar(220 * -5.midiratio);
    var shift = LFNoise1.ar(0.3).range(0,1);
    var env = EnvGen.kr(Env.circle([200, 8000], [0.2, 0.5] * 0.5));
    var env2 = EnvGen.kr(Env.circle([0.8, 0.9], [0.2, 0.5] * 8));
    var out = MiTides.ar(
        freq: 110 * 2.midiratio,
        shape: 0,
        slope: 0.1,
        smooth: env2,
        shift: 0,
        trig: 0,
        output_mode: 2
        // ramp_mode: 0
    );
    out = Splay.ar(out);  // 4 channel output mixed to stereo
    out = LPF.ar(out, env);
}.play;
)




(   // phasing
{
    var shape = 0.2;
    var slope = 0.0;
    var trig = Impulse.ar(220 * -5.midiratio);
    var shift = LFNoise1.ar(0.3).range(0,1);
    var env = EnvGen.kr(Env.circle([200, 8000], [0.2, 0.5] * 0.5));
    var env2 = EnvGen.kr(Env.circle([0.8, 0.9], [0.2, 0.5] * 8));
    var dem = Demand.ar(Impulse.ar(1), 0, Dseq([0, -1].stutter(4), inf));
    var out = MiTides.ar(
        freq: 110 * dem.midiratio,
        shape: 0,
        slope: 0.1,
        smooth: env2,
        shift: 0,
        trig: 0,
        output_mode: 2
        // ramp_mode: 0
    );
    out = Splay.ar(out);  // 4 channel output mixed to stereo
    out = LPF.ar(out, env);
}.play;
TempoClock.default.sched(0.005, {
    {
    var shape = 0.2;
    var slope = 0.0;
    var trig = Impulse.ar(220 * -5.midiratio);
    var shift = LFNoise1.ar(0.3).range(0,1);
    var env = EnvGen.kr(Env.circle([200, 8000], [0.2, 0.5] * 0.5));
    var env2 = EnvGen.kr(Env.circle([0.8, 0.9], [0.2, 0.5] * 8));
    var out = MiTides.ar(
        freq: 110 * 2.midiratio,
        shape: 0,
        slope: 0.1,
        smooth: env2,
        shift: 0,
        trig: 0,
        output_mode: 2
        // ramp_mode: 0
    );
    out = Splay.ar(out);  // 4 channel output mixed to stereo
    out = LPF.ar(out, env);
}.play;
});
TempoClock.default.sched(0.01, {
{
    var shape = 0.2;
    var slope = 0.0;
    var trig = Impulse.ar(220 * -5.midiratio);
    var shift = LFNoise1.ar(0.3).range(0,1);
    var env = EnvGen.kr(Env.circle([200, 8000], [0.2, 0.5] * 0.5));
    var env2 = EnvGen.kr(Env.circle([0.8, 0.9], [0.2, 0.5] * 8));
    var out = MiTides.ar(
        freq: 110 * 4.midiratio,
        shape: 0,
        slope: 0.1,
        smooth: env2,
        shift: 0,
        trig: 0,
        output_mode: 2
        // ramp_mode: 0
    );
    out = Splay.ar(out);  // 4 channel output mixed to stereo
    out = LPF.ar(out, env);
}.play;
});
)



(   // phasing
{
    var shape = 0.2;
    var slope = 0.0;
    var trig = Impulse.ar(220 * -5.midiratio);
    var shift = LFNoise1.ar(0.3).range(0,1);
    var env = EnvGen.kr(Env.circle([200, 8000], [0.2, 0.5] * 0.5));
    var env2 = EnvGen.kr(Env.circle([0.8, 0.9], [0.2, 0.5] * 2));
    var out = MiTides.ar(
        freq: 110 * 0.midiratio,
        shape: 0.1,
        slope: 0.1,
        smooth: env2,
        shift: 0.2,
        trig: 0,
        output_mode: 2
        // ramp_mode: 0
    );
    out = Splay.ar(out);  // 4 channel output mixed to stereo
    out = LPF.ar(out, env);
}.play;
)
