// Hats très hauts
(
v.free;
v = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = ~div8.(tr[1]) * dd;
    var b = t * Demand.kr(t, 0, Dseq([1], inf));
    var m = Demand.kr(t, 0, Dseq([0.75, 0.94].stutter(8), inf));
    var m2 = Demand.kr(t, 0, Dseq([0, 24].stutter(4), inf));
    var e = EnvGen.kr(Env.new([0, 1, 0], [0.001, 0.5], ['lin', -8]), gate: t);
    var sig = MiPlaits.ar(
        pitch: 40 + 7 + -0,    engine: 15,
        harm: 0.25,      timbre: 0.85,     morph: 0.5,
        trigger: t,   level: t.lag(0.2) * 1,
        fm_mod: 0,    timb_mod: 0,     morph_mod: 0,
        decay: 0.5,   lpg_colour: 0
    )[0];
    // sig = sig * 0.125 + ;
    sig = MiWarps.ar(sig,
        sig, 0.9, 0.75, algo:4, timb: m)[0];
    sig = MiWarps.ar(sig,
        sig, 0.9, 0.75, algo:4, timb: m)[0];
    sig = MiWarps.ar(sig,
        sig, 0.9, 0.75, algo:4, timb: m)[0];
    // sig = K2A.ar(Impulse.kr(8)!2);
    // sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    // sig = sig + ([sig[1], sig[0]] * 0.25);
    sig = ~v.(sig, 2000 * e + 1000, 0, 1) * 2;
    sig = sig * 0.3 * 2 ! 2 * Line.kr(0, 1, 1);
}.play(fadeTime: 0);
)


// Hats très hauts
(
v.free;
v = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = ~div8.(tr[1]) * dd;
    var b = t * Demand.kr(t, 0, Dseq([1], inf));
    var m = Demand.kr(t, 0, Dseq([0.75, 0.94].stutter(8), inf));
    var m2 = Demand.kr(t, 0, Dseq([0, 24].stutter(4), inf));
    var e = EnvGen.kr(Env.new([0, 1, 0], [0.001, 0.5], ['lin', -8]), gate: t);
    var sig = MiPlaits.ar(
        pitch: 40 + 7 + 12,    engine: 15,
        harm: 0.25,      timbre: 0.85,     morph: 0.5,
        trigger: t,   level: t.lag(0.2) * 1,
        fm_mod: 0,    timb_mod: 0,     morph_mod: 0,
        decay: 0.5,   lpg_colour: 0
    )[0];
    // sig = sig * 0.125 + ;
    sig = MiWarps.ar(sig,
        sig, 0.9, 0.75, algo:4, timb: m)[0];
    sig = MiWarps.ar(sig,
        sig, 0.9, 0.75, algo:4, timb: m)[0];
    sig = MiWarps.ar(sig,
        sig, 0.9, 0.75, algo:4, timb: m)[0];
    // sig = K2A.ar(Impulse.kr(8)!2);
    // sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    // sig = sig + ([sig[1], sig[0]] * 0.25);
    sig = ~v.(sig, 2000 * e + 1000, 0, 1) * 2;
    sig = sig * 0.3 * 2 ! 2 * Line.kr(0, 1, 0.5);
}.play(fadeTime: 0);
)
v.set(\trigGate, 1);


(
~fffff.stop;
~fffff = Pbind(
    \instrument, \samplerStereo,
    \dur, Prand([2, 1, 0.5, 0.25, 0.25, 0.5, 1, 2 ], inf),
    \buf, FuncStream({
        var coin = [0, 1].choose;
        v.set(\trigGate, coin);
    }),
).play(~nT, quant: 2);
)


(
~pulse.stop;
~pulse = Task {
    {
        var coin = [0, 1].choose;
        v.set(\trigGate, coin);
        [0.5, 0.25, 0.25, 0.5, 0.125].choose.wait;
    }.loop;
}.start(~nT, quant: 2);
)

(
~st = Pseq([1, 0], inf).asStream;
~pulse.stop;
~pulse = Task {
    {
        v.set(\trigGate, ~st.next);
        1.wait;
    }.loop;
}.start(~nT, quant: [2, 0.5]);
)