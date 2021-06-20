(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

x.set(\gate, 0, \fadeTime, 0.1);
x = {
    var t = Impulse.kr(~nT.tempo * 0.125);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0.2, 0.2], inf));
    var sig = MiPlaits.ar(
        pitch: 60 + -12,
        engine: 2,
        harm: 0.5,
        timbre: 0.2,
        morph: 0.2
    ) * 4 * env;
    sig[1]!2;
}.play(fadeTime: 0.01);
});
)