(
y.free;
y = {

    var ff = 42;
    var trig = Impulse.ar(1.39 * 0.2);
    var note = Demand.ar(trig, 0, ff + 12 + Dseq([0, -5].stutter(1), inf));
    var sig = MiPlaits.ar(note + [0, 0.1],
        engine: 3,
        harm: 0.25,
        timbre: 0.0,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig,
        decay: 0.1,
        lpg_colour: 0,
        mul: 3);

    var dem2 = Demand.ar(trig, 0, Dseq([0, 0.99], inf));
    var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
    var sig2 = MiBraids.ar(
        pitch: 48!2,
        timbre: 0.5 + lfo,
        color: 0.0 + dem2,
        model: 4,
        resamp: 2,
        decim: 32,
        bits: 6,
        ws: 0
    );
    // sig2 = HPF.ar(sig2, 1000);
    sig2 = sig2 * 0.75 * 0.5 * 1;
    // sig2.poll;

        sig = (sig * 0.15) + MiRings.ar(sig,
        trig: 0,
        pit: note,
        struct: 0.9,
        bright: 0.4,
        damp: 0.65,
        pos: 2,
        bypass: 0);
    sig = sig * 0.25 * (1 - (sig2 * 2));
    // sig2;
}.play;
)
