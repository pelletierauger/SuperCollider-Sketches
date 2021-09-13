(
~chenZ.set(\gate, 0, \fadeTime, 0.1);
~chenZ = {

    var t = Impulse.kr(0.5 * 4 * 4);
    var d = Demand.kr(t, 0, Dseq(
        [1, 0, 0, 0, 1, 0, 0, 0] ++ [1, 0, 1, 0, 1, 0, 1, 0], inf));
    var dem = Demand.kr(t, 0, Dseq([1, 0.5], inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.01, 0.5], [-8, -8, 'lin']), t * d);
    var lfo = SinOsc.kr([1, 1.01]).range(-0.01, 0.01);
    var lfo2 = env * -0.01;
    var sig = Chen.ar(0.8, 0, 0.2 + (lfo2 * 4), 0.01);
    sig = sig[2]!2;
    // sig.size.poll;
/*    sig = sig * 0 + (VadimFilter.ar(
        input: sig,
        type: 5,
        freq: 2700,
        resonance: 0.25
        // resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 24);*/
    sig * 4 * env * Line.kr(0, 1, 0.2);
}.play;
)

(
~chen2.set(\gate, 0, \fadeTime, 0.1);
~chen2 = {

    var t = Impulse.kr(0.5 * 4 * 4);
    var d = Demand.kr(t, 0, Dseq(
        [1, 0, 0, 1, 0, 0, 1, 0] ++ [0, 0, 1, 0, 1, 0, 1, 0], inf));
    var dem = Demand.kr(t, 0, Dseq([1, 0.5], inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.01, 2.5], [-8, -8, 'lin']), t * d);
    var lfo = SinOsc.kr([1, 1.01]).range(-0.01, 0.01);
    var lfo2 = env * -0.01;
    var sig = Chen.ar(0.1 + lfo2, 0.69, 0.2 + (lfo2 * 4), 0.01);
    sig = sig[2]!2;
    // sig.size.poll;
    sig = sig * 1 + (VadimFilter.ar(
        input: sig,
        type: 5,
        freq: 2700,
        resonance: 0.25
        // resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 24);
    sig * 1 * env;
}.play;
)

(
~chen.set(\gate, 0, \fadeTime, 0.1);
~chen = {

    var t = Impulse.kr(0.5 * 4 * 4);
    var d = Demand.kr(t, 0, Dseq(
        [1, 0, 0, 0, 1, 0, 0, 0] ++ [1, 0, 1, 0, 1, 0, 1, 0], inf));
    var dem = Demand.kr(t, 0, Dseq([1, 0.5], inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.01, 0.5], [-8, -8, 'lin']), t * d);
    var lfo = SinOsc.kr([1, 1.01]).range(-0.01, 0.01);
    var lfo2 = env * -0.01;
    var sig = Chen.ar(0, 0, 0.0, 0);
    sig = sig[2]!2;
    // sig.size.poll;
/*    sig = sig * 0 + (VadimFilter.ar(
        input: sig,
        type: 1,
        freq: 50,
        resonance: 0.25
        // resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 44);*/
    sig * 1 * env;
}.play;
)


(
~chen.set(\gate, 0, \fadeTime, 0.1);
~chen = {

    var t = Impulse.kr(0.5 * 4 * 4);
    var d = Demand.kr(t, 0, Dseq(
        [1, 0, 0, 0, 1, 0, 0, 0] ++ [1, 0, 1, 0, 1, 0, 1, 0], inf));
    var dem = Demand.kr(t, 0, Dseq([1, 0.5], inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.05, 1.05], [-8, -8, 'lin']), t * d).lag(0.01);
    var lfo = SinOsc.kr([1, 1.01]).range(-0.01, 0.01);
    var lfo2 = env * -0.01;
    var sig = Chen.ar(1, 0.5, 1.0, 1);
    sig = sig[2]!2;
    // sig.size.poll;
/*    sig = sig * 0 + (VadimFilter.ar(
        input: sig,
        type: 1,
        freq: 50,
        resonance: 0.25
        // resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 44);*/
    sig * 1 * env;
}.play;
)


(
~chenA.set(\gate, 0, \fadeTime, 0.1);
~chenA = {

    var t = Impulse.kr(0.25 * 4 * 4);
    var d = Demand.kr(t, 0, Dseq(
        [1, 0, 0, 0, 1, 0, 0, 0] ++ [1, 0, 1, 0, 1, 0, 1, 0], inf));
    var dem = Demand.kr(t, 0, Dseq([1, 0.5], inf));
    var dd = Demand.kr(t, 0, Dseq(Dseries(0.4, 0.1, 16), inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.01, 2], [-8, -8, 'lin']), t * d);
    var lfo = SinOsc.kr([1, 1.01]).range(-0.01, 0.01);
    var lfo2 = env * -0.01;
    var sig = Chen.ar(1, 0.65, dd, 0.8);
    sig = sig[2]!2;
    // sig.size.poll;
    sig = sig * 0 + (VadimFilter.ar(
        input: sig,
        type: 5,
        freq: 2500,
        resonance: 0.25
        // resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 2);
    sig = VAKorg35.ar(sig, freq: 200, res: 0.8, overdrive: 0.95);
/*    sig = AnalogPhaser.ar(
        sig,
        SinOsc.ar(0.022 * [1, 1.1]),
        skew: SinOsc.kr(5.59 * [1, 1.1]),
        feedback: SinOsc.kr(0.005 * [1, 1.1], 1pi).range(0.8,0.85),
        modulation: SinOsc.kr(2.0192 * [1, 1.1], 2pi).unipolar,
        // modulation: 0.25,
        stages: 50
    );*/
    sig * 1 * env;
}.play;
)