(
r.set(\gate, 0, \fadeTime, 0.1);
r = {
    var t = Demand.kr(Impulse.kr(0.5), 0, Dseq([1, 0], inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.05, 8], [2, -5, 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-5, -10], inf));
    var f = 220 * -12.midiratio;
    var car = SinOsc.ar(f * note.midiratio);
    var mod = LFTri.ar(f * note.midiratio);
    var sig = MiWarps.ar(
        carrier: car,
        modulator: mod,
        lev1: 0.4,
        lev2: 0.4,
        algo: 2.25,
        timb: SinOsc.kr(1).range(0.35, 0.75) * 0 + 0.5,
        osc: 1,
        freq: f * note.midiratio * [1, 1.001]
    );
    sig = [sig[0][0], sig[1][0]] * 2 * env;
/*    sig = MiRings.ar(sig,
        pit: f.cpsmidi + note,
        struct: Demand.kr(t, 0, Dseq([0.7, 0.8].stutter(12), inf)),
        bright: 0.7,
        damp: Demand.kr(t, 0, Dseq([0.0, 0.5].stutter(6), inf)),
        pos: 1,
        model: 0,
        poly: 2
    ) * 0.35 * 2;*/
    // sig = HPF.ar(sig, 100) * 4;
    // sig[0]!2 * 0.95;

}.play(fadeTime: 0.1);
)