(
if(~drone4.isPlaying, {~drone4.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
~drone4 = {
    | trigGate = 1|
    var tr = ~tks.(1, trigGate);
    var dd = tr[1];
    var t = (tr[0]) * dd;
    var e = EnvGen.kr(Env([0, 1, 0], [0.05, 1], [-1, -6, 'lin']), t);
    var mel = Demand.kr(t, 0, Dseq([0, 2, 3, 5, 6, 5, 6].scramble, inf));
    var tim = Demand.kr(t, 0, Dseq([0.63, 0.3].stutter(16), inf));
    var sig = MiBraids.ar(~toMidi.("Ab3") - 6 + mel,
        timbre: 0.43,
        color: 0.275,
        model: 6
    );
    sig = ~v.(sig, 5000 * e + 100);
    ~v.(sig, 1000, 0, 5) * 0.5 ! 2;
}.play().register;
)


(
if(~drone2.isPlaying, {~drone2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
~drone2 = {
    | trigGate = 1|
    var tr = ~tks.(1, trigGate);
    var dd = tr[1];
    var t = (tr[0]) * dd;
    var e = EnvGen.kr(Env([0, 1, 0], [0.05, 1], [-1, -6, 'lin']), t);
    var mel = Demand.kr(t, 0, Dseq([0, 2, 3, 5, 6, 5, 6].scramble.stutter(4), inf));
    var tim = Demand.kr(t, 0, Dseq([0.63, 0.3].stutter(16), inf));
    var sig = MiBraids.ar(~toMidi.("Ab3") - 6 + mel,
        timbre: 0.63,
        color: 0.275,
        model: 6
    );
    sig = ~v.(sig, 5000 * e + 100);
    ~v.(sig, 1000, 0, 5) * 0.5 ! 2;
}.play().register;
)

s.mute
s.unmute


(
if(~drone2.isPlaying, {~drone2.set(\trigGate, 0, \gate, 0, \fadeTime, 1.1)});
~drone2 = {
    | trigGate = 1|
    var tr = ~tks.(1, trigGate);
    var dd = tr[1];
    var t = (tr[0]) * dd;
    var e = EnvGen.kr(Env([0, 1, 0.5, 0], [0.01, 0.05, 1], [6, 0, -6, 'lin']), t);
    var mel = Demand.kr(t, 0, Dseq([0, 7, 2, 7, 8, 7, 8, 7] + [0,12].stutter(3), inf));
    var tim = Demand.kr(t, 0, Dseq([0.63, 0.3].stutter(16), inf));
    var sig = MiBraids.ar(~toMidi.("Ab3") - 6 + mel,
        timbre: 0.63,
        color: 0.5,
        model: 6,
        // resamp: 2, decim: 10, bits: 4, ws: 0.5
    );
    sig = MiWarps.ar(sig, sig, 0.9, 0.95, algo: 3, timb: 0.75)[0];
    sig = ~v.(sig, 700 * e + 10);
    ~v.(sig, 50, 0, 5) * 1 ! 2;
}.play().register;
)



// ---asdfasdf


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
    var mel = Demand.kr(t, 0, Dseq(a ++ b, inf));
    var tim = Demand.kr(t, 0, Dseq([0.63, 0.3].stutter(16), inf));
    var sig = MiBraids.ar(~toMidi.("Ab3") - 6 + mel,
        timbre: 0.63,
        color: 0.5,
        model: 6,
        // resamp: 2, decim: 10, bits: 4, ws: 0.5
    );
    sig = MiWarps.ar(sig, sig, 0.9, 0.95, algo: 3, timb: 0.75)[0];
    sig = ~v.(sig, 700 * e + 10);
    ~v.(sig, 50, 0, 5) * 1 ! 2;
}.play().register;
)

// asdfasdfasdf

(
if(~drone2b.isPlaying, {~drone2b.set(\trigGate, 0, \gate, 0, \fadeTime, 1.1)});
~drone2b = {
    | trigGate = 1|
    var tr = ~tks.(1, trigGate);
    var dd = tr[1];
    var t = (tr[0]) * dd;
    var rel = Demand.kr(t, 0, Dwhite(1, 2, inf));
    var mel2 = Demand.kr(t, 0, Drand([0, 7, 3, 7, 8, 7, 8, 7], inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.001, rel], [6, -6, 'lin']), t);
    var mel = Demand.kr(t, 0, Dseq([0, 7, 3, 7].scramble + [0,12].stutter(3), inf));
    var tim = Demand.kr(t, 0, Dseq([0.63, 0.3].stutter(16), inf));
    var sig = MiBraids.ar(~toMidi.("Ab3") - 6 + mel,
        timbre: 0.63,
        color: 0.5,
        model: 6,
        // resamp: 2, decim: 10, bits: 4, ws: 0.5
    );
    sig = MiWarps.ar(sig, sig, 0.9, 0.95, algo: 3, timb: 0.75)[0];
    sig = ~v.(sig, 2700 * e + 10);
    ~v.(sig, 1500, 0, 5) * 1 ! 2;
}.play().register;
)


(
if(~bas.isPlaying, {~bas.set(\trigGate, 0, \gate, 0, \fadeTime, 1.1)});
~bas = {
    | trigGate = 1|
    var tr = ~tks.(1, trigGate);
    var dd = tr[1];
    var t = (tr[0]) * dd;
    var t0 = Demand.kr(t, 0, Dseq([1, 0, 0, 0, 0, 0, 0, 0], inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 6], [8, -2, 'lin']), t0).lag(0.1);
    var mel = Demand.kr(t0, 0, Dseq([0, 0, 3, 5, 6, 5, 6].scramble, inf));
    var tim = Demand.kr(t0, 0, Dseq([0.63, 0.3].stutter(16), inf));
    var sig = MiBraids.ar(~toMidi.("Ab2") - 6 + mel,
        timbre: 0.9 * e,
        color: 0.75 * e + 0.2,
        model: 3
    );
    // sig = sig + (MiWarps.ar(sig, sig, 0.9, 0.95, algo: 3, timb: 0.75)[0] * 6);
    sig = ~v.(sig, 12000 * e + 100) * dd.lag(0.25);
    sig = ~v.(sig, 200, 0, 5);
    sig * 0.125 * 0.5 ! 2;
}.play().register;
)


