(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
d.free;
d = {
    var trig = Impulse.ar(0.75 * 1) + Impulse.ar(0.75 * 0.5, 0.25) + Impulse.ar(0.75 * 0.5, 0.75 * 0.75);
    var dem = Demand.ar(trig, 0, Dseq([0.15, 0.15, 0.7, 0.5] + 0.2, inf));
    var sig = MiPlaits2.ar(55 + -24,
        engine: 15,
        harm: 0.95,
        timbre: 0.95,
        // morph: SinOsc.kr(0.1).range(0.75, 0.95),
        morph: dem,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 1,
        mul: 0.5);
    sig = [sig[1], sig[1]] * 0.5;
    // HPF.ar(sig, 5000);
        // sig;
    MiRings2.ar(sig, pit: 31 + 12);
    }.play;
)

(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
u.free;
u = {
    var trig = Impulse.ar(0.75);
    var sig = MiPlaits2.ar(58 + -24 + 12 + -12,
        engine: 13,
        harm: 0.25,
        timbre: 0.5,
        // morph: SinOsc.kr(0.1).range(0.75, 0.95),
        morph: 0.85,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 1,
        mul: 1);
    [sig[1], sig[1]];
    // HPF.ar(sig, 5000);
        // sig;
    }.play;
)

(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
a.free;
a = {
    var trig = Impulse.ar(0.75);
    var sig = MiPlaits2.ar(58 + -24 + 12 + -12,
        engine: 14,
        harm: 0.25,
        timbre: 0.5,
        // morph: SinOsc.kr(0.1).range(0.75, 0.95),
        morph: 0.85,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 1,
        mul: 1);
    [sig[1], sig[1]];
    // HPF.ar(sig, 5000);
        // sig;
    }.play;
)