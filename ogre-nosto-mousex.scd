
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
        decay: dec + 0.25,            lpg_colour: levv.lag(0.4) * 0.5
   )[1];
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
    sig = VadimFilter.ar(sig, 550, 0, 5) * 16 * 4;
    MiRings.ar(sig, pit: 40, struct: 0.2, damp: 0.3, bright: 0.1, pos: 0.05, model: 1) * 16;
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
    MiRings.ar(sig, pit: 40 - 12, struct: 0.25, damp: SinOsc.kr(1).unipolar, bright: MouseX.kr(), pos: 0.125, model: 1) * 16 * 2 * max(0, (1 - (MouseX.kr() * 1)));
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
   )[1];
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
    sig = VadimFilter.ar(sig, 550, 0, 5) * 16 * 2;
    MiRings.ar(sig, pit: 40 - 12 - 12, struct: 0.25, damp: 0.5, bright: 0.1, pos: 0.125, model: 1) * 16;
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
   )[1];
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
    sig = VadimFilter.ar(sig, 550, 0, 5) * 16 * 2;
    MiRings.ar(sig, pit: 40 - 12 - 12 - 12, struct: 0.25, damp: 0.5, bright: 0.1, pos: 0.125, model: 1) * 16;
}.play(fadeTime: 0);
)