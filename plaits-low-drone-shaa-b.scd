(
z.set(\gate, 0, \fadeTime, 0.1);
z = {
    var t = Impulse.kr(0.125);
    var d = Demand.kr(t, 0, Dseq([8, 5], inf));
    var f = 31 - 2 - d;
    var lfo = SinOsc.kr(0.1).range(0.1, 0.25);
    var alg = 5;
    var sig = MiPlaits.ar(f + [0, 0.1], alg, harm: lfo, morph: 0, mul: 0.2);
    // var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    sig = [sig[0][0], sig[1][0]] * 2;
    // sig = sig[0] * 2;
    // sig = sig + ;
    sig = VAKorg35.ar(sig, freq: 2000 * lfo, res: 0.6, overdrive: 0.05) +
    (VadimFilter.ar(sig, 1000, resonance: 0, type: 5) * 3) * 0.25;
}.play(fadeTime: 0.3);
)


(
j.free;
j = {
    var t = Impulse.kr(4);
    var d = Demand.kr(t, 0, Dseq([-4, -2, 8, 5, 1,  5, 1, 5], inf));
    var f = 31 - 2 - d + 12;
    var lfo = SinOsc.kr(0.1).range(0.1, 0.25);
    var alg = 5;
    var sig = MiPlaits.ar(f, alg, harm: lfo, morph: 0, mul: 0.2);
    // var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    // sig = [sig[0][0], sig[1][0]] * 2;
    sig = sig[0] * 2;
    // sig = sig + ;
    sig = VAKorg35.ar(sig, freq: 2000 * lfo, res: 0.6, overdrive: 0.05) +
    (VadimFilter.ar(sig, 1000, resonance: 0, type: 5) * 3) * 0.25!2;
}.play(fadeTime: 0.3);
)



(
{
    j.set(\gate, 0, \fadeTime, 0.1);
    j = {
        var env = EnvGen.kr(Env([0.25, 0.25, 0.5], [0.5, 0.5]));
        var t = Impulse.kr(4);
        var d = Demand.kr(t, 0, Dseq([8, 5, 1, 5, 1, 5, -4, -2], inf));
        var f = 31 - 2 - d + 12;
        var lfo = SinOsc.kr(0.1).range(0.1, 0.25);
        var alg = 5;
        var sig = MiPlaits.ar(f, alg, harm: lfo, morph: 0, trigger: 1, mul: 0.2);
        // var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
        // sig = [sig[0][0], sig[1][0]] * 2;
        sig = sig[0] * 2 * env;
        // sig = sig + ;
        sig = VAKorg35.ar(sig, freq: 2000 * lfo, res: 0.6, overdrive: 0.05) * 0 +
        (VadimFilter.ar(sig, 1000, resonance: 0, type: 5) * 3) * 0.5!2 * 2;
    }.play(fadeTime: 0.1);

    ~chen.set(\gate, 0, \fadeTime, 0.1);
    ~chen = {

        var t = Impulse.kr(0.5 * 4);
        var dem = Demand.kr(t, 0, Dseq([1, 0.5], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 2.5], [-8, -8, 'lin']), t) * dem;
        var lfo = SinOsc.kr([1, 1.01]).range(-0.01, 0.01);
        var lfo2 = env * -0.04;
        var sig = Chen.ar(0.1 + lfo2, 0.69, 0.2 + (lfo2 * 4), 0.01);
        sig = sig[2]!2;
        // sig.size.poll;
        sig = sig * 1 + (VadimFilter.ar(
            input: sig,
            type: 5,
            freq: 700,
            resonance: 0.25
            // resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
            //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
        ) * 24);
        sig * 2 * env;
    }.play(fadeTime: 1);

    0.5.wait;

        v.set(\gate, 0, \fadeTime, 0.1);
    v = {
        var trig, amp, sig, env;
        env = EnvGen.kr(Env([0.5, 0.5, 1], [1, 0.1]));
        trig = Impulse.ar(1);
        amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.0125, 2]), trig);
        sig = MiPlaits.ar(25 + 12 - 2,
            engine: 13,
            harm: 0.5,
            timbre: 0.9,
            morph: 0.4,
            trigger: trig,
            decay: 0.2,
            lpg_colour: 0,
            mul: 2) * 0.25;
        sig = sig[0] * env;
        sig = VAKorg35.ar(sig, freq: 200, res: 0.1, overdrive: 0.05);
        sig!2;
    }.play(fadeTime: 0);

}.fork;
)




// Très doux, feutré

(
z.set(\gate, 0, \fadeTime, 0.1);
[~noLowB].do({|i| i.set(\gate, 0, \fadeTime, 1)});

// ~t.sched(~t.timeToNextBeat(quant: 1), {
~noLowB = {
    var trig = Impulse.ar(1);
    var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0], inf));
    var notes = Demand.ar(trig, 0,
        Dseq(32 + [0] + 0, inf)
    );
    var dem = Demand.ar(trig, 0, Dseq((1..6) * 0.1, inf));
    var dem2 = Demand.ar(trig * block, 0, Dseq([0, 0], inf));
    var pitch = Demand.ar(trig * block, 0, Dseq([0, -5].stutter(2), inf));
    var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
    var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
    var lfo3 = SinOsc.kr(1).range(0, 2000);
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
    var sig = MiBraids.ar(
        pitch: 24 + 7 - 12 + 7 + pitch,
        timbre: 0.5,
        color: 0.0 + [0, 0.01],
        model: 0,
        resamp: 2,
        decim: 32,
        bits: 16,
        ws: 0
    );
    // sig = LPF.ar(sig, 4000);
    sig = sig * 0.6;
    sig = MiRings.ar(sig,
        pit: 36 + 2 + 7 + 2 - 2 - 12 * [1, 1.005],
        struct: 0.4,
        bright: 1,
        // pos: 0,
        model: 1
    ) * 0.1;
    [sig[1], sig[0]] * 0.75 * 4;
}.play(fadeTime: 0.1);
// });
)
