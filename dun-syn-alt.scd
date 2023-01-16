~nT.tempo = 1;
~line = {|dur = 1|Line.kr(0, 1, dur)};

// Les deux lignes

(
~hissXZ.free;
~hissXZ = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[1] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq(1!1 ++ (0!15), inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var ddd = Demand.kr(t, 0, Dseq([8,7,5,7].stutter(1), inf));
    var e = EnvGen.kr(Env.new([0.001, 1, 0.001], [0.15, 6], ['exp']), gate: t).lag(0.01);
    var ri;
    var pitch = ~toMidi.("A#3") + ddd;
    var sig = MiBraids.ar(pitch + [0, 0.2, 0.1, 0.3] + 0,
        timbre: 0.72+(1-e), color: 0.5, model: 14
    ).sum;
    var sig2 = MiBraids.ar(pitch + [0, 0.2, 0.1, 0.3] + 0.5,
        timbre: 0.72+(1-e), color: 0.5, model: 14
    ).sum;
    sig = [sig + (sig2*(e.linlin(0,1,0.5,1))), sig2 + (sig*(e.linlin(0,1,0.5,1)))];
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    // sig = VadimFilter.ar(sig, 3000 * env.lag(0.01) + 100, 0, 5) * 8;
    sig = ~v.(sig, 1500 * ~lfo.(~nT.tempo*4*e,0.5+(1-(0.5*e)),1) * e + 500, 0, 1);
    // sig = (ri) + (sig * ri * 0);
    sig * 0.5 * dd.lag(0.4) * ~line.(30);
}.play;

~hissXZZ.free;
~hissXZZ = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[1] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq(1!1 ++ (0!15), inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var ddd = Demand.kr(t, 0, Dseq([-12,-14,-16,-17].stutter(1), inf));
    var e = EnvGen.kr(Env.new([0.001, 1, 0.001], [0.15, 12], ['exp']), gate: t).lag(0.01);
    var ri;
    var pitch = ~toMidi.("A#2") + ddd;
    var sig = MiBraids.ar(pitch + [0, 0.2, 0.1, 0.3] + 0,
        timbre: 0.1, color: 0.5, model: 14
    ).sum;
    var sig2 = MiBraids.ar(pitch + [0, 0.2, 0.1, 0.3] + 0.5,
        timbre: 0.1, color: 0.5, model: 14
    ).sum;
    sig = [sig + (sig2*(e.linlin(1,0,0.5,1))), sig2 + (sig*(e.linlin(1,0,0.5,1)))];
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    // sig = VadimFilter.ar(sig, 3000 * env.lag(0.01) + 100, 0, 5) * 8;
    sig = ~v.(sig, 1000 * ~lfo.(~nT.tempo*4*e,0.5+(1-(0.5*e)),1) * e + 500, 0, 1);
    // sig = VAKorg35.ar(sig, ~toFreq.("A#2"),0);
    // sig = (ri) + (sig * ri * 0);
    sig * 1 * dd.lag(0.4) * ~line.(30);
}.play;
)
(
~k.set(\trigGate, 0, \gate, 0, \fadeTime, 0.01);
~k = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq(
        // [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0] ++
        [1, 0, 0, 1, 0, 0, 1, 0]
        // (1!1) ++ (1!1)
        , inf));
    // var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0, 1].rotate(1), inf));
    var levv = Demand.kr(b, 0, Dseq([0.25, 0, 0, 0, 0.35].rotate(1), inf));
    var dec = Demand.kr(b, 0, Dseq([0.8, 0.6, 0.6, 0.6, 0.8].rotate(1), inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1], -8), b);
    var level = b.lag(0.5) * m2 * 2 + (b * 0);
    var harm = Demand.kr(b, 0, Dwhite(0.75, 1.00, inf));
    var timbre = Demand.kr(b, 0, Dseq([0.5, 0.5, 1], inf));
    var morph = Demand.kr(b, 0, Dwhite(0.00, 1.00, inf));
    var fm_mod = Demand.kr(b, 0, Dwhite(-1.00, 1.00, inf));
    var timb_mod = Demand.kr(b, 0, Dwhite(-1.00, 1.00, inf));
    var morph_mod = Demand.kr(b, 0, Dwhite(-1.00, 1.00, inf));
    var warps = Demand.kr(b, 0, Dwhite(0.00, 1.00, inf)).lag(0.01);
    var pitch = Demand.kr(b, 0, Drand((0..1)*12,inf));
    var sig = MiPlaits.ar(
        pitch: ~toMidi.("A1"),      engine: 13,
        harm: harm,          timbre: timbre,            morph: 1,
        trigger: b,          level: 0,
        fm_mod: 0,      timb_mod: timb_mod,       morph_mod: morph_mod,
   )[1];
    // var dee = Demand.kr(b, 0, Dseq([0.04, 0.24, 0.24, 0.14, 0.14], inf));
    // sig = sig * 1 + (MiWarps.ar(sig, PinkNoise.ar() * sig, 0.5, 0.75, algo: 2, timb: 0.8)[0]* warps);
    // var v = 0;
    // sig = VadimFilter.ar(sig, 8000, 0, 1);
    // MouseX.kr().poll;
    // MouseY.kr().poll;
    // sig = [sig, DelayC.ar(sig, 0.5, 0.005)];
    // sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 2 ! 2;
    // sig = VadimFilter.ar(sig, 50, 0, 5);
}.play(fadeTime: 0);
)



