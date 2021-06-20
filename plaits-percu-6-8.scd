[~noLowB, n, v, w, z].do({|i| i.set(\gate, 0, \fadeTime, 1)});

(
var time = 6.5;
n.free;
v.free;
v = {
    var trig, sig;
    trig = Impulse.kr(time * 0.25);
    sig = MiPlaits.ar(55 - 24,
        engine: 13,
        harm: 0.5,
        timbre: 0.2,
        morph: 0.5,
        trigger: trig,
        decay: 0.1
    );
    sig = sig[0]!2 * 2;
}.play;
w.free;
w = {
    var trig, sig, dem, morph;
    trig = Impulse.kr(time * 0.25 * 0.5 * 3 * 4);
    dem = Demand.kr(trig, 0, Dseq([1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0], inf));

    trig = trig * dem;
        morph = Demand.kr(trig, 0, Dseq([0, 0, 0.9], inf));
    sig = MiPlaits.ar(55 - 24,
        engine: 14,
        harm: 0.4,
        timbre: 0.2,
        morph: morph,
        trigger: trig
    );
    sig = sig[0]!2 * 0.75;
}.play;
z.free;
z = {
    var trig, sig, morph, dem;
    trig = Impulse.kr(time * 0.25 * 0.5 * 6 * 4);
    morph = Demand.kr(trig, 0, Dseq([0.5, 0.2], inf));
    dem = Demand.kr(trig, 0, Dseq([1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0], inf));
    trig = trig * dem;
    sig = MiPlaits.ar(55 - 24,
        engine: 15,
        harm: morph,
        timbre: 0.6,
        morph: 0.2,
        trigger: trig
    );
    sig = sig[0]!2 * 0.25;
}.play;
)





(
var time = 6.5;
n.free;
n = {
    var trig, sig;
    trig = Impulse.kr(time * 0.25);
    sig = MiPlaits.ar(55 - 24,
        engine: 13,
        harm: 0.5,
        timbre: 0.2,
        morph: 0.5,
        trigger: trig,
        decay: 0.1
    );
    sig = sig[0]!2 * 2;
}.play;
v.free;
v = {
    var trig, sig, dem;
    trig = Impulse.kr(time * 0.25);
        dem = Demand.kr(trig, 0, Dseq([0.5, 0.9], inf));

    sig = MiPlaits.ar(55 - 24,
        engine: 13,
        harm: 0.5,
        timbre: dem,
        morph: dem,
        trigger: trig,
        decay: 0.1
    );
    sig = sig[0]!2 * 1;
}.play;
w.free;
w = {
    var trig, sig, dem, morph;
    trig = Impulse.kr(time * 0.25 * 0.5 * 3 * 4);
    dem = Demand.kr(trig, 0, Dseq([1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0], inf));

    trig = trig * dem;
        morph = Demand.kr(trig, 0, Dseq([0, 0.2, 0.8], inf));
    trig = trig * Demand.kr(trig, 0, Dseq([0, 1, 1], inf));
    sig = MiPlaits.ar(55 - 12,
        engine: 14,
        harm: 0.2,
        timbre: 0.9,
        morph: morph,
        trigger: trig
    );
    sig = sig[0]!2 * 0.75 * 1;
}.play;
z.free;
z = {
    var trig, sig, morph, dem;
    trig = Impulse.kr(time * 0.25 * 0.5 * 6 * 4);
    morph = Demand.kr(trig, 0, Dseq([0.5, 0.0], inf));
    dem = Demand.kr(trig, 0, Dseq([1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0], inf));
    trig = trig * dem;
    sig = MiPlaits.ar(55 - 24 - 24,
        engine: 15,
        harm: morph,
        timbre: 0.6,
        morph: morph + 0.4,
        trigger: trig
    );
    sig = sig[0]!2 * 0.03625;
}.play;
)


// Petits bruits pour accompagner


(
[~noLowB].do({|i| i.set(\gate, 0, \fadeTime, 1)});

// ~t.sched(~t.timeToNextBeat(quant: 1), {
    ~noLowB = {
        var trig = Impulse.ar(1);
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0].wrapExtend(18), inf));
        var notes = Demand.ar(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.ar(trig, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.ar(trig * block, 0, Dseq([0.2, 0.9], inf));
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
            decim: 32,
            bits: 2,
            ws: 0
        );
    sig = LPF.ar(sig, 4000);
    sig = HPF.ar(sig, 300);
        sig * 0.75 * 0.5 * 0.4 * 8 * 0.5;
    }.play(fadeTime: 0.1);
// });
)



(
[~noLow].do({|i| i.set(\gate, 0, \fadeTime, 1)});

// ~t.sched(~t.timeToNextBeat(quant: 1), {
    ~noLow = {
        var trig = Impulse.ar(1);
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0].wrapExtend(18), inf));
        var notes = Demand.ar(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.ar(trig, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.ar(trig * block, 0, Dseq([0.2, 0.9], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 55 - 12,
            timbre: dem2.lag(0.5) * 0.5,
            color: 0.0 + dem2.lag(0.5) + [0, 0.01],
            model: 1,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        );
    // sig = LPF.ar(sig, 4000);
    sig = HPF.ar(sig, 300);
        sig * 0.75 * 0.5 * 0.4 * 4 * 0.5;
    }.play(fadeTime: 0.1);
// });
)
