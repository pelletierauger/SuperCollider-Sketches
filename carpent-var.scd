(
x.free;
x = {
    var r = ~toMidi.("C#4");
    var n = [
        0,  0,  -24, 0, -2, -24, 1, -24,
        0,  0,  -24, 0, 3, -24, 1, -24,
        -1, -1, -28, -1, -2, -28, -1, -28,
         1,  1,  -26, 1, 7,  -26, 5, -26
    ] + ([0, 0, 0,  -12, 0, -12, 0, -12].wrapExtend(24));
    var a = [0, 0, 0, 1, 0, 1, 0, 1];
    var a2 = [0, 0, 1, 0, 0, 1, 0, 1];
    var t = Impulse.kr(4);
    var d = Demand.kr(t, 0, Dseq(n, inf));
    var d2 = Demand.kr(t, 0, Dseq(a, inf));
    var d3 = Demand.kr(t, 0, Dseq(a2, inf));
    var sig = MiBraids.ar(
        r + d,
        timbre: 0.5 + (d2 * -0.1), color: 0.85, model: 1,
        resamp: 0
    ) * (0.35 + (d3.lag(0.01) * 0.5));
    var e = EnvGen.kr(Env([0, 1, 0], [0.025, 0.5 - 0.025], [2, -8, 'lin']), t);
    var h = VadimFilter.ar(sig, 2000, 0, 5);
    sig = VadimFilter.ar(sig, 2000 * e + 10, 0.125, 1) * 2 + (h * 0);
    // sig = blend(sig, VAKorg35.ar(sig, freq: 1000 * e + 100, res: 0.01, overdrive: 0.01) * 0.15, 0.1);

    sig * 0.25!2;
}.play;

    // 0.25.wait;
y.free;
y = {
    var r = ~toMidi.("C#2");
    var t = Impulse.kr(4);
    var drums = [
        [1, 0, 1, 0, 1, 0, 1, 0],
        [0, 0, 1, 0],
        [0, 1]
    ];
    var drTr = drums.size.collect({|i| t * Demand.kr(t, 0, Dseq(drums[i], inf))});
    var dd = Demand.kr(t, 0, Dseq([0, 0, 1, 1], inf)).lag(0.005);
    var ddd = Demand.kr(t, 0, Dseq([0, 1], inf)).lag(0.005);
    var sig = MiBraids.ar(
        pitch: r + [0, 12, 36],
        timbre: [0.5, 1, 0.1], color: [0.5, 0.5, 0.1], model: [34, 36, 36], trig: drTr,
        resamp: 0, decim: 30, bits: 4, ws: 0.5
    );
    sig = sig * [1, 1, 0.05];
    // sig[2] = DelayN.ar(sig[2], 1, 1/6/4);
    // sig = sig[0] + sig[2];
    // sig = sig.sum;
    sig = sig[0] + (sig[1] * dd) + (sig[2] * ddd * 0);
    sig = VadimFilter.ar(sig, 3000, 0, 1) * 0.5!2;
    // sig = [sig, DelayC.ar(sig, 0.5, 0.005)];
    // sig = sig + ([sig[1], sig[0]] * 0.5) * 0.5;
}.play(fadeTime:0);

)


(
x.free;
x = {
    var r = ~toMidi.("C#6");
    var n = [
        -24,  0,  0,  -24, 0, -2, -24, 0,
        -24,  0,  0,  -24, 0, -2, -24, 0,
        -28, -1, -1, -28, -1, -2, -28, -1,
        -26,  1,  1,  -26, 1, 0,  -26, 1
    ] + (1 - [1, 0, 0, 0,  1, 0, 1, 0].wrapExtend(24) * -24);
    var a = [1, 0, 0, 0, 1, 0, 1, 0];
    var t = Impulse.kr(4);
    var d = Demand.kr(t, 0, Dseq(n, inf));
    var d2 = Demand.kr(t, 0, Dseq(a, inf));
    var sig = MiBraids.ar(
        r + d,
        timbre: 0.5 + (d2 * 0.5), color: 0.25, model: 9,
        resamp: 0
    );
    var e = EnvGen.kr(Env([0, 1, 0], [0.025, 0.5 - 0.025], [2, -8, 'lin']), t);
    var h = VadimFilter.ar(sig, 2000, 0, 5);
    sig = VadimFilter.ar(sig, 1000 * e + 100, 0.25, 1) * 2 + (h * 0);
    sig * 0.25!2;
}.play;
)