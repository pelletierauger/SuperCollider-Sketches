~nT = TempoClock.new(1.6).permanent_(true);
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

// --------------------------------------------------------------------------------

(
~k.set(\trigGate, 0, \gate, 0, \fadeTime, 0.01);
~k = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq(
        // [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0] ++
        ([1, 0, 0, 1, 0, 0, 1, 0] ++ [1] ++ (0!3) ++ [1] ++ (0!3)).rotate(8), inf));
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
        trigger: b,          level: level.lag(0.05) * 2 * 1,
        fm_mod: 0,           timb_mod: -0.5,                     morph_mod: 0.5,
        // decay: dec,          lpg_colour: levv.lag(0.4) * 0.5 + 0.5
   )[1];
   var dee = Demand.kr(b, 0, Dseq([0.04, 0.24, 0.24, 0.14, 0.14], inf));
    sig = sig * 1 + (MiWarps.ar(sig, PinkNoise.ar() * sig, 0.5, 0.5, algo: 2, timb: 0.4)[0] * e);
    sig = VadimFilter.ar(sig, 8000, 0, 1);
    // MouseX.kr().poll;
    // MouseY.kr().poll;
    // sig = [sig, DelayC.ar(sig, 0.5, 0.005)];
    // sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 2 * 1!2;
    // sig = VadimFilter.ar(sig, 50, 0, 5);
}.play(fadeTime: 0);
)




(
o.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
o = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var t2 = t * Demand.kr(t, 0, Dseq([1], inf));
    var b = t2 * Demand.kr(t, 0, Dseq(
        // [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0] ++
        ([1, 0, 0, 1, 0, 0, 1, 0] ++ [1] ++ (0!3) ++ [1] ++ (0!3)).rotate(8), inf));
    var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0, 1].rotate(1), inf));
    var levv = Demand.kr(b, 0, Dseq([0.25, 0, 0, 0, 0.35].rotate(1), inf));
    var dec = Demand.kr(b, 0, Dseq([0.8, 0.6, 0.6, 0.6, 0.8].rotate(1), inf));
    var a = Demand.kr(b, 0, Dseq([1, 1, 1] * 0.5, inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
    var rr = Demand.kr(b, 0, Dwhite());
    var level = b.lag(0.1) * m2 * 2 + (b * 0);
    var sig = MiPlaits.ar(
        pitch: 40 - 12 + -12 + 24,    engine: 10,
        harm: rr * 0.5,                timbre: rr,             morph: 0.15,
        trigger: b,             level: level.lag(0.1),
        fm_mod: 0.5 * a,              timb_mod: 1 * a,           morph_mod: 0.5 * a,
        decay: dec + -0.5,            lpg_colour: levv.lag(0.4) * 0.5
   )[0];
    var disto;
     sig = [sig, DelayC.ar(sig, 0.5, 0.01)];
    sig = sig + ([sig[1], sig[0]] * 0.5);
            disto = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;
        disto = AnalogVintageDistortion.ar(
            input: disto,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;
            disto = AnalogVintageDistortion.ar(
            input: disto,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;
    // sig = sig * 0.4 * 2 * 2 * 2;
    sig = disto * 0.05 * DelayC.ar(disto * 0.05, 1, 0.005) * 32 * 2;
    sig = VadimFilter.ar(sig, 1550, 0, 5) * 16 * 4;
    MiRings.ar(sig, pit: 40 - 12, struct: 0.25, damp: SinOsc.kr(1).unipolar, bright: 0.2, pos: 0.125, model: 1) * 16;
}.play(fadeTime: 0);
)




// L’interférence

(
// 3:SINE_TRIANGLE
// ~toMidi.("F3")
var f = ~toMidi.("E3");
~drone.free;
~drone = {
    var lfo = SinOsc.kr(0.1 * 2).range(0.025, 0.125);
    var lfo2 = SinOsc.kr(0.2 * 2, pi).range(0.025, 0.65);
    var model = 16;
    var sig = MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f - 5 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.1);
    sig = sig + MiBraids.ar(f + 3 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    sig = sig + MiBraids.ar(f + 1 * [1, 1.001], lfo, lfo2, model, resamp: 0, decim: 2, ws: 0.6, mul: 0.025);
    sig = VadimFilter.ar(sig, 1000, 0, 3) * 1.6 * Line.kr(0, 1, 10);
    // sig = sig + MiBraids.ar(f - 24 * [1, 1.001], lfo, lfo2, 3, resamp: 2, decim: 16, ws: 0.6, mul: 0.025);
    // MiVerb.ar(sig, time: 0.7, amount: 0.25, diff: 0.7, damp: 0.9) * 0.75 * XLine.kr(0.001, 1, 3);
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
        sig = DCompressor.ar(
        input: sig,          sidechainIn: 0,        sidechain: 0,
        ratio: 4,            threshold: -10,        attack: 0.1,
        release: 100.1,      makeup: 0.5,           automakeup: 1
    );
    sig = sig * 0.1 * 2;
}.play(fadeTime: 0);
)



// Hats hauts

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
        fm_mod: 0,    timb_mod: 0.95,     morph_mod: 0,
        decay: 0.5,   lpg_colour: 0.9
    )[1];
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


// Clusters aigüs
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
        var note = 26 + 24 + d + 24 + (((0..6) * 2) * 0.05 * e);
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

// Clusters mid et chancelants

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
        var note = 26 + 24 + d + 24 + (((0..6) * 2) * 0.05 * e);
        var lfo = SinOsc.kr(6).unipolar;
        var sig = MiBraids.ar(
            pitch: note ++ (note + (shift * e))  ++ (note + (shift + 1 * e)) + (lfo * (e*0.5)) - 12,
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
        sig = VadimFilter.ar(sig, SinOsc.kr(~nT.tempo * 2 * 2).unipolar * 2000 + 1000, 0, 1);
        Out.ar(0, sig * 4 * 4);
    }.play;
});
)


