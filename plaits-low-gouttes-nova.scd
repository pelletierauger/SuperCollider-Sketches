(
y = {
    var trig = Impulse.ar(2);
    var sig1 = MiPlaits2.ar(53 + 12 + 12 + 19 + 12,
        engine: 9,
        harm: 0.125,
        timbre: 0.0125 * 0.125,
        morph: 0.75,
        trigger: trig,
        // usetrigger: 1,
        decay: 0.95,
        lpg_colour: 0,
        mul: 1);
    sig1[0]!2;
}.play;
)
(
y = {
    var trig = Impulse.ar(2);
    var sig1 = MiPlaits2.ar(53 + 12 + 12 + 19,
        engine: 9,
        harm: 0.125,
        timbre: 0.0125 * 0.125,
        morph: 0.75,
        trigger: trig,
        // usetrigger: 1,
        decay: 0.95,
        lpg_colour: 0,
        mul: 1);
    sig1[0]!2;
}.play;
)
(
y = {
    var trig = Impulse.ar(2);
    var sig1 = MiPlaits2.ar(53 + 12 + 12 + 12,
        engine: 9,
        harm: 0.125,
        timbre: 0.0125 * 0.125,
        morph: 0.75,
        trigger: trig,
        // usetrigger: 1,
        decay: 0.95,
        lpg_colour: 0,
        mul: 1);
    sig1[0]!2;
}.play;
)


// -------------------------

(
y.free;
y = {
    var trig = Impulse.ar(5);
    var dem = Demand.ar(trig, 0, Dseq([0, -5, -7].stutter(16), inf));
    var sig1 = MiPlaits2.ar(53 + 12 + 0 + dem,
        engine: 9,
        harm: 0.0,
        timbre: 0.0,
        morph: 0.8,
        trigger: trig,
        // usetrigger: 1,
        decay: 0.99,
        lpg_colour: 0,
        mul: 1);
    var sig = sig1[1]!2;
    (sig * 0.5) + [MiRings2.ar(sig, pit: 53 - 10), MiRings2.ar(sig, pit: 53 - 10.1)];
}.play;
)

(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
d.free;
d = {
    var trig = Impulse.ar(5 * 0.25);
    var dem = Demand.ar(trig, 0, Dseq([0.15, 0.7], inf));
    var sig = MiPlaits2.ar(55 + -24,
        engine: 15,
        harm: 0.95,
        timbre: 0.85,
        // morph: SinOsc.kr(0.1).range(0.75, 0.95),
        morph: dem,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 1,
        mul: 0.5);
    sig = [sig[1], sig[1]];
    // HPF.ar(sig, 5000);
    sig * 2;
    // MiRings2.ar(sig, pit: 31 + 12) * 4;
    }.play;
)