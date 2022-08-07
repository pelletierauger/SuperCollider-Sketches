(
x.free;
x = {
    var sig;
    var tempo = 0.35;
    var t = Impulse.ar(1 * tempo);
    var t6 = Impulse.ar(6 * tempo) * 2;
    var t16 = Impulse.ar(16 * tempo) * 0.5;
    t = DelayN.ar(t, 1, 0.05);
    t6 = DelayN.ar(t6, 1, 0.05);
    t16 = DelayN.ar(t16, 1, 0.05);
    t = MiRings.ar(t, pit:48 + 12, struct:0.5,damp: 0.25, pos:0.25 ) * 8;
    t6 = MiRings.ar(t6, pit:48, struct:0.5,damp: 0.25, pos: 0.25) * 8;
    t16 = MiRings.ar(t16, pit:48 + 12, struct:0.5,damp: 0.25, pos:1) * 8;
    sig = t + VadimFilter.ar(t6,5000,0,1) + VadimFilter.ar(t16,9000,0,1) * 0.1!2;
    // t6 * 0.1;
    sig = MiRings.ar(sig, 0, pit: 60 - 12, struct: 0.125, bright: 0.5, damp: 0.3, model:3);
    sig = sig + (t6 + t16 * 0.01);
}.play(fadeTime: 0);
)


(
x.free;
x = {
    var tempo = 0.35;
    var t = Impulse.kr(1 * tempo);
    var t6 = Impulse.kr(6 * tempo);
    var t12 = Impulse.kr(12 * tempo);
    var d12 = Demand.kr(t12, 0, Dseq([3, 0.125, 0.125], inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.01, [3, 1, 1.5] * 1.2], [-12, -8, 'lin']), [t, t6, t12]);
    var sig = WhiteNoise.ar(1!3);
    sig = VadimFilter.ar(sig, 4000 * e + 300 * [1.25, 2, d12], 0, 1) * e;
    // sig = MiWarps.ar(LPF.ar(WhiteNoise.ar(),1000), sig, lev1:0.25,lev2:0.75,algo:4,timb:0.75) * e;
    // sig.sum * 0.1!2;
    sig[1] * 1 + sig[2] * 0.1!2;
}.play(fadeTime: 0);
)


(
x.free;
x = {
    var tempo = 1.75;
        var t = Impulse.kr(1 * tempo);
        var t2 = Impulse.kr(4 * tempo);
    var d = Demand.kr(t2, 0, Dseq([0.35, 1].reverse, inf));
    var d2 = Demand.kr(t2, 0, Dseq(
        [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0] ++
        [1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0]
        , inf));
    var d3 = Demand.kr(t2, 0, Dwhite(0, 0.95, inf));
    var sig = AnalogSnareDrum.ar([t, t2],
        accent: [0.75, 0.5],
        freq: [48, 36 + 24 + 24] + 24,
        tone: [0.5, 0.1],
        decay: [0.2, 0.005 + (d2 * 1)] + 0.4,
        snappy: [0.2, 0.2] + 0
    ) * [1.4, d.lag(0.01)];
    sig = VadimFilter.ar(sig, 1500, 0, 5);
    // sig = sig.sum * 0.1;
    sig = MiWarps.ar(sig[0], sig[1], lev1:0.5,lev2:0.5,algo:1,timb:0.15)[0];
    sig * 0.1!2;
}.play(fadeTime:0);
)