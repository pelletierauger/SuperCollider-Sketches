[~noLowB, n, v, w, z].do({|i| i.set(\gate, 0, \fadeTime, 30)});

(
var time = 6.5;
var freqLPF = 2000;
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
    sig = LPF.ar(sig, freqLPF);
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
    sig = LPF.ar(sig, freqLPF * 2);
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
    sig = LPF.ar(sig, freqLPF);
}.play;
)





(
var time = 6.5;
var freqLPF = 2000;
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
    sig = LPF.ar(sig, freqLPF);
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
    sig = LPF.ar(sig, freqLPF);
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
    sig = LPF.ar(sig, freqLPF);
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
    sig = sig[0]!2 * 0.03625 * 2;
    sig = LPF.ar(sig, freqLPF);
}.play;
)
