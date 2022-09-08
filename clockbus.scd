
~nT = TempoClock.new(1.39).permanent_(true);
~nT.tempo = 1.6;
~nT.tempo = 1.8;
~nT.tempo = 1.39;
~nT.tempo;
~cb = Bus.control(s, 2);

Safety(s).disable;
(
SynthDef.new(\tick, {
    arg beat, subd;
    var sig = Impulse.kr(0.01);
    Line.kr(0, 1, 0.1, doneAction: 2);
    Out.kr(~cb, sig * [beat, subd]);
}).add;
)

(
~ticks.stop;
~ticks = Pbind(
    \instrument, \tick,
    \dur, 0.25,
    \beat, Pseq([1, 0, 0, 0], inf),
    \subd, Pseq([1, 1, 1, 1], inf)
).play(~nT, quant: 4);
)



~hearCB.free;
~hearCB = {HPF.ar(K2A.ar(In.kr(~cb, 2)), 7000) * 4}.play;


(
x.free;
x = {
    var t = In.kr(~cb, 2);
    var td = t[0] * Demand.kr(t[0], 0, Dseq([1, 0], inf));
    var sig = MiPlaits.ar(40 - 12, 13, morph: 0.47, trigger: t[0])[1] * 0.1;
    sig = VAKorg35.ar(sig, freq: 1200, res: 0, overdrive: 0.05) * 0.5;
    sig = Sanitize.ar(sig);
    sig!2;
}.play;
)

(
y.free;
y = {
    var t = In.kr(~cb, 2);
    var td = DelayN.kr(t, 1, ~nT.beatDur * 0.5);
    var sig = MiPlaits.ar(60 + 12, 9, trigger: td[0])[0] * 0.1!2;
    sig * 3;
}.play;
)


(
d.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
d = {
    | trigGate = 1|
    var t = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(t[0], 0, Dseq([1]));
    var sig = MiPlaits.ar(20, 15, morph: 0.5, trigger: t[1] * dd)[1] * 0.1!2;
    // sig = VAKorg35.ar(sig, freq: 1200, res: 0, overdrive: 0.05);
    // dd.poll;
    sig * 0.1;
}.play;
)

(
e.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
e = {
    | trigGate = 1|
    var t = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(t[0], 0, Dseq([1]));
    var ddd = Demand.kr(t[1] * dd, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0], inf));
    var sig = MiPlaits.ar(0, 15, morph: 0.85, trigger: ddd)[1] * 0.1!2;
    sig = VAKorg35.ar(sig, freq: 1200, res: 0, overdrive: 0.05);
    // dd.poll;
    sig * 0.1;
}.play;
)


(
v.free;
v = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1], inf));
    var m = Demand.kr(t, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(t, 0, Dseq([0.5, 0.1], inf));
    var sig = MiPlaits.ar(
        pitch: 40 + 7,    engine: 15,
        harm: m,      timbre: 0.85,     morph: m,
        trigger: t,   level: t.lag(0.1) * m2 * 2,
        fm_mod: 0,    timb_mod: 0,     morph_mod: 0,
        decay: 0.5,   lpg_colour: 0
    )[0];
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);
    sig = sig * 0.1 * 0.5;
}.play(fadeTime: 0);
)



(
u.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
u = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq(
        // [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0] ++
        [1, 0, 0, 1, 0, 0, 1, 0] ++ [1] ++ (0!7), inf));
    var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0], inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
    var level = b.lag(0.1) * m2 * 2 + (b * 0);
    var sig = MiPlaits.ar(
        pitch: 40 + 12 + 12,    engine: 10,
        harm: 1,                timbre: 1,             morph: 0,
        trigger: b,             level: level,
        fm_mod: 1,              timb_mod: 1,           morph_mod: -0.5,
        decay: 0.65,            lpg_colour: 0.25
    )[0];
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 0.4 * 2 * 2;
    sig = VadimFilter.ar(sig, 50, 0, 5);
}.play(fadeTime: 0);
)


(
w.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
w = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    // var b = t * Demand.kr(t, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0] ++ [1] ++ (0!7), inf));
    var b = t * Demand.kr(t, 0, Dseq(
        [1, 0, 0, 1, 0, 0, 1, 0] ++ [0, 0, 1, 0, 0, 0, 1, 0]
        , inf));
    var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0, 0], inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
    var level = b.lag(0.1) * m2 * 12 + (b * 4);
    var sig = MiPlaits.ar(
        pitch: 60 - 12 - 0, engine: 9,
        harm: m,            timbre: 1,               morph: morph,
        trigger: b,         level: level * level,
        fm_mod: 0,          timb_mod: 0,             morph_mod: -0.5,
        decay: 0.65,        lpg_colour: 0.25
    )[1];
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 0.4 * 1;
    sig = VadimFilter.ar(sig, 50, 0, 5);
}.play(fadeTime: 0);
)





(
[~noLowB].do({|i| i.set(\gate, 0, \fadeTime, 1)});
~noLowB = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var trig = tr[0] * dd;
    var block = Demand.kr(trig, 0, Dseq([1] ++ (0!7), inf));
    var notes = Demand.kr(trig, 0,
        Dseq(32 + [0] + 0, inf)
    );
    var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
    var dem2 = Demand.kr(trig * block, 0, Dseq([0, 0], inf));
    var pitch = Demand.kr(trig * block, 0, Dseq([0, -5].stutter(2), inf));
    var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
    var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
    var lfo3 = SinOsc.kr(1).range(0, 2000);
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
    var sig = MiBraids.ar(
        pitch: 24 + 7 - 12 + 7 + pitch - 2,
        timbre: 0.25,
        color: 0.0 + [0, 0.01],
        model: 0,
        resamp: 2,
        decim: 32,
        bits: 16,
        ws: 0
    );
    sig = sig * 0.6;
    sig = MiRings.ar(sig,
        pit: 36 + 2 + 7 + 2 - 2 - 24 * [1, 1.005],
        struct: 0.5,
        bright: 0.5,
        // pos: 0,
        model: 4
    ) * 0.4;
    [sig[1], sig[0] * 4] * 0.75 * 1 * dd.lag(0.1);
}.play(fadeTime: 0.1);
)




(
[~noLow].do({|i| i.set(\gate, 0, \fadeTime, 1)});
~noLow = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var trig = tr[0] * dd;
    var block = Demand.kr(trig, 0, Dseq([1, 0, 0, 0].wrapExtend(16), inf));
    var notes = Demand.kr(trig, 0,
        Dseq(32 + [0] + 0, inf)
    );
    var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
    var dem2 = Demand.kr(trig * block, 0, Dseq([0.2, 0.9], inf));
    var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
    var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
    var lfo3 = SinOsc.kr(1).range(0, 2000);
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
    var sig = MiBraids.ar(
        pitch: 2,
        timbre: dem2.lag(0.5) * 0.5,
        color: 0.0 + dem2.lag(0.5) + [0, 0.01],
        model: 1,
        resamp: 2,
        decim: 2,
        bits: 3,
        ws: 0.75
    );
    // sig = VadimFilter.ar(sig, 4000, 0, 1);
    sig = VadimFilter.ar(sig, 2300, 0, 5) * 4;
    sig = VAKorg35.ar(sig, freq: 5000, res: 0, overdrive: 0.5);
    // sig.reverse * 0.02 * dd.lag(0.1);
    sig.reverse * 0.02 * dd.lag(0.1) * K2A.ar(tr[1]!2 + (tr[0]!2*4)).lag(1) * 32;
}.play(fadeTime: 0.1);
)