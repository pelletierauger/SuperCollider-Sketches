s.options.memSize_(65536 * 4);
s.reboot;

(
y.set(\gate, 0, \fadeTime, 10);
y = {
    var t = Impulse.kr(0.5);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t).lag(0.1);
    var note = Demand.kr(t, 0, Dseq([-5, -7], inf));
    var nota = Demand.kr(t, 0, Dseq([0, 2, 3, 2], inf));
    var timb = Demand.kr(t, 0, Dseq([0.5, 0.25], inf));
    var sig = MiPlaits.ar(
        pitch: 50 + [note + 0, note + 0.01, nota + 0, nota + 0.01],
        engine: 4,
        harm: 1 - (env.pow(11) * 0.5),
        timbre: timb.lag(0.05),
        morph: 1
    ) * 0.5 * env;
    var i = 1;
    var sigT = [sig[0][i] + sig[2][i], sig[1][i] + sig[3][i]];
    var sigL = LPF.ar(sigT, 500 + (env.pow(5) * 4000)) * 2;
    // var rev = JPverb.ar(
    //             sigL,
    //             \t60.kr(1,           0.05),
    //             \damp.kr(0,          0.05),
    //             \size.kr(1,          0.05),
    //             \earlydiff.kr(0.707, 0.05),
    //             \mdepth.kr(5,        0.05),
    //             \mfreq.kr(2,         0.05),
    //             \lowx.kr(1,          0.05),
    //             \midx.kr(1,          0.05),
    //             \highx.kr(1,         0.05),
    //             \lowband.kr(500,     0.05),
    //             \highband.kr(2000,   0.05)
    //     );

    sigL;
}.play;
)

y.set(\damp, 0.5)
y.set(\highband, 100)