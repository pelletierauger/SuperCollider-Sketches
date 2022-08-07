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
        model: 8,
        resamp: 2,
        decim: 22,
        bits: 4,
        ws: 0.75
    ) * 2;
    // sig = VadimFilter.ar(sig, 4000, 0, 1);
    sig = VadimFilter.ar(sig, 1300, 0, 5) * 4;
    sig = VAKorg35.ar(sig, freq: 5000, res: 0, overdrive: 0.5);
    // sig.reverse * 0.02 * dd.lag(0.1);
    sig.reverse * 0.02 * dd.lag(0.1) * K2A.ar(tr[1]!2 + DelayN.ar(tr[0]!2*4,1,~nT.beatDur * 0.5)).lag(1) * 32 * 16;
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
    var dem2 = Demand.kr(trig * block, 0, Dseq([0.9, 0.9], inf));
    var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
    var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
    var lfo3 = SinOsc.kr(1).range(0, 2000);
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
    var sig = MiBraids.ar(
        pitch: 2,
        timbre: dem2.lag(0.5) * 0.5,
        color: 0.0 + dem2.lag(0.5) + [0, 0.01],
        model: 8,
        resamp: 2,
        decim: 22,
        bits: 4,
        ws: 0.75
    ) * 2;
    // sig = VadimFilter.ar(sig, 4000, 0, 1);
    sig = VadimFilter.ar(sig, 1300, 0, 5) * 4;
    sig = VAKorg35.ar(sig, freq: 5000, res: 0, overdrive: 0.5);
    // sig.reverse * 0.02 * dd.lag(0.1);
    sig.reverse * 0.02 * dd.lag(0.1) * K2A.ar(tr[1]!2 + DelayN.ar(tr[0]!2*4,1,~nT.beatDur * 0.5)).lag(1) * 32 * 16;
}.play(fadeTime: 0.1);
)


(
~k.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~k = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq(
        // [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0] ++
        ([1, 0, 0, 0, 0,0,0,0]).rotate(0), inf));
    var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0, 1].rotate(1), inf));
    var levv = Demand.kr(b, 0, Dseq([0.25, 0, 0, 0, 0.35].rotate(1), inf));
    var dec = Demand.kr(b, 0, Dseq([0.8, 0.6, 0.6, 0.6, 0.8].rotate(1), inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
    var level = b.lag(0.5) * m2 * 2 + (b * 0);
    var sig = MiPlaits.ar(
        pitch: 40 - 24 + 12,      engine: 13,
        harm: 0.95,          timbre: 0.503,                        morph: 0.75,
        trigger: b,          level: level.lag(0.05) * 2 * 0,
        fm_mod: 0,           timb_mod: -0.5,                     morph_mod: -0.25,
        // decay: dec,          lpg_colour: levv.lag(0.4) * 0.5 + 0.5
   )[0];
    sig = DCompressor.ar(
        input: sig,          sidechainIn: 0,        sidechain: 0,
        ratio: 4,            threshold: -10,        attack: 0.1,
        release: 100.1,      makeup: 0.5,           automakeup: 1
    );
    sig = VadimFilter.ar(sig, 8200 * 0.0714 + 10, 0, 1);
    // MouseX.kr().poll;
    // MouseY.kr().poll;
    sig = [sig, DelayC.ar(sig, 0.5, 0.005)];
    sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 2 * 1;
    // sig = VadimFilter.ar(sig, 50, 0, 5);
}.play(fadeTime: 0);
)