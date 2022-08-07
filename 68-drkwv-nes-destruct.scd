(
x.free;
x = {
    var tempo = 2;
        var t = Impulse.kr(1 * tempo);
    var t20 = Impulse.kr(4 * tempo);
        var t2 = t20 * Demand.kr(t20, 0, Dwrand([1,0],[0.8,0.2],inf));
    var d = Demand.kr(t2, 0, Dseq([0.35, 1].reverse, inf));
    var d2 = Demand.kr(t20, 0, Dseq(
        [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0] ++
        [1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0]
        , inf));
    var d3 = Demand.kr(t2, 0, Dwhite(0, 0.95, inf));
    var sig = AnalogSnareDrum.ar([t, t2],
        accent: [0.75, 0.5],
        freq: [48, 36 + 24 + 24] + 24,
        tone: [0.5, 0.1],
        decay: [0.2, 0.005 + (d2 * 1)] + 0,
        snappy: [0.2, 0.2] + 0
    ) * [1.4, d.lag(0.01)];
    var sig2;
    sig = VadimFilter.ar(sig, 1500, 0, 5);
    // sig = sig.sum * 0.1;
    sig = MiWarps.ar(sig[0], sig[1], lev1:0.5,lev2:0.5,algo:1,timb:0.15)[0];
    sig2 = Nes2Noise.ar([t, t2], loopenv:0, envdecay:1,vol:10,short:1, freq:5, vbl:3 + d2) * Amplitude.ar(sig);
    // sig = MiWarps.ar(sig2, sig, lev1:0.5, lev2:0.25, algo:3,timb:1)[1] * 5;
    sig2 = sig2.sum;
    sig2 * 0.1!2;
}.play(fadeTime:0);
~k.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~k = {
    | trigGate = 1 |
    var f = ~toMidi.("A4");
    var t = Impulse.kr(4) * trigGate;
    var dd = [
        [1, 0, 0, 1, 0, 0] ++ [1, 0, 1, 0, 0, 0],
        [0, 1, 0, 0, 1, 0] ++ [0, 0, 0, 1, 0, 0],
        [1]
    ];
    var b = dd.size.collect({|i| t * Demand.kr(t, 0, Dseq(dd[i], inf))});
    var b0 = b[0];
    var morph = Demand.kr(b0, 0, Dseq([0.5, 0.5, 0.5, 0, 1].rotate(1), inf));
    var levv = Demand.kr(b0, 0, Dseq([0.25, 0, 0, 0, 0.35].rotate(1), inf));
    var dec = Demand.kr(b0, 0, Dseq([0.8, 0.6, 0.6, 0.6, 0.8].rotate(1), inf));
    var m = Demand.kr(b0, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b0, 0, Dseq([0.5, 0.51], inf));
    var h = Demand.kr(b[2], 0, Dseq([0.5, 0.75], inf));
    var level = b0.lag(0.5) * m2 * 2;
    var sig = MiPlaits.ar(
        pitch: ~toMidi.("A4") - 36 + [0, 12, 24],      engine: [13, 14, 15],
        harm: 0.95,          timbre: [0.503, 0.1, 0.1],               morph: [0.75, 0.5, 0.4],
        trigger: b,          level: level.lag(0.05) * 2 * 0,
        fm_mod: 0,           timb_mod: -0.5,                     morph_mod: -0.25,
        // decay: dec,          lpg_colour: levv.lag(0.4) * 0.5 + 0.5
   );
    var k = sig[0][1];
    var sig2;
    // sig = sig[0][1] + (sig[1][0] * 1) + (sig[2][0] * 0);
    // sig = MiWarps.ar(LPF.ar(WhiteNoise.ar(),3000), sig, lev1:0.5,lev2:0.5,algo:3,timb:0.75);
    // sig = sig + k;
    /*    sig = DCompressor.ar(
        input: sig,          sidechainIn: 0,        sidechain: 0,
        ratio: 4,            threshold: -10,        attack: 0.1,
        release: 100.1,      makeup: 0.5,           automakeup: 1
    );*/
    // sig = VadimFilter.ar(sig, 4000 + 10, 0, 1);
    // MouseX.kr().poll;
    // MouseY.kr().poll;
    // sig = [sig, DelayC.ar(sig, 0.5, 0.005)];
    // sig = sig + ([sig[1], sig[0]] * 0.5);
        sig2 = Nes2Noise.ar([b[0], b[1]], loopenv:0, envdecay:1,vol:10, short:0, freq:15, vbl:4);
    // sig2 = VadimFilter.ar(sig2, 3000, 0, 1);
    sig = sig2 + (sig[0][1] * 0.2) * 0.1 * 0.2 * 1!2;
    // sig = VadimFilter.ar(sig, 50, 0, 5);
}.play(fadeTime: 0);
)