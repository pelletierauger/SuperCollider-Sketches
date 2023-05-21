(
if(~drone2.isPlaying, {~drone2.set(\trigGate, 0, \gate, 0, \fadeTime, 1.1)});
~drone2 = {
    | trigGate = 1|
    var tr = ~tks.(1, trigGate);
    var dd = tr[1];
    var t = (tr[0]) * dd;
    var e = EnvGen.kr(Env([0, 1, 0.5, 0], [0.01, 0.05, 1], [6, 0, -6, 'lin']), t);
    var a = ([0, 7, 2, 7, 8, 7, 8, 7] + [0,12].stutter(3)).wrapExtend(16);
    var b = ([0, 7, 1, 7, 8, 7, 8, 7] + [0,12].stutter(3)).wrapExtend(16);
    var mel = Demand.kr(t, 0, Dseq(a, inf));
    var tim = Demand.kr(t, 0, Dseq([0.63, 0.3].stutter(16), inf));
    var sig = MiBraids.ar(~toMidi.("D3") + mel,
        timbre: 0.63,
        color: 0.5,
        model: 6,
        // resamp: 2, decim: 10, bits: 4, ws: 0.5
    );
    sig = MiWarps.ar(sig, sig, 0.9, 0.95, algo: 3, timb: 0.75)[0];
    sig = ~v.(sig, 700 * e + 10);
    sig = ~v.(sig, 250, 0, 5) * 1 ! 2;
}.play().register;
)


(
if(~drone3.isPlaying, {~drone3.set(\trigGate, 0, \gate, 0, \fadeTime, 1.1)});
~drone3 = {
    | trigGate = 1|
    var tr = ~tks.(1, trigGate);
    var dd = tr[1];
    var t = (tr[0]) * dd;
    var e = EnvGen.kr(Env([0, 1, 0.5, 0], [0.01, 0.05, 1], [6, 0, -6, 'lin']), t);
    var a = ([0, 7, 2, 7, 8, 7, 8, 7] + [0,12].stutter(3)).wrapExtend(17);
    var b = ([0, 7, 1, 7, 8, 7, 8, 7] + [0,12].stutter(3)).wrapExtend(17);
    var mel = Demand.kr(t, 0, Dseq((a ++ b).rotate(3) + 12, inf));
    var tim = Demand.kr(t, 0, Dseq([0.63, 0.3].stutter(16), inf));
    var sig = MiBraids.ar(~toMidi.("D3") + mel,
        timbre: 0.63,
        color: 0.5,
        model: 6,
        // resamp: 2, decim: 10, bits: 4, ws: 0.5
    );
    sig = MiWarps.ar(sig, sig, 0.9, 0.95, algo: 3, timb: 0.75)[0];
    sig = ~v.(sig, 700 * e + 10);
    sig = ~v.(sig, 250, 0, 5) * 4;
        sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
}.play().register;
)


(
if(~drone5.isPlaying, {~drone5.set(\trigGate, 0, \gate, 0, \fadeTime, 1.1)});
~drone5 = {
    | trigGate = 1|
    var tr = ~tks.(1, trigGate);
    var dd = tr[1];
    var t = (tr[0]) * dd;
    var e = EnvGen.kr(Env([0, 1, 0.5, 0], [0.01, 0.05, 1], [6, 0, -6, 'lin']), t);
    var a = ([0, 7, 2, 7, 8, 7, 8, 7] + [12, 0].stutter(5)).wrapExtend(16);
    var b = ([0, 7, 1, 7, 8, 7, 8, 7] + [12, 0].stutter(5)).wrapExtend(16);
    var mel = Demand.kr(t, 0, Dseq((a ++ b).rotate(9) + 12, inf));
    var tim = Demand.kr(t, 0, Dseq([0.63, 0.3].stutter(16), inf));
    var sig = MiBraids.ar(~toMidi.("D5") + mel,
        timbre: 0.1263,
        color: 0.25,
        model: 6,
        resamp: 2, decim: 3, bits: 2, ws: 0.5
    );
    sig = MiWarps.ar(sig, sig, 0.9, 0.95, algo: 3, timb: 0.75)[0];
    sig = ~v.(sig, 700 * e + 10);
    sig = ~v.(sig, 50, 0, 5) * 2;
        sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    // sig = DelayC.ar(sig, 1, ~nT.beatDur * 0.125);
    sig = sig + (sig.reverse * 0.5) * 4;
}.play().register;
)