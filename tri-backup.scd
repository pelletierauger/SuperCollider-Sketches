(
SynthDef.new(\tri, {
    arg out = 0, freq = 440, pan = 0, lfoFreq = 1, atk = 1, dec = 1, sustime = 3, rel = 20, sus = 0.7, pMod = 0.2, amp = 1;
    var sig, env, lfo, mod;
    
    // Safety measures, constraining values.
    amp = min(max(amp, 0), 1.5);
    freq = min(max(freq, 50), 1000);
    
    lfo = SinOsc.kr(lfoFreq, mul: 0.5, add: 0.5);
    env = EnvGen.ar(Env.new([0.0, 1.0, sus, sus, 0.00001], [atk, dec, sustime, rel], [\linear, \linear, \linear, \exponential]), doneAction: 2);
//     sig = Pulse.ar([freq, freq+1], width: SinOsc.kr(pMod).range(0.25, 0.75), mul: 1.0, add: 0.0) * 0.11;
    mod = SinOsc.ar(freq * 2) * 800 * 8;
    sig = LFTri.ar([freq, freq+1] + mod) * SinOsc.ar(freq * 1) * 0.1;
    sig = sig * env;
    sig = (sig * 0.75) + (sig * lfo * 0.25);
//     envf = XLine.kr(400, 20000, sustime * 0.1);
//     sig = LPF.ar(sig, envf);
sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

(
var f = ~toFreq.("F3");
Synth.new(\tri, [\freq, f * 0.5, \lfoFreq, rrand(0.1, 6), \pan, rrand(-0.5, 0.5), \amp, 0.85]);
Synth.new(\tri, [\freq, f, \lfoFreq, rrand(0.1, 6), \pan, rrand(-0.5, 0.5), \amp, 0.85]);
Synth.new(\tri, [\freq, f * 7.midiratio, \lfoFreq, rrand(0.1, 6), \pan, rrand(-0.5, 0.5), \amp, 0.85]);
Synth.new(\tri, [\freq, f * 14.midiratio, \lfoFreq, rrand(0.1, 6), \pan, rrand(-0.5, 0.5), \amp, 0.85]);
Synth.new(\tri, [\freq, f * 4.midiratio, \lfoFreq, rrand(6, 12), \pan, rrand(-0.5, 0.5), \amp, 0.85]);
)
