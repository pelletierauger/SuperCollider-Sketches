(
~k.set(\trigGate, 0, \gate, 0, \fadeTime, 0.01);
~k = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq(
        // [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0] ++
        ([1, 0, 0, 1, 0, 0, 1, 0] ++ [1] ++ (0!3) ++ [1] ++ (0!3)).rotate(8), inf));
    var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0, 1].rotate(1), inf));
    var levv = Demand.kr(b, 0, Dseq([0.25, 0, 0, 0, 0.35].rotate(1), inf));
    var dec = Demand.kr(b, 0, Dseq([0.8, 0.6, 0.6, 0.6, 0.8].rotate(1), inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 0.25], -8), b);
    var level = b.lag(0.5) * m2 * 2 + (b * 0);
    var sig = MiPlaits.ar(
        pitch: 40 - 24 + 12,      engine: 13,
        harm: 0.95,          timbre: 0.503,                        morph: 0.75,
        trigger: b,          level: level.lag(0.05) * 2 * 0,
        fm_mod: 0,           timb_mod: -0.5,                     morph_mod: 0.5,
        // decay: dec,          lpg_colour: levv.lag(0.4) * 0.5 + 0.5
   )[1];
   var dee = Demand.kr(b, 0, Dseq([0.04, 0.24, 0.24, 0.14, 0.14], inf));
    sig = sig * 2 + MiWarps.ar(sig, PinkNoise.ar() * sig * e, 0.5, 0.5, algo: 2, timb: 0.7)[0];
    // sig = VadimFilter.ar(sig, 8000, 0, 1);
    // MouseX.kr().poll;
    // MouseY.kr().poll;
    // sig = [sig, DelayC.ar(sig, 0.5, 0.005)];
    // sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 2 * 1!2;
    // sig = VadimFilter.ar(sig, 50, 0, 5);
}.play(fadeTime: 0);
)



// Le calme d'un kick acoustique
(
~k.set(\trigGate, 0, \gate, 0, \fadeTime, 0.01);
~k = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq(
        // [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0] ++
        ([1, 0, 0, 1, 0, 0, 1, 0] ++ [1] ++ (0!3) ++ [1] ++ (0!3)).rotate(8), inf));
    var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0, 1].rotate(1), inf));
    var levv = Demand.kr(b, 0, Dseq([0.25, 0, 0, 0, 0.35].rotate(1), inf));
    var dec = Demand.kr(b, 0, Dseq([0.8, 0.6, 0.6, 0.6, 0.8].rotate(1), inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 0.25], -8), b);
    var level = b.lag(0.5) * m2 * 2 + (b * 0);
    var sig = MiPlaits.ar(
        pitch: 40 - 24 + 0,      engine: 13,
        harm: 0.95,          timbre: 0.503,                        morph: 0.75,
        trigger: b,          level: level.lag(0.05) * 2 * 0,
        fm_mod: 0,           timb_mod: -0.5,                     morph_mod: 0.5,
        // decay: dec,          lpg_colour: levv.lag(0.4) * 0.5 + 0.5
   )[1];
   var dee = Demand.kr(b, 0, Dseq([0.04, 0.24, 0.24, 0.14, 0.14], inf));
    sig = sig * 2 + MiWarps.ar(sig, PinkNoise.ar() * sig * e, 0.5, 0.5, algo: 1, timb: 0.04)[0];
    // sig = VadimFilter.ar(sig, 8000, 0, 1);
    // MouseX.kr().poll;
    // MouseY.kr().poll;
    // sig = [sig, DelayC.ar(sig, 0.5, 0.005)];
    // sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 2 * 1!2;
    // sig = VadimFilter.ar(sig, 50, 0, 5);
}.play(fadeTime: 0);
)

