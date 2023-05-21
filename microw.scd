~nT.tempo = 70 / 60;

(
~h.stop;
~h = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([0.25], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, ~hats[13],
    \amp, Pseq([0.75, 0.25, 0.5, 0.25] * 0.5, inf) * 0.125
).play(~nT, quant: 2);
)
(
~h.stop;
~h = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([0.25], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \spos, Pseq([0.05] ++ (0.1!3), inf),
    \buf, ~hats[13],
    \amp, Pseq([0.75] ++ ((4!3) * [0.5, 1, 0.5]), inf) * 0.125
).play(~nT, quant: 2);
)

(
~h2.stop;
~h2 = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([Rest(0.25), 0.25], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, ~hats[15],
    \amp, Pseq([0.75, 0.25, 0.5, 0.25] * 0.5, inf) * 0.25
).play(~nT, quant: 2);
)

(
~s.stop;
~s = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([Rest(1), 1], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, ~snares[46],
    \amp, Pseq([0.125] * 0.125, inf)
).play(~nT, quant: 2);
)



(
~k.stop;
~k = Pbind(
    \instrument, \samplerStereoLPF,
    \dur, Pseq(1!2 ++ (0.75!4) ++ (0.25!4) * 0.5, inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, Pseq([~kicks[10]], inf),
    \lpf, 500,
    \amp, 0.0625 * 1
).play(~nT, quant: 2);
)

(
~k.stop;
~k = Pbind(
    \instrument, \samplerStereoLPF,
    \dur, Pseq(1!2 ++ (0.75!4) ++ (0.25!4) * 0.5, inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, Pseq([~kicks[16]], inf),
    \lpf, 500,
    \amp, 0.0625 * 2
).play(~nT, quant: 2);
)

(0.75!4).sum
(0.75!4 ++ (0.25!4) ++ [1]).sum



(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0.1), {
~drone.free;
~drone = {
    | trigGate = 1|
    var tr = ~tks.(1, trigGate);
    var dd = tr[1];
    var t = (tr[0]) * dd;
    var mel = Demand.kr(t, 0, Dseq([0, 2, 3, 5, 6, 5, 6, 5], inf));
    var tim = Demand.kr(t, 0, Dseq([0.63, 0.3].stutter(16), inf));
    var sig = MiBraids.ar(~toMidi.("Ab2") - 6 + mel,
        timbre: 0.63,
        color: 0.75,
        model: 6
    );
    ~v.(sig, 1000) * 0.1 ! 2 * tr[1].lag(0.025);
}.play;
});
)


(
if(~drone2.isPlaying, {~drone2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
~drone2 = {
    | trigGate = 1|
    var tr = ~tks.(1, trigGate);
    var dd = tr[1];
    var t = (tr[0]) * dd;
    var mel = Demand.kr(t, 0, Dseq([0, 2, 3, 5, 6, 5, 6].scramble, inf));
    var tim = Demand.kr(t, 0, Dseq([0.63, 0.3].stutter(16), inf));
    var sig = MiBraids.ar(~toMidi.("Ab4") - 6 + mel,
        timbre: 0.3,
        color: 0.75,
        model: 6
    );
    ~v.(sig, 3000, 0, 5) * 0.5 ! 2;
}.play().register;
)

    var e = EnvGen.kr(Env([0, 1, 0], [0.05, 1.5 * 2], [-1, -6, 'lin']), ve);


(
if(~drone3.isPlaying, {~drone3.set(\trigGate, 0, \gate, 0, \fadeTime, 1.1)});
~drone3 = {
    | trigGate = 1|
    var tr = ~tks.(1, trigGate);
    var dd = tr[1];
    var t = (tr[0]) * dd;
    var mel = Demand.kr(t, 0, Dseq([0, 2, 3, 5, 6, 5, 6].scramble, inf));
    var tim = Demand.kr(t, 0, Dseq([0.63, 0.3].stutter(16), inf));
    var sig = MiBraids.ar(~toMidi.("Ab3") - 6 + mel.lag(0.1),
        timbre: 0.3,
        color: 0.75,
        model: 4
    ) * dd.lag(0.025);
    ~v.(sig, 5000, 0, 1) * 0.125 ! 2;
}.play(fadeTime: 0.1).register;
)


// ---------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------


(
if(~drone2.isPlaying, {~drone2.set(\trigGate, 0, \gate, 0, \fadeTime, 1.1)});
~drone2 = {
    | trigGate = 1|
    var tr = ~tks.(1, trigGate);
    var dd = tr[1];
    var t = (tr[0]) * dd;
    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 0.5], [8, -2, 'lin']), t);
    var mel = Demand.kr(t, 0, Dseq([0, 2, 3, 5, 6, 5, 6].scramble, inf));
    var tim = Demand.kr(t, 0, Dseq([0.63, 0.3].stutter(16), inf));
    var sig = MiBraids.ar(~toMidi.("Ab2") - 6 + mel,
        timbre: 0.3 * e,
        color: 0.75 * e,
        model: 6
    );
    sig = ~v.(sig, 9000 * e + 10);
    ~v.(sig, 100, 0, 5) * 0.25 ! 2;
}.play().register;
)




