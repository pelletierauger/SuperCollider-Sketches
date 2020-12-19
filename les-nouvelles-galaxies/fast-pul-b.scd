(
var f = 220 * 9.midiratio;
var ff = 54 + -12;
~pul2.free;
~pul2 = {
    var trig = Impulse.ar(1.39 * 1);
    var note = Demand.ar(trig, 0, Dseq([0, 12].stutter(1), inf));
    var sig = MiPlaits.ar(54 + 7 + note,
        engine: 9,
        harm: 0.8,
        timbre: 0.0,
        // morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig,
        decay: 0.1,
        lpg_colour: 0,
        mul: 3);
/*    sig = (sig * 0.15) + MiRings.ar(sig,
        trig: 0,
        pit: note,
        struct: 0.9,
        bright: 0.4,
        damp: 0.65,
        pos: 2,
        bypass: 0);*/
    // sig = LPF.ar(sig, 9000);
    sig = sig * 0.5;
    sig[1]!2;
}.play(fadeTime: 0);
)

s.record;
s.stopRecording;