(
~k.set(\trigGate, 0, \gate, 0, \fadeTime, 0.01);
~k = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq(
        // [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0] ++
        ([1, 0, 0, 1, 0, 0, 1, 0] ++ [1] ++ (0!3) ++ [1] ++ (0!3)).rotate(8), inf));
    var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0, 1].rotate(1), inf));
    var levv = Demand.kr(b, 0, Dseq([0.25, 0, 0, 0, 0.35].rotate(1), inf));
    var dec = Demand.kr(b, 0, Dseq([0.8, 0.6, 0.6, 0.6, 0.8].rotate(1), inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 0.25], -8), b);
    var level = b.lag(0.5) * m2 * 2 + (b * 0);
    var sig = MiPlaits.ar(
        pitch: 40 - 24 + 12,      engine: 13,
        harm: 0.95,          timbre: 0.503,                        morph: 0.75,
        trigger: b,          level: level.lag(0.05) * 2 * 0,
        fm_mod: 0,           timb_mod: -0.5,                     morph_mod: 0.5,
        // decay: dec,          lpg_colour: levv.lag(0.4) * 0.5 + 0.5
   )[1];
   var dee = Demand.kr(b, 0, Dseq([0.04, 0.24, 0.24, 0.14, 0.14], inf));
    sig = sig * 2 + MiWarps.ar(sig, PinkNoise.ar() * sig * e, 0.5, 0.5, algo: 1, timb: 0.04)[0];
    // sig = VadimFilter.ar(sig, 8000, 0, 1);
    // MouseX.kr().poll;
    // MouseY.kr().poll;
    // sig = [sig, DelayC.ar(sig, 0.5, 0.005)];
    // sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 2 * 1!2;
    // sig = VadimFilter.ar(sig, 50, 0, 5);
}.play(fadeTime: 0);
)




(
~k.set(\trigGate, 0, \gate, 0, \fadeTime, 0.01);
~k = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq(
        // [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0] ++
        ([1, 0, 0, 1, 0, 0, 1, 0] ++ [1] ++ (0!3) ++ [1] ++ (0!3)).rotate(8), inf));
    var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0, 1].rotate(1), inf));
    var levv = Demand.kr(b, 0, Dseq([0.25, 0, 0, 0, 0.35].rotate(1), inf));
    var dec = Demand.kr(b, 0, Dseq([0.8, 0.6, 0.6, 0.6, 0.8].rotate(1), inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 0.25], -8), b);
    var level = b.lag(0.5) * m2 * 2 + (b * 0);
    var sig = MiPlaits.ar(
        pitch: 40 - 24 + 12,      engine: 13,
        harm: 0.95,          timbre: 0.503,                        morph: 0.95,
        trigger: b,          level: level.lag(0.05) * 2 * 0,
        fm_mod: 0,           timb_mod: -0.5,                     morph_mod: 0.5,
        // decay: dec,          lpg_colour: levv.lag(0.4) * 0.5 + 0.5
   )[1];
   var dee = Demand.kr(b, 0, Dseq([0.04, 0.24, 0.24, 0.14, 0.14], inf));
    sig = sig * 2 + MiWarps.ar(sig, PinkNoise.ar() * sig * e, 0.5, 0.75, algo: 1, timb: 0.04)[0];
    sig = VadimFilter.ar(sig, 8000, 0, 1);
    // MouseX.kr().poll;
    // MouseY.kr().poll;
    // sig = [sig, DelayC.ar(sig, 0.5, 0.005)];
    // sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 2 * 1!2;
    // sig = VadimFilter.ar(sig, 50, 0, 5);
}.play(fadeTime: 0);
)



(
~k.set(\trigGate, 0, \gate, 0, \fadeTime, 0.01);
~k = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq(
        // [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0] ++
        ([1, 0, 0, 1, 0, 0, 1, 0] ++ [1] ++ (0!3) ++ [1] ++ (0!3)).rotate(8), inf));
    var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0, 1].rotate(1), inf));
    var levv = Demand.kr(b, 0, Dseq([0.25, 0, 0, 0, 0.35].rotate(1), inf));
    var dec = Demand.kr(b, 0, Dseq([0.8, 0.6, 0.6, 0.6, 0.8].rotate(1), inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1], -8), b);
    var level = b.lag(0.5) * m2 * 2 + (b * 0);
    var sig = MiPlaits.ar(
        pitch: 40 - 24 + 12,      engine: 13,
        harm: 0.95,          timbre: 0.503,                        morph: 0.95,
        trigger: b,          level: level.lag(0.05) * 2 * 0,
        fm_mod: 0,           timb_mod: -0.5,                     morph_mod: 0.5,
        // decay: dec,          lpg_colour: levv.lag(0.4) * 0.5 + 0.5
   )[1];
   var dee = Demand.kr(b, 0, Dseq([0.04, 0.24, 0.24, 0.14, 0.14], inf));
    sig = sig * 1 + (MiWarps.ar(sig, PinkNoise.ar() * sig * e, 0.5, 0.75, algo: 3, timb: 0.4)[0] * 1);
    sig = VadimFilter.ar(sig, 8000, 0, 1);
    // MouseX.kr().poll;
    // MouseY.kr().poll;
    // sig = [sig, DelayC.ar(sig, 0.5, 0.005)];
    // sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 2 * 1!2;
    // sig = VadimFilter.ar(sig, 50, 0, 5);
}.play(fadeTime: 0);
)