(
~s.stop;
~s = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([Rest(1), 1], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, ~snares[46],
    \amp, Pseq([0.125] * 0.5, inf)
).play(~nT, quant: 2);
)

v.free

(
if(~bas.isPlaying, {~bas.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
~bas = {
    | trigGate = 1|
    var tr = ~tks.(1, trigGate);
    var dd = tr[1];
    var t = (tr[0]) * dd;
    var t0 = Demand.kr(t, 0, Dseq([1, 0, 0, 0, 0, 0, 0, 0], inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 6], [8, -2, 'lin']), t0).lag(0.1);
    var mel = Demand.kr(t0, 0, Dseq([0, 2, 3, 5, 6, 5, 6].scramble, inf));
    var tim = Demand.kr(t0, 0, Dseq([0.63, 0.3].stutter(16), inf));
    var sig = MiBraids.ar(~toMidi.("Ab2") - 6 + mel,
        timbre: 0.9 * e,
        color: 0.75 * e + 0.2,
        model: 3
    );
    sig = sig + (MiWarps.ar(sig, sig, 0.9, 0.95, algo: 3, timb: 0.75)[0] * 6);
    sig = ~v.(sig, 12000 * e + 100) * dd.lag(0.25);
    sig = ~v.(sig, 200, 0, 5);
    sig = MiWarps.ar(sig, sig, 0.9, 0.95, algo: 3, timb: 0.75)[0];
    // sig = MiWarps.ar(sig, sig, 0.9, 0.95, algo: 1, timb: 0.125)[0];
    sig * 0.125 * 2 * Line.kr(0, 1, 2) ! 2;
}.play().register;
)



(
if(~bas.isPlaying, {~bas.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
~bas = {
    | trigGate = 1|
    var tr = ~tks.(1, trigGate);
    var dd = tr[1];
    var t = (tr[0]) * dd;
    var t0 = Demand.kr(t, 0, Dseq([1, 0, 0, 0, 0, 0, 0, 0], inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.5, 3], [8, -2, 'lin']), t0).lag(0.1);
    var mel = Demand.kr(t0, 0, Dseq([0, 2, 3, 5, 6, 5, 6].scramble, inf));
    var tim = Demand.kr(t0, 0, Dseq([0.63, 0.3].stutter(16), inf));
    var sig = MiBraids.ar(~toMidi.("D1") + mel,
        timbre: 0.5 * e,
        color: 0.75 * e  + 0.2,
        model: 3
    );
    sig = sig + (MiWarps.ar(sig, sig, 0.9, 0.95, algo: 3, timb: 0.75)[0] * 6);
    sig = ~v.(sig, 12000 * e + 1000) * dd.lag(0.25);
    sig = ~v.(sig, 200, 0, 5);
    sig = sig ! 2;
    sig[0] = MiWarps.ar(sig[0], sig[0], 0.59, 0.95, algo: 3, timb: 0.75)[0];
    sig[1] = MiWarps.ar(sig[1], sig[1], 0.9, 0.5, algo: 3, timb: 0.265)[0];
    // sig = MiWarps.ar(sig, sig, 0.9, 0.95, algo: 1, timb: 0.125)[0];
    sig = ~v.(sig, 2000 * e.lag(1) + 100);
    sig * 0.125 * 1 * Line.kr(0, 1, 2);
}.play().register;
)