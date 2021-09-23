(
y.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
y = {
    | trigGate = 1 |
    var envGate = EnvGate.new();
    // var cutoff = SinOsc.kr(1).range(4000, 2000);
    var t = Impulse.kr(0.25 * 0.25) * trigGate;
    var env = EnvGen.kr(Env([0, 1, 0], [0.25, 4 - 0.2] * 4, [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, -2, -5, -4], inf));
    var in = MiBraids.ar(60 - 12 + note + [0, 0.1], timbre: 1, color: 0.5, model: 6);
    var    cutoff = 100 + (4000 * env);
    var sig = VadimFilter.ar(
        input: in,
        type: 1,
        freq: cutoff,
        resonance: 0.25
        // resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 0.125 * 0.5 * envGate;
    // LPF.ar(in, cutoff)!2;
    Out.ar(~reverbBus, sig);
}.play;
)