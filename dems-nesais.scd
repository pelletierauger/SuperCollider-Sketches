(
if(~drone2.isPlaying, {~drone2.set(\trigGate, 0, \gate, 0, \fadeTime, 1.1)});
~drone2 = {
    | trigGate = 1|
    var tr = ~tks.(1, trigGate);
    var dd = tr[1];
    var t = (tr[0]) * dd;
    var e = EnvGen.kr(Env([0, 1, 0.5, 0], [0.01, 0.1, 2], [6, 0, -6, 'lin']), t);
    var a = ([0, 7, 2, 7, 8, 7, 8, 7] + [0,12].stutter(3)).wrapExtend(16);
    var b = ([0, 7, 1, 7, 8, 7, 8, 7] + [0,12].stutter(3)).wrapExtend(16);
    var mel = Demand.kr(t, 0, Dseq(a, inf));
    var tim = Demand.kr(t, 0, Dseq([0.63, 0.3].stutter(16), inf));
    var decim = Demand.kr(t, 0, Dseq([Dseries(0, 1, 16)], inf));
    var bits = Demand.kr(t, 0, Dxrand([0,1,2,3,4,5], inf));
    var sig = MiBraids.ar(~toMidi.("D5") + mel,
        timbre: 0.63,
        color: 0.5,
        model: 14,
        resamp: 2, decim: decim, bits: 4, ws: 0.5
    );
    sig = MiWarps.ar(sig, sig, 0.9, 0.95, algo: 3, timb: 0.95)[0];
    // sig = MiWarps.ar(sig, sig, 0.9, 0.95, algo: 4, timb: 0.95)[0];
    sig = ~v.(sig, 2700 * e + 10);
    sig = ~v.(sig, 250, 0, 5) * 2 ! 2;
}.play().register;
)


(
if(~drone2.isPlaying, {~drone2.set(\trigGate, 0, \gate, 0, \fadeTime, 1.1)});
~drone2 = {
    | trigGate = 1|
    var tr = ~tks.(1, trigGate);
    var dd = tr[1];
    var t = (tr[0]) * dd;
    var e = EnvGen.kr(Env([0, 1, 0.5, 0], [0.01, 0.1, 2], [6, 0, -6, 'lin']), t);
    var a = ([0, 7, 2, 7, 8, 7, 8, 7] + [0,12].stutter(3)).wrapExtend(16);
    var b = ([0, 7, 1, 7, 8, 7, 8, 7] + [0,12].stutter(3)).wrapExtend(16);
    var mel = Demand.kr(t, 0, Dseq(a, inf));
    var tim = Demand.kr(t, 0, Dseq([0.63, 0.3].stutter(16), inf));
    var decim = Demand.kr(t, 0, Dseq([Dseries(0, 1, 16)], inf));
    var bits = Demand.kr(t, 0, Dxrand([0,1,2,3,4,5], inf));
    var sig = MiBraids.ar(~toMidi.("D4") + mel,
        timbre: 0.63,
        color: 0.75,
        model: 30,
        resamp: 2, decim: decim+12, bits: bits, ws: 0.5
    );
    sig = MiWarps.ar(sig, sig, 0.9, 0.95, algo: 3, timb: 0.95)[0];
    // sig = MiWarps.ar(sig, sig, 0.9, 0.95, algo: 4, timb: 0.95)[0];
    sig = ~v.(sig, 4700 * e + 10);
    sig = ~v.(sig, 1550, 0, 5) * 8 ! 2;
}.play().register;
)