// Kick détendu

(
~k.set(\trigGate, 0, \gate, 0, \fadeTime, 0.01);
~k = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq(
        // [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0] ++
        [1, 0, 0, 0, 0, 0, 0, 0] ++ [1, 0, 0, 0, 0, 0, 0, 0], inf));
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
        trigger: b,          level: level.lag(0.05) * 2 * 1,
        fm_mod: 0,           timb_mod: -0.5,                     morph_mod: 0.5,
        // decay: dec,          lpg_colour: levv.lag(0.4) * 0.5 + 0.5
   )[1];
   var dee = Demand.kr(b, 0, Dseq([0.04, 0.24, 0.24, 0.14, 0.14], inf));
    sig = sig * 1 + (MiWarps.ar(sig, PinkNoise.ar() * sig, 0.5, 0.5, algo: 2, timb: 0.4)[0] * e);
    sig = VadimFilter.ar(sig, 8000, 0, 1);
    // MouseX.kr().poll;
    // MouseY.kr().poll;
    // sig = [sig, DelayC.ar(sig, 0.5, 0.005)];
    // sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 2 * 1!2;
    // sig = VadimFilter.ar(sig, 50, 0, 5);
}.play(fadeTime: 0);
)



// Drums tendres mais lourds et lointains

(
n.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
n = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq(
        // [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0] ++
        ([1, 0, 0, 1, 0, 0, 1, 0] ++ [1] ++ (0!3) ++ [1] ++ (0!3)).rotate(8), inf));
    var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0, 1].rotate(1), inf));
    var levv = Demand.kr(b, 0, Dseq([0.25, 0, 0, 0, 0.35].rotate(1), inf));
    var dec = Demand.kr(b, 0, Dseq([0.8, 0.6, 0.6, 0.6, 0.8].rotate(1), inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
    var level = b.lag(0.1) * m2 * 2 + (b * 0);
    var sig = MiPlaits.ar(
        pitch: 40,                 engine: 10,
        harm: 0.95,                timbre: 0.25,                 morph: 0,
        trigger: b,                level: level.lag(0.05),
        fm_mod: SinOsc.kr(3),      timb_mod: 0,                  morph_mod: -0.5,
        decay: dec,                lpg_colour: levv.lag(0.4) * 0.5 + 0.5
   )[0];
     sig = [sig, DelayC.ar(sig, 0.5, 0.01)];
    sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 0.4 * 2 * 2;
    sig = VadimFilter.ar(sig, 50, 0, 5) * 4;
}.play(fadeTime: 0);
)