(
if(~bas.isPlaying, {~bas.set(\trigGate, 0, \gate, 0, \fadeTime, 1.1)});
~bas = {
    | trigGate = 1|
    var tr = ~tks.(1, trigGate);
    var dd = tr[1];
    var t = (tr[0]) * dd;
    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 0.5], [8, -2, 'lin']), t);
    var mel = Demand.kr(t, 0, Dseq([0, 2, 3, 5, 6, 5, 6].scramble, inf));
    var tim = Demand.kr(t, 0, Dseq([0.63, 0.3].stutter(16), inf));
    var sig = MiBraids.ar(~toMidi.("Ab1") - 6 + mel,
        timbre: 0.3 * e,
        color: 0.75 * e,
        model: 6
    );
    sig = ~v.(sig, 1000 * e + 10);
    sig * 0.25 ! 2;
}.play().register;
)


(
if(~bas.isPlaying, {~bas.set(\trigGate, 0, \gate, 0, \fadeTime, 1.1)});
~bas = {
    | trigGate = 1|
    var tr = ~tks.(1, trigGate);
    var dd = tr[1];
    var t = (tr[0]) * dd;
    var t0 = Demand.kr(t, 0, Dseq([1, 0], inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 0.75], [8, -2, 'lin']), t0).lag(0.3);
    var mel = Demand.kr(t, 0, Dseq([0, 2, 3, 5, 6, 5, 6].scramble, inf));
    var tim = Demand.kr(t, 0, Dseq([0.63, 0.3].stutter(16), inf));
    var sig = MiBraids.ar(~toMidi.("Ab1") - 6 + mel,
        timbre: 0.3 * e,
        color: 0.75 * e + 0.2,
        model: 3
    );
    sig = ~v.(sig, 1000 * e + 100) * dd.lag(0.25);
    sig * 0.125 ! 2;
}.play().register;
)


// ---------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------


(
~nT.schedAbs(~nT.nextBar + 0.5, {
    y.free;
    y = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.125 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([6, 5, 3, 2].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 0.5, 0], [6, 24], [-8, -8]), gate: t).lag(1);
        // var note = 48 + [0, 1, 2, 3,0 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.1, inf));
        var note = 26 + 24 + d + 12 + (((0..6) * 2) * 0.05 * e);
        var lfo = SinOsc.kr(6).unipolar;
        var sig = MiBraids.ar(
            pitch: note ++ (note + (shift * e))  ++ (note + (shift + 1 * e)) + (lfo * (e*0.5)) - 0,
            timbre: (0..20).size * 0.025, color: 0.125, model: 21,
            resamp: 2, decim: 12 * e, bits: 2, ws: 0.5
        );
        // 20 * 0.025;
        // sig.size.poll;
        // sig = [sig[0].sum, sig[1].sum];
        sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
        sig = DelayN.ar(sig, 4, (1..21).scramble / 20);
        sig = Splay.ar(sig.scramble);
        sig = sig * Line.kr(0, 1, 1);
        sig = VadimFilter.ar(sig, 1000, 0, 5);
        // sig = MiVerb.ar(sig, time: 0.8, drywet: 1);
        sig = VadimFilter.ar(sig, 3000, 0, 1);
        Out.ar(0, sig * 4 * 4);
    }.play;
});
)


// Clusters aigüs
(
~nT.schedAbs(~nT.nextBar + 0.5, {
    y.free;
    y = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.125 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([6, 5].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 0.5, 0], [6, 24], [-8, -8]), gate: t).lag(1);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.1, inf));
        var note = 26 + 12 + d + 12 + (((0..6) * 2) * 0.05 * e);
        var lfo = SinOsc.kr(6).unipolar;
        var sig = MiBraids.ar(
            pitch: note ++ (note + (shift * e))  ++ (note + (shift + 1 * e)) + (lfo * (e*0.5)) - 0,
            timbre: (0..20).size * 0.025, color: 0.125, model: 21,
            resamp: 2, decim: 12 * e, bits: 2, ws: 0.5
        );
    var timb = Demand.kr(t, 0, Dwhite(0.00, 1.00, inf));
            var algo = 2;
        // 20 * 0.025;
        // sig.size.poll;
        // sig = [sig[0].sum, sig[1].sum];
        sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
        sig = DelayN.ar(sig, 4, (1..21).scramble / 20);
        sig = Splay.ar(sig.scramble);
        sig = sig * Line.kr(0, 1, 1) * 0.2;
        timb = 0.85;
    sig[0] = MiWarps.ar(sig[0],
        sig[0], 0.9, 0.95, algo: algo, timb: timb)[0];
    sig[1] = MiWarps.ar(sig[1],
        sig[1], 0.9, 0.95, algo: algo, timb: timb)[0];
        sig = sig * EnvGen.kr(Env([0,0,1], [0.009,0.05]));
        sig = VadimFilter.ar(sig, 1000, 0, 5);
        sig = VadimFilter.ar(sig, 3000, 0, 1);
        Out.ar(0, sig *16);
    }.play;
});
)