(
~hissXZZ.free;
~hissXZZ = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[1] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq(1!1 ++ (0!15), inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var ddd = Demand.kr(t, 0, Dseq([-12,-14,-16,-19].stutter(1), inf));
    var e = EnvGen.kr(Env.new([0.001, 1, 0.001], [0.15, 12], ['exp']), gate: t).lag(0.01);
    var ri;
    var pitch = ~toMidi.("A#2") + ddd;
    var sig = MiBraids.ar(pitch + [0, 0.2, 0.1, 0.3] + 0,
        timbre: 0.1, color: 0.5, model: 14
    ).sum;
    var sig2 = MiBraids.ar(pitch + [0, 0.2, 0.1, 0.3] + 0.5,
        timbre: 0.1, color: 0.5, model: 14
    ).sum;
    sig = [sig + (sig2*(e.linlin(1,0,0.5,1))), sig2 + (sig*(e.linlin(1,0,0.5,1)))];
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    // sig = VadimFilter.ar(sig, 3000 * env.lag(0.01) + 100, 0, 5) * 8;
    sig = ~v.(sig, 1000 * ~lfo.(~nT.tempo*4*e,0.5+(1-(0.5*e)),1) * e + 500, 0, 1);
    // sig = VAKorg35.ar(sig, ~toFreq.("A#2"),0);
    // sig = (ri) + (sig * ri * 0);
    sig * 1 * dd.lag(0.4);
}.play;
)



// Les soufflements
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
        timbre: 0.72+(1-e), color: 0.5, model: 14
    ).sum;
    var sig3;
    var sig2 = MiBraids.ar(pitch + [0, 0.2, 0.1, 0.3] + 0.5,
        timbre: 0.72+(1-e), color: 0.5, model: 14
    ).sum;
    sig = [sig + (sig2*(e.linlin(0,1,0.5,1))), sig2 + (sig*(e.linlin(0,1,0.5,1)))];
            sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25 + (si*0.7), algo: 1, timb: 0.4 + si)[0]);
        sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25 + (si*0.7), algo: 1, timb: 0.4 + si)[0]);
        sig3 = [sig2, sig3] * 0.5;
        sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500) - 400, 0, 5) * 8;
        sig = (sig3 * Demand.kr(t!2, 0, Dwhite(0.00, 1.00, inf)).lag(1));
// sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    // sig = VadimFilter.ar(sig, 3000 * env.lag(0.01) + 100, 0, 5) * 8;
    // sig = ~v.(sig, 3500 * ~lfo.(~nT.tempo*4*e,0.5+(1-(0.5*e)),1) * e + 500, 0, 1);
    // sig = (ri) + (sig * ri * 0);
    sig * 0.5 * dd.lag(0.4);
}.play;
)


// Les kicks
(
~k.set(\trigGate, 0, \gate, 0, \fadeTime, 0.01);
~k = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq(
        // [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0] ++
        [1, 0, 0, 1, 0, 0, 1, 0]
        // (1!1) ++ (1!1)
        , inf));
    // var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0, 1].rotate(1), inf));
    var levv = Demand.kr(b, 0, Dseq([0.25, 0, 0, 0, 0.35].rotate(1), inf));
    var dec = Demand.kr(b, 0, Dseq([0.8, 0.6, 0.6, 0.6, 0.8].rotate(1), inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1], -8), b);
    var level = b.lag(0.5) * m2 * 2 + (b * 0);
    var harm = Demand.kr(b, 0, Dwhite(0.75, 1.00, inf));
    var timbre = Demand.kr(b, 0, Dseq([0.5, 0.5, 1], inf));
    var morph = Demand.kr(b, 0, Dwhite(0.00, 1.00, inf));
    var fm_mod = Demand.kr(b, 0, Dwhite(-1.00, 1.00, inf));
    var timb_mod = Demand.kr(b, 0, Dwhite(-1.00, 1.00, inf));
    var morph_mod = Demand.kr(b, 0, Dwhite(-1.00, 1.00, inf));
    var warps = Demand.kr(b, 0, Dwhite(0.00, 1.00, inf)).lag(0.01);
    var pitch = Demand.kr(b, 0, Drand((0..1)*12,inf));
    var sig = MiPlaits.ar(
        pitch: ~toMidi.("A1"),      engine: 13,
        harm: harm,          timbre: timbre,            morph: 1,
        trigger: b,          level: 0,
        fm_mod: 0,      timb_mod: timb_mod,       morph_mod: morph_mod,
   )[1];
    // var dee = Demand.kr(b, 0, Dseq([0.04, 0.24, 0.24, 0.14, 0.14], inf));
    // sig = sig * 1 + (MiWarps.ar(sig, PinkNoise.ar() * sig, 0.5, 0.75, algo: 2, timb: 0.8)[0]* warps);
    // var v = 0;
    // sig = VadimFilter.ar(sig, 8000, 0, 1);
    // MouseX.kr().poll;
    // MouseY.kr().poll;
    // sig = [sig, DelayC.ar(sig, 0.5, 0.005)];
    // sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 2 ! 2;
    // sig = VadimFilter.ar(sig, 50, 0, 5);
}.play(fadeTime: 0);
)