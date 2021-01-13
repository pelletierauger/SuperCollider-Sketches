(
var f = 220 * 9.midiratio;
var ff = 54 + -12;
~pul.free;
~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.3 + (t.beatDur * 0), {
~pul = {
        var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
    var note = Demand.ar(trig, 0, ff + 12 + Dseq([0].stutter(5), inf));
        var dem = Demand.ar(trig, 0, Dseq([1], inf));
        var dem2 = Demand.ar(trig, 0, Dseq(((1..5)/10).stutter(4), inf));
    var sig = MiPlaits.ar(42 + 7 + 24,
        engine: 9,
        harm: 0.5,
        timbre: 0.75,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig * dem,
        decay: 0.8,
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
    sig = HPF.ar(sig, 4000);
    sig = sig * 4;
    sig[1]!2;
}.play(fadeTime: 0);
});
)