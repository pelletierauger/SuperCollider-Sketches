(
x.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
x = {
    | trigGate = 1 |
    var envGate = EnvGate.new();
    var cutoff = SinOsc.kr(1).range(4000, 2000);
    var t = Impulse.kr(0.25) * trigGate;
    var env = EnvGen.kr(Env([0, 1, 0.1, 0], [0.15, 0.2, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, -2, -5, -7], inf));
    var in = MiBraids.ar(60 + note, timbre: 0.5, color: env * 0.1, model: 6);
        cutoff = 100 + (4000 * env);
    VadimFilter.ar(
        input: in,
        type: 1,
        freq: cutoff,
        resonance: (2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))) * 0.25
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 2 * 0.125 * envGate;
    // LPF.ar(in, cutoff)!2;
}.play;

y.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
y = {
    | trigGate = 1 |
    var envGate = EnvGate.new();
    var cutoff = SinOsc.kr(1).range(4000, 2000);
    var t = Impulse.kr(0.25) * trigGate;
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, -2, -5, -7], inf));
    var in = MiBraids.ar(60 + note + [0, 0.1], timbre: 0.5, color: env * 0.1, model: 26);
        cutoff = 100 + (4000 * env);
    VadimFilter.ar(
        input: in,
        type: 5,
        freq: cutoff,
        resonance: (2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))) * 0.25
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 0.125 * 0.125 * envGate;
    // LPF.ar(in, cutoff)!2;
}.play;
~chen.set(\gate, 0, \fadeTime, 0.1);
~chen = {

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
        resonance: 0.25
        // resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 40);
    sig * 0.2 * 0.025 * 2;
}.play;
)






(
o.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
o = {
    | trigGate = 1 |
    var envGate = EnvGate.new();
    var cutoff = SinOsc.kr(1).range(4000, 2000);
    var t = Impulse.kr(0.25 * 0.5) * trigGate;
    var t2 = Impulse.kr(0.25) * trigGate;
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2] * 1, [2, 'lin', 'lin']), t2);
    var note = Demand.kr(t, 0, Dseq([0, -2, -5, -4], inf));
    var in = MiBraids.ar(60 + note + [0, 0.1], timbre: 1, color: 0.5, model: 26);
        cutoff = 100 + (2000 * env);
    VadimFilter.ar(
        input: in,
        type: 5,
        freq: cutoff,
        resonance: 0.25
        // resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 0.125 * 0.125 * envGate * Line.ar(0, 1, 0.075);
    // LPF.ar(in, cutoff)!2;
}.play;
)


(

o.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
x.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
y.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
~chenA.set(\gate, 0, \fadeTime, 0.1);
~chen.set(\gate, 0, \fadeTime, 0.1);
)