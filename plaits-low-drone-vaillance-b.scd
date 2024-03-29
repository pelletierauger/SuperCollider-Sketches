~nT = TempoClock.new(1.8678125).permanent_(true);
~nT.tempo = 1.8678125;

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
x.set(\gate, 0, \fadeTime, 0.1);
x = {
        var t = Impulse.kr(~nT.tempo * 0.125 * 0.5);
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
}.play(fadeTime: 0.1);
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

j.set(\gate, 0, \fadeTime, 0.1);
j = {
    var env = EnvGen.kr(Env([0.25, 0.25, 0.5], [0.5, 0.5]));
    var t = Impulse.kr(~nT.tempo * 2);
    var d = Demand.kr(t, 0, Dseq(
        [-7, -4, 0, -4, 0, -4, 5, 3] ++
        [-7, -4, 0, -4, 0, -4, 3, 0]
        , inf));
    var f = 31 + d + 12;
    var lfo = SinOsc.kr(0.1).range(0.1, 0.25);
    var alg = 5;
    var dec = SinOsc.kr(0.1).range(0.2, 0.7);
    var sig = MiPlaits.ar(f, alg, harm: lfo, morph: 0, trigger: 1, decay: 0.2, mul: 0.2);
    // var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    // sig = [sig[0][0], sig[1][0]] * 2;
    sig = sig[0] * 2 * env;
    // sig = sig + ;
    sig = VAKorg35.ar(sig, freq: 2000 * lfo, res: 0.6, overdrive: 0.05) * 0.2 +
    (VadimFilter.ar(sig, 1000, resonance: 0.25, type: 5) * 3) * 0.5!2 * 6;
        sig * 0.5;
        // sig = VadimFilter.ar(sig, 2000, 0.25, 1) * 4;
}.play(fadeTime: 0.1);
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    if(~snare.isPlaying, {~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
    ~snare = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 2);
        var pat0 = [1, 0, 0, 0, 0, 1, 0, 0];
        var pat1 = [0, 0, 1, 0, 0, 0, 1, 1];
        var pat2 = [1, 0];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig, 0, Dseq(pat2, inf));
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var sig = MiPlaits.ar(
            pitch: 30 + [ 0, 12, 12, 36 ] + 12,
            engine: 9,
            harm: 0.25,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0, 0],
            trigger: trig * [block0, block1, block1, block2] * trigGate,
            decay: [0.9, 0.6, 0.6, 0.7] * 0.85,
            lpg_colour: 0
        );
        var dd = Demand.kr(trig, 0, Dseq([2, 1].stutter(16), inf));
        var ddd = Demand.kr(trig, 0, Dseq([8000, 5000].stutter(16), inf));
        var sig2 = [sig[1][1], sig[2][1]] * 1.5;
        sig = [sig[0][1] * 2 + (sig[3][1] * 0.25)]!2 + sig2;
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = VadimFilter.ar(sig, 2500, 0.5, 1);
        sig = Decimator.ar(sig, 1100 * dd, 12) * 0.5;
        sig = VadimFilter.ar(sig, ddd * Amplitude.kr(sig) + 2000, 0.25, 1);
        // sig.unipolar.poll;
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 3.6 * 2;
    }.play(fadeTime: 0.01).register;
});
)

(

x.set(\gate, 0, \fadeTime, 0.1);

j.set(\gate, 0, \fadeTime, 0.1);
k.set(\gate, 0, \fadeTime, 0.1);
    if(~snare.isPlaying, {~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 15)});
)