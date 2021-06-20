(
~t.sched(~t.timeToNextBeat(quant: 1), {
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    var t = Impulse.kr(~t.beatDur.reciprocal * 0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-5, -12, -10, -17], inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note,
        engine: 2,
        harm: 0.25,
        timbre: 0.0,
        morph: 0.2
    ) * 0.5 * env;
    sig[1]!2;
}.play;
});
)

t.beatDur