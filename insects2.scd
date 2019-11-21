(
SynthDef.new(\insect, {
    arg out = 0, freq = 440, pan = 0;
    var lfoFreq = SinOsc.ar(0.125).range(10, 20);
    var lfo = SinOsc.ar(lfoFreq).range(0.85, 1.15);
/*    var env = EnvGen.ar(Env.new(
        [0.0, 1.0, 0.7, 0.7, 0.00001],
        [1.36e-3, 60, 2, 13.9],
        [\linear, \linear, \linear, \exponential]), doneAction: 2
    );*/
    var env2 = EnvGen.ar(Env.new(
        [0.0, 0.0, 1.0, 0.0],
        [1e-3, [5e-2, 5.05e-2], 1, 1e-3],
        releaseNode: 2, loopNode: 0), doneAction: 2
    );
    var envMod = EnvGen.ar(Env.new(
        [0.0, 1.0, 1.0, 1.0, 0.00001],
        [1.36e1, 60, 2, 50e-3],
        [\linear, \linear, \linear, \exponential]
    ), doneAction: 2);
    var mod = SinOsc.ar(freq * 0.5 * 17 * lfo) * envMod * 500;
    var otherMod = SinOsc.ar(freq * 1 * lfo) * 1000;
    var f = freq + mod + otherMod * lfo;
    var sig = SinOsc.ar([f, f + 1]) * LFTri.ar([f + 1, f] * 0.5) * 0.1 * env2;
    // sig = LPF.ar(sig, 1600 * 3);
    // var harmonics = ({|i| SinOsc.ar(freq * 2.pow(i) + mod + lfo) * i.linlin(0, 16, 0, 0.1)}!16).sum * env2;
    Out.ar(0, sig * 1);
}).add;
)

Synth.new(\insect, [freq: 1600 * 4.07]);

