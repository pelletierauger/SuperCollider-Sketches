(
~nT = TempoClock.new(1.39).permanent_(true);
~cb = Bus.control(s, 2);
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



// Hats qui hésitent
(
v.free;
v = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1], inf) * Dwrand([1, 0], [0.9, 0.1], inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.1], inf));
    var sig = MiPlaits.ar(
        pitch: 40 + 7 + 12,    engine: 15,
        harm: m,      timbre: 0.85,     morph: m,
        trigger: b,   level: b.lag(0.1) * m2 * 2,
        fm_mod: 0,    timb_mod: 0,     morph_mod: 0,
        decay: 0.5,   lpg_colour: 0
    )[0];
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);
        sig = DCompressor.ar(
        input: sig,          sidechainIn: 0,        sidechain: 0,
        ratio: 4,            threshold: -10,        attack: 0.1,
        release: 100.1,      makeup: 0.5,           automakeup: 1
    );
    sig = sig * 0.1 * 2;
}.play(fadeTime: 0);
)



// Rouille constante
(
~hearCB.free;
~hearCB = {
    var sig = K2A.ar(In.kr(~cb, 2)) * 1;
    sig = sig[0] + sig[1] * 1!2;
    sig = VadimFilter.ar(sig, 2000, 0, 5) * 4;
    MiRings.ar(sig, pit: 40 + 0, struct: 1, damp: 0.7, pos: 0.05, model: 2) * 4;
}.play;
)

// Kick boueux
(
~k.set(\trigGate, 0, \gate, 0, \fadeTime, 0.01);
~k = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq(
        // [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0] ++
        [1, 0, 0, 0, 1, 0, 0, 0] ++ [1, 0, 0, 0, 1, 0, 0, 0] ++
        [1, 0, 0, 0, 1, 0, 0, 0] ++ [1, 0, 1, 0, 0, 0, 0, 0], inf));
    var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0, 1].rotate(1), inf));
    var levv = Demand.kr(b, 0, Dseq([0.25, 0, 0, 0, 0.35].rotate(1), inf));
    var dec = Demand.kr(b, 0, Dseq([0.8, 0.6, 0.6, 0.6, 0.8].rotate(1), inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1], -8), b);
    var level = b.lag(0.5) * m2 * 2 + (b * 0);
    var sig = MiPlaits.ar(
        pitch: 36 - 24 + 12,      engine: 13,
        harm: 0.95,          timbre: 0.503,                        morph: 0.95,
        trigger: b,          level: level.lag(0.05) * 2 * 0,
        fm_mod: 0,           timb_mod: -0.5,                     morph_mod: 0.5,
        // decay: dec,          lpg_colour: levv.lag(0.4) * 0.5 + 0.5
   )[1];
   var dee = Demand.kr(b, 0, Dseq([0.04, 0.24, 0.24, 0.14, 0.14], inf));
    sig = sig * 1 + (MiWarps.ar(sig, PinkNoise.ar() * sig, 0.5, 0.5, algo: 4, timb: 0.4)[0] * e);
    sig = VadimFilter.ar(sig, 8000, 0, 1);
    // MouseX.kr().poll;
    // MouseY.kr().poll;
    // sig = [sig, DelayC.ar(sig, 0.5, 0.005)];
    // sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 1 * 1!2;
    // sig = VadimFilter.ar(sig, 50, 0, 5);
}.play(fadeTime: 0);
)


// Snare gluant
(
y.free;
y = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[0] * dd;
    // var d = Demand.kr(t, 0, Dseq([0, 1], inf));
    // var t = Impulse.kr(2 * 2.2);
    var x = MouseX.kr(0.01, 1);
    var y = MouseX.kr(0.01, 1);
    var d = Demand.kr(t, 0, Dseq([0, 1], inf)) * t;
    var sig = AnalogSnareDrum.ar(
        trig: d,
        accent: 0.75,
        freq: 40 + 36,
        tone: 0.0,
        decay: 0.75,
        snappy: 0.75
        // attackfm: 0,
        // selffm: 0.55
    ) * 8;
    var wet = 1;
    // var level = d.lag(0.5) * 2;
    var e = EnvGen.kr(Env([0, 1, 0], [0.005, 2], -8), d);
    sig = (sig * (1 - wet)) + (Compander.ar(
        in: sig * 4,
        control: sig * 4,
        thresh: 1,
        slopeBelow: 1.5,
        slopeAbove: 0.75,
        clampTime:  0.01,
        relaxTime:  0.02
    ) * wet);
    sig = sig * 1 + (MiWarps.ar(sig, PinkNoise.ar() * sig, 0.5, 0.5, algo: 2, timb: 0.9)[0]);
    // sig = VadimFilter.ar(sig, 500 + 10, 0, 1);
    sig = sig * 0.02!2;
}.play(fadeTime: 0.0);
)


// Clusters aigüs
(
~nT.schedAbs(~nT.nextBar + 0.5, {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 3, 6, 3].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [6, 24], [-8, -8]), gate: t).lag(1);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.1, inf));
        var note = 24 + 24 + d + 24 + (((0..6) * 2) * 0.05 * e);
        var sig = MiBraids.ar(
            pitch: note ++ (note + (shift * e))  ++ (note + (shift + 1 * e)),
            timbre: (0..20).size * 0.025, color: 0.5, model: 21
        );
        // 20 * 0.025;
        // sig.size.poll;
        // sig = [sig[0].sum, sig[1].sum];
        sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
        sig = DelayN.ar(sig, 4, (1..21).scramble / 20);
        sig = Splay.ar(sig.scramble);
        sig = sig * Line.kr(0, 1, 1);
        sig = VadimFilter.ar(sig, 1000, 0, 5);
        Out.ar(0, sig * 4 * 1);
    }.play;
});
)
