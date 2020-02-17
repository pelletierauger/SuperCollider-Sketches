(
var key = ~toMidi.("A4");
var notes = key + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24 + 7, 0, 3, 6, 11];
var nn = notes ++ notes2;
~pia.stop;
~pia = Pbind(
    \type, \pianoEvent,
    \dur, Pseq(0.1!4 ++ 3.6, inf),
    \num, Pseq(nn, inf),
    \dyn, Pseq(0!4 ++ 1, inf),
    \amp, Pseq(1!4 ++ 0.5, inf) * 0.5
).play(quant: [4, -0.58]);
)

(
var key = ~toMidi.("A6");
var notes = key + [-12, -8, -6, 4 - 12, 11 - 12] - 0;
// var notes2 = key + [-24 + 7, 0, 3, 6, 11];
var nn = notes.reverse.stutter(1);
~piaHautQuant.stop;
~piaHautQuant = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([2,2,1,2,1] ++ [Rest(1),2,2,1,2] * 0.25, inf),
    \num, Pseq(nn, inf) + Pseq([0, 0], inf),
    \dyn, Pseq([1], inf),
    \amp, Pseq(0.15!4 ++ 0.75, inf) * 0.5,
    \sus, 4,
    \rel, 2
).play(quant: [4, -0.18]);
)



//-------------------------

(
SynthDef.new(\chirp, {
    arg out, freq = 220, lon = 3, amp = 1, pan = 0, atk = 2, rel = 2, freqOsc = 6;
    var sig, sig2, env, osc, osc2, loopEnv, loopEnv2, linPass;
    osc = LFTri.ar(freqOsc, mul: 0.5, add:0.5);
    osc2 = LFTri.ar(1, pi, mul: 0.5, add:0.5);
    loopEnv = EnvGen.kr(Env.circle([0, 1, 0], [0.01, 0.1, 0.1 * freqOsc]));
    loopEnv2 = EnvGen.kr(Env.circle([1, 1.1, 1], [0.01, 0.1, 0.1 * freqOsc]));
    env = EnvGen.kr(Env.new([0.00001, 1, 0.00001], [atk, rel], curve: 'exp'), doneAction: 2);
    sig = SinOsc.ar([freq, freq + 0.1]) * 0.1;
    sig = sig + (LFTri.ar([freq + 0.1, freq + 0.2] * 1, pi) * 0.02);
    sig = sig * env * amp;
    sig = (sig * loopEnv) * (1 + LFSaw.ar([freq + 1, freq + 1.1] * 1.001, mul: loopEnv * 1) * (1 + WhiteNoise.ar(mul: loopEnv * 0.1)));
    linPass = XLine.kr(200, 6000, atk + rel * 0.5);
    sig = LPF.ar(sig, linPass) * 4;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)
(
SynthDef.new(\chirpFlip, {
    arg out, freq = 220, lon = 3, amp = 1, pan = 0, atk = 2, rel = 2, freqOsc = 6;
    var sig, sig2, env, osc, osc2, loopEnv, loopEnv2, linPass;
    osc = LFTri.ar(freqOsc, mul: 0.5, add:0.5);
    osc2 = LFTri.ar(1, pi, mul: 0.5, add:0.5);
    loopEnv = EnvGen.kr(Env.circle([0, 1, 0], [0.01, 0.1, 0.1 * freqOsc]));
    loopEnv2 = EnvGen.kr(Env.circle([1, 1.1, 1], [0.01, 0.1, 0.1 * freqOsc]));
    env = EnvGen.kr(Env.new([0.00001, 1, 0.00001], [atk, rel], curve: 'exp'), doneAction: 2);
    sig = SinOsc.ar([freq, freq + 0.1]) * 0.1;
    sig = sig + (LFTri.ar([freq + 0.1, freq + 0.2] * 1, pi) * 0.02);
    sig = sig * env * amp;
    sig = (sig * loopEnv) * (1 + LFSaw.ar([freq + 1, freq + 1.1] * 1.001, mul: loopEnv * 1) * (1 + WhiteNoise.ar(mul: loopEnv * 0.1)));
    linPass = XLine.kr(200, 6000, atk + rel * 0.5);
    sig = LPF.ar(sig, linPass) * 4;
    sig = Balance2.ar(sig[1], sig[0], pan, 1);
    Out.ar(out, sig);
}).add;
)

(
~chirps = {
    var key = ~toFreq.("A0") * [36, 48, 48].choose.midiratio;
    var baseOsc = rrand(1, 12);
    var minOsc = baseOsc - 0.05 / 12;
    var maxOsc = baseOsc + 0.05 / 12;
    Synth.new([\chirp, \chirpFlip].choose, [\freq, key, \amp, 1, \out, 0, \rel, 20, \pan, rrand(-0.5, 0.5), \freqOsc, rrand(minOsc, maxOsc)]);
    Synth.new([\chirp, \chirpFlip].choose, [\freq, key * 4.midiratio * [1,2].choose, \amp, 1, \out, 0, \rel, 20, \pan, rrand(-0.5, 0.5), \freqOsc, rrand(minOsc, maxOsc)]);
    Synth.new([\chirp, \chirpFlip].choose, [\freq, key * 11.midiratio * [1,2].choose, \amp, 1, \out, 0, \rel, 20, \pan, rrand(-0.5, 0.5), \freqOsc, rrand(minOsc, maxOsc)]);
    Synth.new([\chirp, \chirpFlip].choose, [\freq, key * 6.midiratio, \amp, 1, \out, 0, \rel, 20, \pan, rrand(-0.5, 0.5), \freqOsc, rrand(minOsc, maxOsc)]);
    6;
};
)

~chirpClusters = Task {{~chirps.(); 6.wait;}.loop;}.start;
~chirpClusters.stop;