// la boue, la rouille, la combinaison de la boue et de la rouille


(
~k.set(\trigGate, 0, \gate, 0, \fadeTime, 0.01);
~k = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq(
        // [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0] ++
        ([1, 0, 0, 1, 0, 0, 1, 0] ++ [1] ++ (0!3) ++ [1] ++ (0!3)).rotate(8), inf));
    var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0, 1].rotate(1), inf));
    var levv = Demand.kr(b, 0, Dseq([0.25, 0, 0, 0, 0.35].rotate(1), inf));
    var dec = Demand.kr(b, 0, Dseq([0.8, 0.6, 0.6, 0.6, 0.8].rotate(1), inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1], -8), b);
    var level = b.lag(0.5) * m2 * 2 + (b * 0);
    var sig = MiPlaits.ar(
        pitch: 36 - 24 + 12,      engine: 13,
        harm: 0.95,          timbre: 0.503,                        morph: 0.95,
        trigger: b,          level: level.lag(0.05) * 2 * 0,
        fm_mod: 0,           timb_mod: -0.5,                     morph_mod: 0.5,
        // decay: dec,          lpg_colour: levv.lag(0.4) * 0.5 + 0.5
   )[1];
   var dee = Demand.kr(b, 0, Dseq([0.04, 0.24, 0.24, 0.14, 0.14], inf));
    sig = sig * 1 + (MiWarps.ar(sig, PinkNoise.ar() * sig, 0.5, 0.5, algo: 4, timb: 0.4)[0] * e);
    sig = VadimFilter.ar(sig, 8000, 0, 1);
    // MouseX.kr().poll;
    // MouseY.kr().poll;
    // sig = [sig, DelayC.ar(sig, 0.5, 0.005)];
    // sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 2 * 1!2;
    // sig = VadimFilter.ar(sig, 50, 0, 5);
}.play(fadeTime: 0);
)



(
~k.set(\trigGate, 0, \gate, 0, \fadeTime, 0.01);
~k = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq(
        // [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0] ++
        ([1, 0, 0, 1, 0, 0, 1, 0] ++ [1] ++ (0!3) ++ [1] ++ (0!3)).rotate(8), inf));
    var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0, 1].rotate(1), inf));
    var levv = Demand.kr(b, 0, Dseq([0.25, 0, 0, 0, 0.35].rotate(1), inf));
    var dec = Demand.kr(b, 0, Dseq([0.8, 0.6, 0.6, 0.6, 0.8].rotate(1), inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.005, 2], -8), b);
    var level = b.lag(0.5) * m2 * 2 + (b * 0);
    var sig = MiPlaits.ar(
        pitch: 36 - 24 + 12,      engine: 13,
        harm: 0.95,          timbre: 0.503,                        morph: 0.95,
        trigger: b,          level: level.lag(0.05) * 2 * 1,
        fm_mod: 0,           timb_mod: -0.5,                     morph_mod: 0.5,
        // decay: dec,          lpg_colour: levv.lag(0.4) * 0.5 + 0.5
   )[1];
   var dee = Demand.kr(b, 0, Dseq([0.04, 0.24, 0.24, 0.14, 0.14], inf));
    sig = sig * 1 + (MiWarps.ar(sig, PinkNoise.ar() * sig, 0.5, 0.5, algo: 3, timb: 0.2)[0] * e);
    // sig = VadimFilter.ar(sig, 8000, 0, 1);
    // MouseX.kr().poll;
    // MouseY.kr().poll;
    // sig = [sig, DelayC.ar(sig, 0.5, 0.005)];
    // sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 2 * 1!2;
    // sig = VadimFilter.ar(sig, 50, 0, 5);
}.play(fadeTime: 0);
)