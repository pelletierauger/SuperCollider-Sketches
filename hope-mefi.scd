~nT = TempoClock.new(1.39 * 1 * 1.05).permanent_(true);

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    ~x3b.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~x3bbb.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);

    if(~toms.isPlaying, {~toms.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~toms = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 2);
        var trig2 = Impulse.kr(~nT.tempo * 4);
        var pat0 = [1, 0, 0, 1, 0, 0, 1, 0];
        var pat1 = [0, 1, 0, 0, 1, 0, 0, 0];
        var pat2 = [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var hh = Demand.kr(trig * block2, 0, Dseq([0.9, 1.1], inf));
        var scr = Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf));
        var sig = MiPlaits.ar(
            pitch: 27 + [0, 12, 12, 24] + 12,
            engine: 8,
            harm: [0.25, 0.4, 0.4, 0.25],
            timbre: [1, 1, 1, 1],
            morph: 0.75 - [0, 0.2, 0, -0.1],
            trigger: (trig!3)++(trig2!1) * [block0, block1, block1, block2] * trigGate,
            decay: [0.9, 0.6, 0.6, hh] * 0.5,
            lpg_colour: [0.75, 0.75, 0.75, 1] - 0.75,
            // fm_mod: -0.5,
            // timb_mod: 0.5
            // morph_mod: -1
        );
        var dd = Demand.kr(trig, 0, Dseq([2, 1].stutter(16), inf));
        var ddd = Demand.kr(trig, 0, Dseq([8000, 5000].stutter(16), inf));
        var v = 1;
        var sig3;
        var sig2 = [sig[1][v], sig[2][v]] * 4.5 * Line.kr(0, 1, ~nT.beatDur * 2);
        sig = [sig[0][v] * 2 + (sig[3][v] * 0.15)]!2 + sig2;

        sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        sig3 = [sig2, sig3] * 0.5;
        sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500) - 400, 0, 5) * 8;
        // sig = sig + (sig3 * Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf)).lag(1));
        sig * 2;
    }.play(fadeTime: 0.01).register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
v.free;
v = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 2);
    var m = Demand.kr(t, 0, Dseq([0.35, 0.4] + 0.0, inf));
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
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
~hatsAccents.free;
~hatsAccents = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 2);
    var b0 = Demand.kr(t, 0, Drand([1, 0], inf));
    var b1 = Demand.kr(t, 0, Dwrand([1, 0], [0.8, 0.2], inf));
    var b = t * Demand.kr(t, 0, Dseq([b1, b0], inf));
    var m = Demand.kr(t, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(t, 0, Dseq([0.5, 0.1], inf));
    var sig = MiPlaits.ar(
        pitch: 40 + 7 + 0,    engine: 15,
        harm: m,      timbre: 0.125,     morph: m,
        trigger: b,   level: b.lag(0.1) * m2 * 2,
        fm_mod: 0,    timb_mod: 0.95,     morph_mod: 0.5,
        decay: 0.125 * 0.5,   lpg_colour: 0.9
    )[1];
    sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    sig = sig + ([sig[1], sig[0]] * 0.25);
        sig = DCompressor.ar(
        input: sig,          sidechainIn: 0,        sidechain: 0,
        ratio: 4,            threshold: -10,        attack: 0.1,
        release: 100.1,      makeup: 0.5,           automakeup: 1
    );
    sig = DelayC.ar(sig, 1, ~nT.beatDur * 0.5);
    sig = sig * 0.1 * 2;
}.play(fadeTime: 0);
});
)