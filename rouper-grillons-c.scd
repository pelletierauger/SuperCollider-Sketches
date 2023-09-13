(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
a.set(\gate, 0, \fadeTime, 0.1);
a = {
    var t = Impulse.kr(~nT.tempo * 0.0625);
    var env = EnvGen.kr(Env([0, 1, 0], [1, 64 - 0.2], [0, -8, 'lin']), t);
    var env2 = EnvGen.kr(Env([-2, 0, 0], [1, 16 - 0.2], [0, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([0, -5], inf));
    var lfo = SinOsc.kr(3).range(0.25, 0.5);
    var sig = MiPlaits.ar(
            pitch: ~toMidi.("E5") + [0, 0.01] + lfo + note,
        engine: 2,
        harm: 0.95,
        timbre: 0.75,
        morph: 1 - (lfo * 0.35)
    ) * 0.5 * env;
    sig = [sig[0][0], sig[1][0]];
    sig = VadimFilter.ar(sig, 2200 + (1000 * env), 0, 5) * 0.1;
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/128/2), lev1: 0.85, lev2: 0.85,
        algo: 2, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 4;
    sig * 4;
}.play;
});
)