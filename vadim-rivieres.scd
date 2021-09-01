VadimFilter



(
// Random LPF 4
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    var cutoff = SinOsc.kr(1).range(4000, 2000);
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, -2, -5, -7], inf));
    var in = MiBraids.ar(60 + note, timbre: 0.5, color: env * 0.1, model: 6);
        cutoff = 100 + (4000 * env);
    VadimFilter.ar(
        input: in,
        type: 1,
        freq: cutoff,
        resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 2;
    // LPF.ar(in, cutoff)!2;
}.play;
)




// ------------------------------------------------------------------------
// Beau pour vrai
// ------------------------------------------------------------------------



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
        resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 2 * 0.25 * envGate;
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
        resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 0.125 * 0.25 * envGate;
    // LPF.ar(in, cutoff)!2;
}.play;
)


(
x.set(\trigGate, 0, \gate, 0, \fadeTime, 7);
y.set(\trigGate, 0, \gate, 0, \fadeTime, 7);

z.set(\gate, 0, \fadeTime, 15);
)



(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    // var cutoff = SinOsc.kr(1).range(4000, 2000);
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0.5, 0], [0.5, 0.2, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, -2, 3, 2], inf));
    var in = MiBraids.ar(60 + -24 + note + [0, 0.1], timbre: 0.85, color: 0.1, model: 43);
    var    cutoff = 100 + (3000 * env);
    var sig = VadimFilter.ar(
        input: in[0],
        type: 1,
        freq: cutoff,
        resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 2 * 0.25;
   sig = sig + (VadimFilter.ar(
        input: in,
        type: 5,
        freq: cutoff + 5000,
        resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 2 * 0.25 * 0.125 * 0.5 * (0.2 + (env * 0.8)));
    // sig = sig + (MiRings.ar(sig, pit: 60 - 12) * 0.5);
    // LPF.ar(in, cutoff)!2;
}.play;
)





(
z.set(\gate, 0, \fadeTime, 0.1);
z = {
    var cutoff = SinOsc.kr(1).range(4000, 2000);
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0.5, 0], [0.5, 0.2, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, -2, -5, -7].rotate(2), inf));
    var in = MiBraids.ar(60 + 0 + note, timbre: 0.125, color: env * 0.5, model: 31);
        cutoff = 100 + (3000 * env);
    VadimFilter.ar(
        input: in,
        type: 1,
        freq: cutoff,
        resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 2 * 0.25;
    // LPF.ar(in, cutoff)!2;
}.play;
)