(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
x.set(\gate, 0, \fadeTime, 0.1);
x = {
        var t = Impulse.kr(~nT.tempo * 0.25 * 0.5);
        var d = Demand.kr(t, 0, Dseq([0, 4], inf));
    var lfo = SinOsc.kr(0.1).range(0.1, 0.25);
    var sig = MiPlaits.ar(
        pitch: 31 - d + [0, 0.1],
        engine: 5,
        harm: lfo,
        morph: 0
    );
    sig = [sig[0][0], sig[1][0]] * 0.4;
    sig = sig * 0.5 + (VadimFilter.ar(sig, 500, 0.25, 1) * 4) * 2;
}.play(fadeTime: 10.1);
});
~nT.sched(~nT.timeToNextBeat(quant: 4), {

j.set(\gate, 0, \fadeTime, 0.1);
j = {
    var env = EnvGen.kr(Env([0.25, 0.25, 0.5], [0.5, 0.5]));
    var t = Impulse.kr(~nT.tempo * 2);
    var d = Demand.kr(t, 0, Dseq(
            [3, 7, 10, 7, 10, 7, 3, 0] ++
            [3, 7, 10, 7, 10, 7, 3, 0]++
            [7, 8, 12, 8, 12, 7, 8, 10] ++
            [7, 8, 12, 8, 12, 7, 15, 12]
        , inf));
    var b = Demand.kr(t, 0, Dseq([1, 1, 0, 1, 0, 1, 1, 1], inf));
    var f = 31 + d + 12;
        var lfo = SinOsc.kr(0.1).range(0.1, 0.1);
    var alg = 5;
    var dec = SinOsc.kr(0.1).range(0.2, 0.7);
    var sig = MiPlaits.ar(f, alg, harm: lfo, morph: 0, trigger: 1, decay: 0.5, mul: 0.2);
    // var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    // sig = [sig[0][0], sig[1][0]] * 2;
    sig = sig[0] * 2 * env;
    // sig = sig + ;
    sig = VAKorg35.ar(sig, freq: 2000 * lfo, res: 0.6, overdrive: 0.05) * 0.2 +
    (VadimFilter.ar(sig, 1000, resonance: 0.25, type: 5) * 3) * 0.5!2 * 6;
        sig * 0.5;
        sig = VadimFilter.ar(sig, 2000, 0.25, 1) * 4;
}.play(fadeTime: 30.1);
});
)