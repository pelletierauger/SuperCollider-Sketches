(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

j.set(\gate, 0, \fadeTime, 0.1);
j = {
    var env = EnvGen.kr(Env([0.25, 0.25, 0.5], [0.5, 0.5]));
    var t = Impulse.kr(~nT.tempo * 2);
    var d = Demand.kr(t, 0, Dseq(
        [-7, -4, 0, -4, 0, -4, 5, 3] ++
        [-7, -4, 0, -4, 0, -4, 3, 0]
        , inf) + Dseq([0, -2].stutter(16), inf));
    var f = 31 + d + 12;
    var lfo = SinOsc.kr(0.1).range(0.1, 0.25);
    var alg = 5;
    var dec = SinOsc.kr(0.1).range(0.2, 0.7);
    var sig = MiPlaits.ar(f, alg, harm: 0.65, morph: 0.6, trigger: t, decay: 0.4, mul: 0.2);
    // var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    // sig = [sig[0][0], sig[1][0]] * 2;
    sig = sig[0] * 2 * env;
    // sig = sig + ;
    sig = VAKorg35.ar(sig, freq: 2000 * lfo, res: 0.6, overdrive: 0.05);
        sig = sig * 2;
        sig = VadimFilter.ar(sig, 1500, 0.25, 1);
        sig = sig!2;
        // sig = VadimFilter.ar(sig, 2000, 0.25, 1) * 4;
}.play(fadeTime: 0.1);
});
)
