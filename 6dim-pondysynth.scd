(
~pondy3.stop;
~pondy3 = Pbind(
    // \instrument, \pizzi,
    // \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \instrument, \pondchirp,
    \dur, Pseq([3], inf),
    \freq, ~toFreq.("D5") * Pseq([0, 2, 0, 2 + 3, 4, 2, 7, 2 + 3].midiratio.stutter(1), inf),
    \amp, 2,
    \triMod, 0.5,
    \atk, 2,
    \rel, 10,
    \dec, 10,
    \low, 1500,
    \freqOsc, 2
).play(t, quant: [2, -0.95]);
)

(
~pondy.stop;
~pondy = Pbind(
    // \instrument, \pizzi,
    // \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \instrument, \pondchirp,
    \dur, Pseq([6], inf),
    \freq, ~toFreq.("D2") * Pseq([9, 7, 4, 0].midiratio.stutter(1), inf) * [2],
    \amp, 5,
    \atk, 0.2,
    \dec, 40,
    \rel, 15,
    \low, 1500,
    \freqOsc, 10
).play(t, quant: [2, -0.5]);
/*~pondy2.stop;
~pondy2 = Pbind(
    // \instrument, \pizzi,
    // \instrument, Pseq([\pizzi, \pizziFlip], inf),
    \instrument, \pondchirp,
    \dur, Pseq([Rest(3), 3], inf),
    \freq, ~toFreq.("E2") * ~modu.midiratio * Pseq([6, 9, 6, 9].midiratio.stutter(2), inf) * [2],
    \amp, 10,
    \atk, 0.2,
    \dec, 20,
    \rel, 7,
    \low, 1500,
    \freqOsc, 10
).play(t, quant: [2, -0.95]);*/
)

// beau aussi lorsque triMod = 1.5
(
SynthDef.new(\pondchirp, {
    arg out, freq = 220, lon = 3, amp = 1, pan = 0, atk = 2, rel = 2, freqOsc = 6, triMod = 1.5, dec = 0.2, low = 200;
    var sig, sig2, env, osc, osc2, loopEnv, loopEnv2, linPass, panFlip;
    panFlip = [[0, 1], [1, 0]].choose;
    osc = LFTri.ar(freqOsc, mul: 0.5, add:0.5);
    osc2 = LFTri.ar(1, pi, mul: 0.5, add:0.5);
    loopEnv = EnvGen.kr(Env.circle([0, 1, 0], [0.01, dec, 0.1 * freqOsc]));
    loopEnv2 = EnvGen.kr(Env.circle([1, 1.1, 1], [0.01, dec, 0.1 * freqOsc]));
    env = EnvGen.kr(Env.new([0.00001, 1, 0.00001], [atk, rel], curve: 'exp'), doneAction: 2);
    sig = SinOsc.ar([freq, freq + 0.1]) * 0.1;
    sig = sig + (LFTri.ar([freq + 0.2, freq + 0.1] * 1, pi) * 0.02);
    sig = sig * env * amp;
    // triMod = XLine.kr(0.5, 15, 12);
    sig = (sig * loopEnv) * (1 + SinOsc.ar([freq + 1.1, freq + 1] * 1.001 * triMod, mul: loopEnv * 1));
//     sig = sig + (sig * LFTri.ar([freq + 0.1, freq + 0.2] * 1.01) * 0.25);
    linPass = XLine.kr(low, 6000, atk + rel * 0.5);
    // sig = LPF.ar(sig, linPass) * 0.8;
    // sig = HPF.ar(sig, 250);
    sig = Balance2.ar(sig[panFlip[0]], sig[panFlip[1]], pan, 1);
    Out.ar(out, sig);
}).add;
)