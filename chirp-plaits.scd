(
SynthDef.new(\chirp, {
    arg out, freq = 220, lon = 3, amp = 1, pan = 0, atk = 2, rel = 2, freqOsc = 6;
    var lfo, alg, sig, sig1, sig2, env, osc, osc2, loopEnv, loopEnv2, linPass, timbre, morph;
    osc = LFTri.ar(freqOsc, mul: 0.5, add:0.5);
    osc2 = LFTri.ar(1, pi, mul: 0.5, add:0.5);
    loopEnv = EnvGen.kr(Env.circle([0, 1, 0], [0.01, 0.1, 0.1 * freqOsc]));
    loopEnv2 = EnvGen.kr(Env.circle([1, 1.1, 1], [0.01, 0.1, 0.1 * freqOsc]));
    env = EnvGen.kr(Env.new([0.00001, 1, 0.00001], [atk, rel], curve: 'exp'), doneAction: 2);
    sig = SinOsc.ar([freq, freq + 0.1], SinOsc.ar(freq * 4) * 16 % 2pi) * 0.1;
    sig = sig + (LFTri.ar([freq + 0.1, freq + 0.2] * 1, pi) * 0.02);



    lfo = SinOsc.kr(0.1).range(0.1, 0.12);
    // trig = Impulse.ar(1);
    alg = 5;
    timbre = 0.5;
    morph = 0;
    sig1 = MiPlaits.ar(freq.cpsmidi, alg, harm: lfo, timbre: timbre, morph: morph, usetrigger: 0, mul: 0.2);
    sig2 = MiPlaits.ar(freq.cpsmidi + 0.1, alg, harm: lfo, timbre: timbre, morph: morph, usetrigger: 0, mul: 0.2);
    sig = [sig1[0], sig2[0]];


    sig = sig * env * amp * loopEnv;
    // sig = (sig * loopEnv) * (1 + LFSaw.ar([freq + 1, freq + 1.1] * 1.001, mul: loopEnv * 1) * (1 + WhiteNoise.ar(mul: loopEnv * 0.1)));
//     sig = sig * LFSaw.ar([freq + 0.1, freq + 0.2] * 2.001);
    linPass = XLine.kr(200, 6000, atk + rel * 0.5);
    sig = LPF.ar(sig, linPass) * 4;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig * 1);
}).add;
)

4.cpsmidi