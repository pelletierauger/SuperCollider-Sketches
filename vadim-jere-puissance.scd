s.record;
s.stopRecording;

(
x.set(\trigGate, 0, \gate, 0, \fadeTime,1.1);
x = {
    | trigGate = 1 |
    var envGate = EnvGate.new();
    // var cutoff = SinOsc.kr(0.25).range(4000, 2000);
    var t = Impulse.kr(0.25 * 0.25) * trigGate;
    var env = EnvGen.kr(Env([0, 1, 0.5, 0], [0.15, 0.2, 4 - 0.2] * 16, [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, -2, -5, -4], inf));
    var in = MiBraids.ar(60 - 0 + note.lag(0.1), timbre: 0.5 + (env * 0.5), color: env * 0.2, model: 6) * 0.1 * env;
    var cutoff = 100 + (4500 * env);
    var sig = VadimFilter.ar(
        input: in,
        type: 1,
        freq: cutoff,
        resonance: 0.25
        // resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 2 * envGate;
    sig = AnalogPhaser.ar(
        sig,
        SinOsc.ar(0.022 * [1, 1.1]),
        skew: SinOsc.kr(5.59 * [1, 1.1]),
        feedback: SinOsc.kr(0.005 * [1, 1.1], 1pi).range(0.8,0.85),
        modulation: SinOsc.kr(2.0192 * [1, 1.1], 2pi).unipolar,
        stages: 50
    );
/*    sig = AnalogVintageDistortion.ar(
        sig, drivegain: 1, highgain: 0.3, shelvingfreq: 100, oversample: 4
    );*/
    // sig = MiVerb.ar(sig, drywet:1, damp:0.8);
    sig = AnalogTape.ar(sig, bias: 0.5, saturation: 1, drive: 1, mode: 3);
    sig * 0.5;
    // LPF.ar(in, cutoff)!2;
}.play;
y.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
y = {
    | trigGate = 1 |
    var envGate = EnvGate.new();
    var cutoff = SinOsc.kr(1).range(4000, 2000);
    var t = Impulse.kr(0.25 * 0.25) * trigGate;
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2] * 4, [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, -2, -5, -4], inf));
    var in = MiBraids.ar(60 + note + [0, 0.1], timbre: 1, color: 0.5, model: 26);
        cutoff = 100 + (4000 * env);
    VadimFilter.ar(
        input: in,
        type: 5,
        freq: cutoff,
        resonance: 0.25
        // resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 0.125 * 0.5 * envGate;
    // LPF.ar(in, cutoff)!2;
}.play;
)



(
x.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
x = {
    | trigGate = 1 |
    var envGate = EnvGate.new();
    // var cutoff = SinOsc.kr(0.25).range(4000, 2000);
    var t = Impulse.kr(0.25) * trigGate;
    var env = EnvGen.kr(Env([0, 1, 0.25, 0], [0.15, 0.2, 4 - 0.2] * 4, [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, -2, -5, -4], inf));
    var in = MiBraids.ar(60 + note, timbre: 0.5 + (env * 0.5), color: env * 0.2, model: 9);
    var   cutoff = 100 + (9000 * env);
    var sig = VadimFilter.ar(
        input: in,
        type: 1,
        freq: cutoff,
        resonance: (2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))) * 0.25
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 2 * 0.5 * envGate;
    sig = AnalogPhaser.ar(
        sig,
        SinOsc.ar(0.022),
        skew: SinOsc.kr(5.59),
        feedback: SinOsc.kr(0.005, 1pi).range(0.8,0.85),
        modulation: SinOsc.kr(2.0192 * [1, 1.1], 2pi).unipolar,
        stages: 50
    );
    sig * 0.5;
    // LPF.ar(in, cutoff)!2;
}.play;
)