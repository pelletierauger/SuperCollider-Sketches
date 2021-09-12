(
Ndef(\modulated_chen, {|amp=0.5|
    var chenspeedMax = 0.01;
    var chen = Chen.ar(LFCub.kr(0.1).range(0.001,chenspeedMax));
    var minfreq = 20.0, maxfreq=2500.0;
    var sig = SinOsc.ar(chen.linexp(0.0,1.0,minfreq,maxfreq));

    // Chen returns an array of values sot the ugen above is multi channel expanded
    amp * Splay.ar(sig, spread: chen[0]);
}).play
)

// See it on a scope
(
Ndef(\scoped, {
    var x, y, z;
    #x,y,z = Chen.ar(0.000092);

    [x,y,z]
}).scope;
)

(
Ndef(\torn, {|amp=0.5|
    var chenspeedMax = 0.009;
    var chen = Chen.ar(LFCub.kr(LFNoise2.kr(chenspeedMax * 2) * 0.1).range(0.001,chenspeedMax), 0.192, LFCub.kr(0.35).unipolar, 0.22);
    var minfreq = 40.0, maxfreq=500.0;
    var sig = VarSaw.ar(chen.linexp(0.0,1.0,minfreq,maxfreq), width: chen.reverse.lag);
    sig = sig + FreqShift.ar(sig, chen.scramble.lag3 * 1.0) * 0.5;

    // Chen returns an array of values sot the ugen above is multi channel expanded
    amp * Splay.ar(sig, spread: chen.sum / 4.0);
}).play
)


(
~chenA.set(\gate, 0, \fadeTime, 0.1);
~chenA = {

    var t = Impulse.kr(2 * 4);
    var dem = Demand.kr(t, 0, Dseq([1, 0.5], inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.01, 0.5], [-8, -8, 'lin']), t) * dem;
    var lfo = SinOsc.kr([1, 1.01]).range(-0.01, 0.01);
    var lfo2 = env * 0.01;
    var sig = Chen.ar(0.4 + lfo, 0.6, 0.2 + (lfo * 4), 0.01);
    sig = sig * 1 + (VadimFilter.ar(
        input: sig,
        type: 5,
        freq: 700,
        // resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 40);
    sig * 0.2 * 0.025;
}.play;
)


(
~chen2.set(\gate, 0, \fadeTime, 0.1);
~chen2 = {

    var t = Impulse.kr(1 * 4);
    var env = EnvGen.kr(Env([0, 1, 0], [0.01, 0.5], [-8, -8, 'lin']), t);
    var lfo = SinOsc.kr([1, 1.01]).range(-0.01, 0.01);
    var sig = Chen.ar(0.19 + lfo, 0.55, 0.2 + (lfo * 4), 0.4);
    sig = sig + (VadimFilter.ar(
        input: sig,
        type: 5,
        freq: 5000,
        // resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 40);
    sig * 0.2 * env * 0.5;
}.play;
)


(
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
        // resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 24);
    sig * 1 * env;
}.play;
)

(
y.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
y = {
    | trigGate = 1 |
    var envGate = EnvGate.new();
    // var cutoff = SinOsc.kr(1).range(4000, 2000);
    var t = Impulse.kr(0.25 * 0.25) * trigGate;
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2] * 4, [2, 'lin', 'lin']), t).lag(0.2);
    var note = Demand.kr(t, 0, Dseq([0, -2, -5, -4], inf));
    var in = MiBraids.ar(60 - 12 + note + [0, 0.1], timbre: 1, color: 0.75, model: 29);
    var cutoff = 100 + (4000 * env);
    var sig = VadimFilter.ar(
        input: in,
        type: 1,
        freq: cutoff,
        // resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 0.125 * 0.5 * envGate;
    sig = AnalogPhaser.ar(
        sig,
        SinOsc.ar(0.022 * [1, 1.1]),
        skew: SinOsc.kr(5.59 * [1, 1.1]),
        feedback: SinOsc.kr(0.005 * [1, 1.1], 1pi).range(0.8,0.85),
        modulation: SinOsc.kr(2.0192 * [1, 1.1], 2pi).unipolar,
        stages: 50
    );
    sig * 0.5;
    // LPF.ar(in, cutoff)!2;
}.play;
)
