(
[y, z].do({|i| i.set(\gate, 0, \fadeTime, 0.1)});
a.set(\gate, 0, \fadeTime, 0.1);
a = {
    var t = Demand.kr(Impulse.kr(4), 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0], inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.05, 4], [2, -5, 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-5].rotate(3), inf));
    var f = 220 * 0.5 * 2.midiratio;
    var car = SinOsc.ar(f * note.midiratio);
    var mod = LFTri.ar(f * note.midiratio);
    var sig = MiWarps.ar(
        carrier: car,
        modulator: mod,
        lev1: 0.5,
        lev2: 0.5,
        algo: 5,
        timb: SinOsc.kr(1).range(0.35, 0.75) + [0, 0.2],
        osc: 1,
        freq: 71
    );
    sig = [sig[0][0], sig[1][0]] * 0.5 * env;
    sig = MiRings.ar(sig,
        pit: f.cpsmidi,
        struct: 0.4,
        bright: 0.7,
        damp: Demand.kr(t, 0, Dseq([0.0, 0.5].stutter(6), inf)),
        pos: 1,
        model: 4,
        poly: 0
    ) * 0.35 * 0.25;
    // sig[0]!2 * 0.95;

}.play(fadeTime: 0.1);
)