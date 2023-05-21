(
~think = {
    ~drone2 = {
    | trigGate = 1|
    var t = In.kr(~cb, 2)[1] * trigGate;
    var rel = Demand.kr(t, 0, Dwrand([1, 2], [0.9, 0.1], inf));
    var e = EnvGen.kr(Env([0, 1, 0.5, 0], [0.01, 0.05, rel], [6, 0, -6, 'lin']), t);
    var a = (~melody + [0,12].stutter(3)).wrapExtend(~melody.size * 2);
    var b = ([0, 7, 1, 7, 8, 7, 8, 7] + [0,12].stutter(3)).wrapExtend(16);
    var mel = Demand.kr(t, 0, Dseq(a, inf));
    var decim = Demand.kr(t, 0, Dseq(~decim, inf));
    var bits = Demand.kr(t, 0, Dseq(~bits, inf));
    var tim = Demand.kr(t, 0, Dseq([0.63, 0.3].stutter(16), inf));
    var sig = MiBraids.ar(~toMidi.("D3") + mel,
        timbre: 0.63,
        color: 0.5,
        model: 6,
        resamp: 2, decim: decim, bits: bits, ws: 0
    );
    sig = MiWarps.ar(sig, sig, 0.9, 0.95, algo: 3, timb: 0.75)[0];
    sig = ~v.(sig, (700 + min(10000, decim * 300)) * e + 10);
    sig = ~v.(sig, 250, 0, 5) * 2;
        sig = sig + ~v.(CombN.ar(sig, 4, (~nT.beatDur/[3,6,1.5].choose) * [1, 1.01], Rand(1.0, 3.0)) * Rand(0.0, 0.5),3000);
}.play().register;
};
)