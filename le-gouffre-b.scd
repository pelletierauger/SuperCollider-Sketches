~nT.tempo = 70 / 60;

//  Le pouls du gouffre
(
e.free;
e = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[0] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0], inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var pitch = ~toMidi.("Db1");
    var sig = MiRings.ar(t, t, pit: pitch,
        struct: 0.125, bright: 0.275, damp: 0.75, pos: 0.275,
        model: 2, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig, 3000 * env.lag(0.1) + 200, 0, 1 );
    sig * 0.5 ! 2 * dd.lag(0.1);
}.play;
)

// Les Hats hauts du gouffre

(
v.free;
v = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1, 0], inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.1], inf));
    var sig = MiPlaits.ar(
        pitch: 20 + 7,    engine: 15,
        harm: m,      timbre: 0.85,     morph: m,
        trigger: b,   level: b.lag(0.1) * m2 * 2,
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


(
v.free;
v = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1], inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.1], inf));
    var sig = MiPlaits.ar(
        pitch: 20 + 7,       engine: 15,
        harm: m,             timbre: 0.85,          morph: m,
        trigger: b,          level: b.lag(0.1) * m2 * 2,
        fm_mod: 0,           timb_mod: 0.95,        morph_mod: 0,
        decay: 0.5,          lpg_colour: 0.9
    )[1];
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);
        sig = DCompressor.ar(
        input: sig,          sidechainIn: 0,        sidechain: 0,
        ratio: 4,            threshold: -10,        attack: 0.1,
        release: 100.1,      makeup: 0.5,           automakeup: 1
    );
    sig = sig * 0.1 *2;
}.play(fadeTime: 0);
)


//  Ce qui vient contredire le pouls du gouffre
(
f.free;
f = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[1] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 0], inf));
    var m = Demand.kr(t, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(t, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 15], ['lin', -8]), gate: t);
    var ri;
    var pitch = ~toMidi.("B4") + -5 + 12;
    var sig = MiRings.ar(t, t, pit: pitch - 0 - 5 + -12 - 12,
        struct: 0.125, bright: 0.5, damp: 0.25, pos: 0.275,
        model: 2, easteregg: 0, poly: 1, intern_exciter: 0);
    // sig = VadimFilter.ar(sig, 100 * env.lag(0.2) + 200, 0, 5);
    // sig = MiMu.ar(sig, 24) * 0.5;
    sig = VadimFilter.ar(sig, 3000 * env.lag(0.1) + 200, 0, 1 ) * 1;
    // sig = (ri) + (sig * ri * 0);
    sig * 0.5 ! 2 * dd.lag(0.1);
}.play;
)


(
z.free;
z = {
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
    sig * 0.125 * dd.lag(0.1);
}.play;
)



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
        var note = 26 + 0 + d + 12 + (((0..6) * 2) * 0.05 * e);
        var lfo = SinOsc.kr(6).unipolar;
        var sig = MiBraids.ar(
            pitch: note ++ (note + (shift * e))  ++ (note + (shift + 1 * e)) + (lfo * (e*0.5)) - 0,
            timbre: (0..20).size * 0.025, color: 0.125, model: 11,
            resamp: 2, decim: 12 * e, bits: 2, ws: 0.5
        );
        // 20 * 0.025;
        // sig.size.poll;
        // sig = [sig[0].sum, sig[1].sum];
        sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
        sig = DelayN.ar(sig, 4, (1..21).scramble / 20);
        sig = Splay.ar(sig.scramble);
        sig = sig * Line.kr(0, 1, 1);
        sig = VadimFilter.ar(sig, 400, 0, 5);
        // sig = MiVerb.ar(sig, time: 0.8, drywet: 1);
        sig = VadimFilter.ar(sig, 1400, 0, 1);
        Out.ar(0, sig * 1 * 1);
    }.play;
});
)


// Les grappes lointaines et troublantes
(
~nT.schedAbs(~nT.nextBar + 0.5, {
    w.free;
    w = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.125 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([6, 5, 3, 2].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 0.5, 0], [6, 24], [-8, -8]), gate: t).lag(1);
        // var note = 48 + [0, 1, 2, 3,0 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.1, inf));
        var note = 26 + 0 + d + 12 + (((0..6) * 2) * 0.05 * e);
        var lfo = SinOsc.kr(6).unipolar;
        var sig = MiBraids.ar(
            pitch: note ++ (note + (shift * e))  ++ (note + (shift + 1 * e)) + (lfo * (e*0.5)) - 0,
            timbre: (0..20).size * 0.025, color: 0.125, model: 6,
            resamp: 2, decim: 12 * e, bits: 2, ws: 0.5
        );
        // 20 * 0.025;
        // sig.size.poll;
        // sig = [sig[0].sum, sig[1].sum];
        sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
        sig = DelayN.ar(sig, 4, (1..21).scramble / 20);
        sig = Splay.ar(sig.scramble);
        sig = sig * Line.kr(0, 1, 1);
        sig = VadimFilter.ar(sig, 400, 0, 5);
        // sig = MiVerb.ar(sig, time: 0.8, drywet: 1);
        sig = VadimFilter.ar(sig, 3400, 0, 1);
        Out.ar(0, sig * 1 * 1);
    }.play;
});
)