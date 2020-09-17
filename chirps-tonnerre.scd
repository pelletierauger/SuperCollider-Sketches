(
SynthDef.new(\chirp, {
    arg out, freq = 220, lon = 3, amp = 1, pan = 0, atk = 2, rel = 2, freqOsc = 6;
    var sig, sig2, env, osc, osc2, loopEnv, loopEnv2, linPass;
    osc = LFTri.ar(freqOsc, mul: 0.5, add:0.5);
    osc2 = LFTri.ar(1, pi, mul: 0.5, add:0.5);
    loopEnv = EnvGen.kr(Env.circle([0, 1, 0], [0.01, 0.1, 0.1 * freqOsc]));
    loopEnv2 = EnvGen.kr(Env.circle([1, 1.1, 1], [0.01, 0.1, 0.1 * freqOsc]));
    env = EnvGen.kr(Env.new([0.00001, 1, 0.00001], [atk, rel], curve: 'exp'), doneAction: 2);
    sig = SinOsc.ar([freq, freq + 0.1], SinOsc.ar(freq * 4) * 16 % 2pi) * 0.1;
    sig = sig + (LFTri.ar([freq + 0.1, freq + 0.2] * 1, pi) * 0.02);
    sig = sig * env * amp;
    sig = (sig * loopEnv) * (1 + LFSaw.ar([freq + 1, freq + 1.1] * 1.001, mul: loopEnv * 1) * (1 + WhiteNoise.ar(mul: loopEnv * 0.1)));
//     sig = sig * LFSaw.ar([freq + 0.1, freq + 0.2] * 2.001);
    linPass = XLine.kr(200, 6000, atk + rel * 0.5);
    sig = LPF.ar(sig, linPass) * 4;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig * 1);
}).add;
)

(
~chirps = {
var modif = 0.midiratio * 0.midiratio;
    var key = ~toFreq.("D0") * [36, 48, 48].choose.midiratio * modif;
var baseOsc = rrand(1, 12);
var minOsc = baseOsc - 0.05 / 12;
var maxOsc = baseOsc + 0.05 / 12;
Synth.new(\chirp, [\freq, key, \amp, 1, \out, 0, \rel, 20, \pan, rrand(-0.5, 0.5), \freqOsc, rrand(minOsc, maxOsc)]);
Synth.new(\chirp, [\freq, key * 4.midiratio * [1,2].choose, \amp, 1, \out, 0, \rel, 20, \pan, rrand(-0.5, 0.5), \freqOsc, rrand(minOsc, maxOsc)]);
Synth.new(\chirp, [\freq, key * 11.midiratio * [1,2].choose, \amp, 1, \out, 0, \rel, 20, \pan, rrand(-0.5, 0.5), \freqOsc, rrand(minOsc, maxOsc)]);
Synth.new(\chirp, [\freq, key * 14.midiratio, \amp, 1, \out, 0, \rel, 20, \pan, rrand(-0.5, 0.5), \freqOsc, rrand(minOsc, maxOsc)]);
6;
};
)

~chirps.();

TempoClock.default.sched(0.1, {~chirps.()});
TempoClock.default.clear;

(
~chirpClusters = Task {
{
~chirps.();
6.wait;
}.loop;}.start;
)
~chirpClusters.stop;


