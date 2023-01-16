(
~hissXZA.free;
~hissXZA = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[1] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq(1!1 ++ (1!1), inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var ddd = Demand.kr(t, 0, Dseq([3].stutter(1), inf));
    // var e = EnvGen.kr(Env.new([0.001, 1, 0.001], [0.15, 6].reverse, ['exp']), gate: t).lag(0.01);
    var e = 1;
    var ri;
    var pitch = ~toMidi.("A#4") + ddd;
        var scr = Demand.kr(t!2, 0, Dwhite(0.00, 1.00, inf));
    var sta = Demand.kr(t, 0, Dseq([1, 0, 0, 0], inf));
        var sto = Demand.kr(sta, 0, Dwrand([0, 1], [0.05, 0.95], inf));
        var si = 1 - sto * 0.5;

    var sig = MiBraids.ar(pitch + [0, 0.2, 0.1, 0.3] + 0,
        timbre: 0+(1-e), color: 0.75, model: 14
    ).sum;
    var sig3;
    var sig2 = MiBraids.ar(pitch + [0, 0.2, 0.1, 0.3] + 0.5,
        timbre: 0+(1-e), color: 0.75, model: 14
    ).sum;
    sig = [sig + (sig2*(e.linlin(0,1,0.5,1))), sig2 + (sig*(e.linlin(0,1,0.5,1)))];
            sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25 + (si*0.7), algo: 2, timb: 0.4 + si)[0]);
        sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25 + (si*0.7), algo: 2, timb: 0.4 + si)[0]);
        sig3 = [sig2, sig3] * 0.5;
        sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500) - 400, 0, 5) * 8;
        sig = (sig3 * Demand.kr(t!2, 0, Dwhite(0.00, 1.00, inf)).lag(1));
// sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    // sig = VadimFilter.ar(sig, 3000 * env.lag(0.01) + 100, 0, 5) * 8;
    // sig = ~v.(sig, 3500 * ~lfo.(~nT.tempo*4*e,0.5+(1-(0.5*e)),1) * e + 500, 0, 1);
    // sig = (ri) + (sig * ri * 0);
    sig * 1 * dd.lag(0.4);
}.play;
)