(
l.free;
l = {
        | trigGate = 1|
        var tr = ~tks.(1, trigGate);
        var dd = tr[1];
        var t = (tr[0]) * dd;
        var trig = t;
    var safeEnv = EnvGen.kr(Env([0,0,1], [0.009,0.001]));
    var sig = MiBraids.ar(27+0, 0.5, ~lfo.([3,3.1],0.5,0.55), model: 14);
    ~v.(sig,200) * 0.1 * Line.kr(0,1,0.125) * safeEnv * dd.lag(0.1);
}.play;
)


(
~nT.schedAbs(~nT.nextBar + 0.5, {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.125 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([6, 5].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 0.5, 0], [6, 24], [-8, -8]), gate: t).lag(1);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.1, inf));
        var note = 26 + 12 + d + 0 + (((0..6) * 2) * 0.05 * e);
        var lfo = SinOsc.kr(6).unipolar;
        var sig = MiBraids.ar(
            pitch: note ++ (note + (shift * e))  ++ (note + (shift + 1 * e)) + (lfo * (e*0.5)) - 0,
            timbre: (0..20).size * 0.025, color: 0.125, model: 21,
            resamp: 0, decim: 12 * e, bits: 2, ws: 0.5
        );
    var timb = Demand.kr(t, 0, Dwhite(0.00, 1.00, inf));
            var algo = 2;
        // 20 * 0.025;
        // sig.size.poll;
        // sig = [sig[0].sum, sig[1].sum];
        sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
        sig = DelayN.ar(sig, 4, (1..21).scramble / 20);
        sig = Splay.ar(sig.scramble);
        sig = sig * Line.kr(0, 1, 3) * 0.2;
        timb = 0.85;
    sig[0] = MiWarps.ar(sig[0],
        sig[0], 0.9, 0.95, algo: algo, timb: timb)[0];
    sig[1] = MiWarps.ar(sig[1],
        sig[1], 0.9, 0.95, algo: algo, timb: timb)[0];
        sig = sig * EnvGen.kr(Env([0,0,1], [0.009,0.05]));
        // sig = VadimFilter.ar(sig, 1000, 0, 5);
        sig = VadimFilter.ar(sig, 3000, 0, 1) * 0.25 * Line.kr(0, 1, 3);
        Out.ar(0, sig *1);
    }.play;
});
)


// ---------------------------------------------------------------------------------
// ----hiss-------------------------------------------------------------------------
// ---------------------------------------------------------------------------------

(
~hiss.free;
~hiss = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[1] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([0, 0, 1, 0], inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 2], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("B2") + -5 + 12;
    var sig = MiBraids.ar(pitch + [0, 0.1] + 0,
        timbre: SinOsc.kr(~nT.tempo * 0.25).unipolar * 0.2, color: 0.5, model: 1
    ) * 0.4;
    sig = MiRings.ar(0, t, pit: pitch - 24 - 5 + -12 - 12,
        struct: 0.5, bright: 0.75, damp: 0.65, pos: 0.275,
        model: 4, easteregg: 1, poly: 1, intern_exciter: 1);
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig, 3000 * env.lag(0.01) + 100, 0, 5) * 8;
    sig = ~v.(sig, 2000, 0, 5) * env;
    // sig = (ri) + (sig * ri * 0);
    sig * 0.25 * dd.lag(0.1);
}.play;
)


(
e.free;
e = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[0] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0], inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("B2") + -5 + 12;
    var sig = MiRings.ar(0, t, pit: pitch - 24 - 5 + -12 - 12,
        struct: 0.125, bright: 0.275, damp: 0.65, pos: 0.275,
        model: 4, easteregg: 1, poly: 1, intern_exciter: 1);
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig, 3000 * env.lag(0.1) + 200, 0, 5) * 8;
    // sig = (ri) + (sig * ri * 0);
    sig * 0.5 * dd.lag(0.1);
}.play;
)


(
~hiss.free;
~hiss = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[1] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([0, 0, 1, 0], inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 3], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("B2") + -5 + 12;
    var sig = MiBraids.ar(pitch + [0, 0.1] + 0,
        timbre: SinOsc.kr(~nT.tempo * 0.25).unipolar * 0.2, color: 0.5, model: 1
    ) * 0.4;
    sig = MiRings.ar(0, t, pit: pitch - 24 - 5 + -12 - 12,
        struct: 0.75, bright: 0.275, damp: 0.165, pos: 0.275,
        model: 4, easteregg: 1, poly: 1, intern_exciter: 1);
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig, 3000 * env.lag(0.01) + 100, 0, 5) * 8;
    sig = ~v.(sig, 100, 0, 5) * env;
    // sig = (ri) + (sig * ri * 0);
    sig * 1 * dd.lag(0.1);
}.play;
)