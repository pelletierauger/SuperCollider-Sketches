(
SynthDef.new(\tri, {
    arg out = 0, freq = 440, pan = 0, lfoFreq = 1,
    atk = 1, dec = 1, sustime = 3, rel = 20, sus = 0.7, pMod = 0.2, amp = 1,
    mod1 = 1, mod2 = 1, amp1 = 4, lfo2Freq = 10;
    var sig, env, lfo, lfo2, mod;

    // Safety measures, constraining values.
    amp = min(max(amp, 0), 1.5);
    freq = min(max(freq, 30), 1000);

    lfo = SinOsc.kr(lfoFreq, mul: 0.5, add: 0.5);
     lfo2 = SinOsc.kr(lfo2Freq, mul: 0.5, add: 0.5);
    env = EnvGen.ar(Env.new([0.0, 1.0, sus, sus, 0.00001], [atk, dec, sustime, rel], [\linear, \linear, \linear, \exponential]), doneAction: 2);
//     sig = Pulse.ar([freq, freq+1], width: SinOsc.kr(pMod).range(0.25, 0.75), mul: 1.0, add: 0.0) * 0.11;
    mod = SinOsc.ar(freq * mod1) * 800 * amp1;
    sig = LFTri.ar([freq, freq+1] + mod) * SinOsc.ar(freq * mod2) * 0.1;
    sig = sig * env * lfo2;
    sig = (sig * 0.75) + (sig * lfo * 0.25);
// sig = sig * lfo;
//     envf = XLine.kr(400, 20000, sustime * 0.1);
//     sig = LPF.ar(sig, envf);
sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)



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
    var otherMod = SinOsc.ar(freq * 16 * lfo) * 200;
    var f = freq + mod + otherMod * lfo;
    var sig = SinOsc.ar([f, f + 1]) * 0.1 * env2;
    // sig = LPF.ar(sig, freq);
    // var harmonics = ({|i| SinOsc.ar(freq * 2.pow(i) + mod + lfo) * i.linlin(0, 16, 0, 0.1)}!16).sum * env2;
    Out.ar(~reverbBus, sig * 1);
}).add;
)

Synth.new(\insect, [freq: 1600 * 1]);
Synth.new(\insect, [freq: 110 * 0.midiratio]);

0 = 1;
1 = 2;
2 = 4;
3 = 8;
2.pow(3);
2.range(-1, 2);


s.record;
s.stopRecording;