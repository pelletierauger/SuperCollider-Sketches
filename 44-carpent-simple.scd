(
x.free;
x = {
    var r = ~toMidi.("C#5");
    var n = [
        -24,  0,  0,  0, 0,  0, -2,  0,
        -24,  0,  0,  0, 0,  0, -2,  0,
        -28, -1, -1, -1, -1, -1, -2, -1,
        -26,  1,  1,  1, 1,  1, 0,  1
    ] + [-12, 0, 0, 0, 0, 0, 0, 0].wrapExtend(24);
    var t = Impulse.kr(4);
    var d = Demand.kr(t, 0, Dseq(n, inf));
    var sig = MiBraids.ar(
        r + d,
        timbre: 0.5, color: 0.25, model: 1,
        resamp: 0
    );
    var e = EnvGen.kr(Env([0, 1, 0], [0.025, 0.5 - 0.025], [2, -8, 'lin']), t);
    sig = VadimFilter.ar(sig, 2000 * e + 100, 0, 1);
    sig * 0.5!2;
}.play;
y.free;
y = {
    var r = ~toMidi.("C#2");
    var t = Impulse.kr(4);
    var drums = [
        [1, 0, 1, 0, 1, 0, 1, 0],
        [0, 0, 1, 0],
        [1]
    ];
    var drTr = drums.size.collect({|i| t * Demand.kr(t, 0, Dseq(drums[i], inf))});
    var sig = MiBraids.ar(
        pitch: r,
        timbre: 0.5, color: 0.5, model: [34, 36, 36], trig: drTr,
        resamp: 0, decim: 0, bits: 0, ws: 0
    );
    sig = sig * [1, 1, 0.1];
    sig.sum * 1!2;
}.play;
)