(
k.free;
k = {
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    var sig = MiElements.ar(
        gate: 1,
        pit: 32 + 12 + 12 - 2,
        contour: 0.5,
        bow_level: 1,
        bow_timb: SinOsc.kr(0.1).range(0.5, 0.7),
        geom: 0.5,
        space: 0.9,
        model: 1
    );
    sig * 4;
}.play;
)
k.set(\gate, 0, \fadeTime, 10);

(
l.free;
l = {
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    var sig = MiElements.ar(
        gate: 1,
        pit: 32 + 12 + 12 + 12 + 12,
        contour: 0.5,
        bow_level: 1,
        bow_timb: 0.25,
        geom: 0.95,
        bright: 0.2,
        damp: 0.4,
        space: 1,
        model: 1
    );
    HPF.ar(sig * 4, 700) * 16;
}.play;
)


(
u.free;
t.sched(t.timeToNextBeat(quant: 8), {
u = {
    var trig = Impulse.ar(122/60 * 0.5);
    var dem = Demand.ar(trig, 0, Dseq([0.95, 0.75].stutter(4), inf));
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    var sig = MiElements.ar(
        gate: 1,
        pit: 32 + 12 + 12 + 12 + 12 - 9 - 12,
        contour: 0.5,
        bow_level: 1,
        bow_timb: 0.25 + (1 - dem * 0.5),
        geom: dem,
        bright: 0.4,
        damp: 0.4,
        space: 1,
        model: 1
    );
    HPF.ar(sig * 4, 700) * 4 * 8;
}.play(fadeTime: 1);
    "oy!".postln;
});
)
l.set(\gate, 0, \fadeTime, 10);


(
var f = 220 * 9.midiratio;
var ff = 54 + -12 - 7;
b.free;
b = {
    var trig = Impulse.ar(1.39 * 0.2);
    var note = Demand.ar(trig, 0, ff + 12 + Dseq([0, -5].stutter(1), inf));
    var sig = MiPlaits.ar(note + [0, 0.1],
        engine: 3,
        harm: 0.25,
        timbre: 0.0,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig,
        decay: 0.1,
        lpg_colour: 0,
        mul: 3);
    sig = (sig * 0.15) + MiRings.ar(sig,
        trig: 0,
        pit: note - 12,
        struct: 0.9,
        bright: 0.4,
        damp: 0.65,
        pos: 2,
        bypass: 0);
    sig = sig * 0.25;
}.play(fadeTime: 0);
)