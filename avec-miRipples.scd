
(   // filter sweep + distortion
y.free;
y = {
    var cf = LFTri.kr(0.03).range(0.1,0.9);
    var lenv = EnvGen.kr(Env.circle([0, 0.9, 0, 0], [0.2, 0.1, 2], [8, 8]));
    var lenv2 = EnvGen.kr(Env.circle([0, 1, 0], [0.1, 0.25], [8, 8]));
    var out = MiRipples.ar(Saw.ar(110 * (36 - 24 + 12).midiratio * [1.001, 1]), 0.3 + (lenv * 0.125), lenv, 10, 0.2);
    out = out + (LPF.ar(CombL.ar(out, 0.001, decaytime: 128 * 2) * 4, 400));
    LeakDC.ar(out * 0.5);
}.play;
)
(   // filter sweep + distortion
x.free;
x = {
    var cf = LFTri.kr(0.03).range(0.1,0.9);
    var lenv = EnvGen.kr(Env.circle([0, 0.9, 0, 0], [0.2, 0.1, 2], [8, 8]));
    var lenv2 = EnvGen.kr(Env.circle([0, 1, 0], [0.1, 0.25], [8, 8]));
    var out = MiRipples.ar(Saw.ar(55 * (36 - 24 + 5).midiratio * [1.001, 1]), 0.3 + (lenv * 0.125), lenv, 10, 0.2);
    out = out + (LPF.ar(CombL.ar(out, 0.001, decaytime: 128 * 2) * 4, 400));
    out = out + (CombL.ar(out, 0.2, decaytime: 3) * 0.25);
    out = out + (HPF.ar(out, 4000) * 8);
    LeakDC.ar(out * 0.1);
}.play
)


(   // filter sweep + distortion
y.free;
y = {
    var cf = LFTri.kr(0.03).range(0.1,0.9);
    var lenv = EnvGen.kr(Env.circle([0, 0.9, 0, 0], [0.1, 1, 0.1], [8, 8]));
    var lenv2 = EnvGen.kr(Env.circle([0, 1, 0], [0.2, 0.05], [8, 8]));
    var out = MiRipples.ar(Saw.ar(110 * (36 - 24 + 5).midiratio * [1.001, 1]), 0.5 + (lenv * 0.125), lenv, 4, 0.2);
    out = out + (LPF.ar(CombL.ar(out, 0.001, decaytime: 128 * 2) * 4, 400));
    out = out + (HPF.ar(out, 4000) * 16) * lenv2;
    LeakDC.ar(out * 0.1);
}.play
)