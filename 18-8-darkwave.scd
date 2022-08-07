(
~k.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~k = {
    | trigGate = 1 |
    var f = ~toMidi.("A4");
    var t = Impulse.kr(6) * trigGate;
    var dd = [
        [1, 0, 0, 1, 0, 0] ++ [1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0],
        [0, 0, 1, 0, 1, 0] ++ [0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0],
        [1, 0]
    ];
    var b = dd.size.collect({|i| t * Demand.kr(t, 0, Dseq(dd[i], inf))});
    var b0 = b[0];
    var morph = Demand.kr(b0, 0, Dseq([0.5, 0.5, 0.5, 0, 1].rotate(1), inf));
    var levv = Demand.kr(b0, 0, Dseq([0.25, 0, 0, 0, 0.35].rotate(1), inf));
    var dec = Demand.kr(b0, 0, Dseq([0.8, 0.6, 0.6, 0.6, 0.8].rotate(1), inf));
    var m = Demand.kr(b0, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b0, 0, Dseq([0.5, 0.51], inf));
    var level = b0.lag(0.5) * m2 * 2;
    var sig = MiPlaits.ar(
        pitch: ~toMidi.("A4") - 36 + [-12, 0, 0],      engine: [13, 15, 15],
        harm: 0.95,          timbre: [0.503, 0.1],               morph: [0.75, 0.5, 0.1],
        trigger: b,          level: level.lag(0.05) * 2 * 0,
        fm_mod: 0,           timb_mod: -0.5,                     morph_mod: -0.25,
        // decay: dec,          lpg_colour: levv.lag(0.4) * 0.5 + 0.5
   );
    sig[2][0] = VadimFilter.ar(sig[2][0], 2000, 0, 5);
    sig = sig[0][0] + (sig[1][0] * 0.4) + (sig[2][0]);
    sig = DCompressor.ar(
        input: sig,          sidechainIn: 0,        sidechain: 0,
        ratio: 4,            threshold: -10,        attack: 0.1,
        release: 100.1,      makeup: 0.5,           automakeup: 1
    );
    sig = VadimFilter.ar(sig, 4000 + 10, 0, 1);
    // MouseX.kr().poll;
    // MouseY.kr().poll;
    sig = [sig, DelayC.ar(sig, 0.5, 0.005)];
    sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 0.5 * 1;
    // sig = VadimFilter.ar(sig, 50, 0, 5);
}.play(fadeTime: 0);
)