(
~chirpCreak = {
var degrees = Array.fill(3, {[1, 1, 1, 2].choose}) ++ [1, 1];
var modif = [0].midiratio;
var key = ~toFreq.(~key) * modif * 2;
var notes = key * [0, 4, 7, 11, 14].midiratio;
var arr = (notes * degrees).scramble;
var steps = Array.fill(5, {[0.125, 0.25].choose});
var baseOsc = rrand(1, 12);
var minOsc = baseOsc - 0.05 / 12;
var maxOsc = baseOsc + 0.05 / 12;
var pulse = Pbind(
    \instrument, \chirp,
    \dur, Pseq(steps, 10),
    \freq, Pseq(arr, inf) * 2,
    \atk, 0.15,
    \rel, 0.25 / \dur,
    \freqOsc, rrand(minOsc, maxOsc),
//     \amp, Pseries(6, -0.06, inf),
    \amp, 2.5,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play();
steps.sum * 10;
};
)

~chirpCreak.();
TempoClock.default.sched(0, {~chirpCreak.()});
TempoClock.default.clear;


(
var test = ~chirpCreak.();
test.postln;
)

(
// Le printemps des laséristes
~nouvelleFriture.stop;
~twinkleClusters.stop;
~chirpClusters.stop;
~bassClusters.stop;
~creakyClusters = Task {
{
var waitValue = ~chirpCreak.();
waitValue.wait;
}.loop;}.start;
)
~creakyClusters.stop;



(
SynthDef.new(\newChirps, {
    arg out, freq = 220, lon = 3, amp = 1, pan = 0, atk = 2, rel = 2, freqOsc = 6;
    var sig, sig2, env, osc, osc2, loopEnv, loopEnv2, loopEnv3, linPass;
    osc = LFTri.ar(freqOsc, mul: 0.5, add:0.5);
    osc2 = LFTri.ar(1, pi, mul: 0.5, add:0.5);
    loopEnv = EnvGen.kr(Env.circle([1, 0, 0], [0.01, 0.01, 0.01]));
    loopEnv2 = EnvGen.kr(Env.circle([1, 1.1, 1], [0.01, 0.1, 0.001 * freqOsc]));
    loopEnv3 = EnvGen.kr(Env.circle([1, 0, 0], [0.01, 0.01, 0.05]));
    env = EnvGen.kr(Env.new([0.00001, 1, 0.00001], [atk, rel], curve: 'exp'), doneAction: 2);
    sig = SinOsc.ar([freq, freq + 0.1]) * 0.1;
    sig = sig + (LFTri.ar([freq + 0.1, freq + 0.2] * 1, pi) * 0.02);
    sig = sig * env * amp;
    sig = (sig * loopEnv3) * (1 + LFSaw.ar([freq + 1, freq + 1.1] * 2.001, mul: loopEnv) * (1 + WhiteNoise.ar(mul: loopEnv * 0.4)));
    sig = sig * LFSaw.ar([freq + 0.1, freq + 0.2] * 1.001);
    linPass = XLine.kr(500, 9000, atk + rel * 0.25);
//         linPass = XLine.kr(5000, 500, atk + rel * 0.25);
    sig = LPF.ar(sig, linPass) * 4;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

(
~noisyPestilence = {
var modif = -4.midiratio * [-12, 0, 12].choose.midiratio;
var baseOsc = rrand(1, 480);
var minOsc = baseOsc - 0.05 / 12;
var maxOsc = baseOsc + 0.05 / 12;
var key = ~toFreq.(~key) * [36].choose.midiratio * modif;
var delay = 0.125;
    var t = Routine({
Synth.new(\newChirps, [\freq, key, \amp, 1, \out, 0, \rel, 20, \pan, rrand(-0.5, 0.5), \freqOsc, rrand(minOsc, maxOsc)]);
        delay.wait;
Synth.new(\newChirps, [\freq, key * 4.midiratio, \amp, 1, \out, 0, \rel, 20, \pan, rrand(-0.5, 0.5), \freqOsc, rrand(minOsc, maxOsc)]);
        delay.wait;
Synth.new(\newChirps, [\freq, key * 11.midiratio, \amp, 1, \out, 0, \rel, 20, \pan, rrand(-0.5, 0.5), \freqOsc, rrand(minOsc, maxOsc)]);
        delay.wait;
Synth.new(\newChirps, [\freq, key * 14.midiratio, \amp, 1, \out, 0, \rel, 20, \pan, rrand(-0.5, 0.5), \freqOsc, rrand(minOsc, maxOsc)]);
baseOsc.postln;
    }).play;
    [6, 8, 10].choose;
    nil;
};
)


~noisyPestilence.();
TempoClock.default.sched(0.1, {~noisyPestilence.()});
TempoClock.default.clear;



(
SynthDef.new(\basschirp, {
    arg out, freq = 220, lon = 3, amp = 1, pan = 0, atk = 2, rel = 2, freqOsc = 6, triMod = 0.5, dec = 0.2, low = 200;
    var sig, sig2, env, osc, osc2, loopEnv, loopEnv2, linPass;
    osc = LFTri.ar(freqOsc, mul: 0.5, add:0.5);
    osc2 = LFTri.ar(1, pi, mul: 0.5, add:0.5);
    loopEnv = EnvGen.kr(Env.circle([0, 1, 0], [0.01, dec, 0.1 * freqOsc]));
    loopEnv2 = EnvGen.kr(Env.circle([1, 1.1, 1], [0.01, dec, 0.1 * freqOsc]));
    env = EnvGen.kr(Env.new([0.00001, 1, 0.00001], [atk, rel], curve: 'exp'), doneAction: 2);
    sig = SinOsc.ar([freq, freq + 0.1]) * 0.1;
    sig = sig + (LFTri.ar([freq + 0.1, freq + 0.2] * 1, pi) * 0.02);
    sig = sig * env * amp;
    sig = (sig * loopEnv) * (1 + LFTri.ar([freq + 1, freq + 1.1] * 1.001 * triMod, mul: loopEnv * 1));
//     sig = sig + (sig * LFTri.ar([freq + 0.1, freq + 0.2] * 1.01) * 0.25);
    linPass = XLine.kr(low, 6000, atk + rel * 0.5);
    sig = LPF.ar(sig, linPass) * 4;
    sig = HPF.ar(sig, 250);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

~f.();
~chirps.();

(
~bassCluster = {
Synth.new(\basschirp, [\freq, ~toFreq.(~key) * 2 * [1, 13].choose.midiratio * -1.midiratio, \amp, 1.7, \out, ~reverbBus, \rel, 20, \pan, rrand(-0.85, 0.5), \freqOsc, rrand(0.1, 0.5), \triMod, 0.5, \dec, rrand(0.2, 0.3), \low, rrand(200, 800)]);
Synth.new(\basschirp, [\freq, ~toFreq.(~key) * 2 * [8, 17, 20].choose.midiratio * -1.midiratio, \amp, 1.7, \out, ~reverbBus, \rel, 20, \pan, rrand(-0.85, 0.5), \freqOsc, rrand(0.1, 0.5), \triMod, 1, \dec, rrand(0.2, 0.3), \low, rrand(200, 800)]);
[2, 4, 6].choose;
};

)

~bassCluster.();


TempoClock.default.sched(0, {~bassCluster.()});
TempoClock.default.clear;


(
~bassClusters = Task {
{~bassCluster.(); [2, 4, 6].choose.wait;}.loop;}.start;
)
~bassClusters.stop;