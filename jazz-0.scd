(
SynthDef.new(\simplest, {
    arg out = 0, freq = 220, lon = 3, amp = 1, pan = 0, atk = 0.02, rel = 1;
    var sig, sig2, env, osc, osc2, loopEnv, loopEnv2;
    osc = LFTri.ar(0.5, mul: 0.5, add:0.5);
    osc2 = LFTri.ar(1, pi, mul: 0.5, add:0.5);
    loopEnv = EnvGen.kr(Env.circle([0, 1, 0], [0.01, 0.025, 0.1 * osc]));
    loopEnv2 = EnvGen.kr(Env.circle([1, 1.1, 1], [0.01, 0.025, 0.1 * osc]));
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = SinOsc.ar([freq, freq + 0.1]) * 0.1;
    sig = sig + (LFTri.ar([freq + 0.1, freq + 0.2] * 1, pi) * 0.02);
    sig = sig * env * amp;
    sig = (sig * loopEnv) * (1 + LFTri.ar([freq + 1, freq + 1.1] * 1.001 * loopEnv2, mul: loopEnv * 1) * (1 + WhiteNoise.ar(mul: loopEnv * 0.1)));
    // sig = sig * LFTri.ar([freq + 0.1, freq + 0.2] * 4);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)


// wobbly piano
(
SynthDef(\piano, {
    arg buf = ~pianoSamples[0], rate = 1, spos = 0, pan = 0, amp = 1, out = ~limitBus;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0], [0.1, 8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: 2000, doneAction: 2);
    sig = sig * amp * 80 * env * SinOsc.kr(3);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)


(
var c1 = ~toMidi.("F5");
var c2 = ~toMidi.("G5");
var c3 = ~toMidi.("A5");
var maj = ([4, 7, 12]!2).flatten;
var min1 = ([0, 3, 7]!2).flatten;
var min2 = ([0, 7, 3]!2).flatten;
var deg = min1 ++ maj ++ min2 ++ maj;
~p1.stop;
~p1 = Pbind(
    \type, \playPiano,
    \dur, Pseq([0.5, 0.25, 0.25], inf),
    //     \num, ~toMidi.("F3") + Pseq([0, 4, 7], inf)
    \num, Pseq([c3, c1, c2, c1].stutter(6), inf)
    + Pseq(deg, inf)
    + (Pwrand([0, 12], [0.9, 0.1], inf) * Pdefn(\pProb, 0))
    + Pdefn(\pShift, 0),
).play(t, quant: 1);
)

(
var key = ~toMidi.("B4");
var notes = key + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24 + 5, -12, 3, 6, 11];
var nn = notes ++ notes2;
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.1!4 ++ 2, inf),
    \num, Pseq(nn, inf)
).play(t, quant: 1);
)


(
var key = ~toMidi.("A4");
var notes = key + [-24 + 7, 4 - 12, 0, 7, 11];
var notes2 = key + [-24 + 7, -12, -12 + 3, 6, 9] + 3;
var notes3 = key + [-24 + 7, -12, -12 + 3, 7, 10] + 2;
var notes4 = key + [-24 + 5, -12, 3, 6, 11];
var nn = notes ++ notes2 ++ notes3 ++ notes4;
~pia.stop;
~pia = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.5!1 ++ (0.1!3) ++ 1 * 2, inf),
    \num, Pseq(nn, inf) + Pseq(0!1 ++ (0!4), inf)
).play(t, quant: 1);
)

-12!1 ++ (0!3)


(
var key = ~toMidi.("F4");
var c0 = key + [0, 3, 6, 11, 12 + 6, 12 + 3 + 12];
var c1 = key + [-5, 0, 4, 11, 12 + 4, 12 + 7 + 12];
var nn = c0 ++ c1;
~pia2.stop;
~pia2 = Pbind(
    \type, \playPiano,
    \dur, Pseq((0.2!3) ++ 0.5 ++ 1.5 ++ 0.5, inf),
    \num, Pseq(nn, inf) + Pseq(-12!1 ++ (0!5), inf)
).play(t, quant: 1);
~synth.stop;
~synth = Pbind(
    \instrument, \simplest,
    \dur, Pseq([3.1], inf),
    \freq, ~toFreq.("F6") * Pseq([[3, 6 - 12], [4, 7 - 12]].midiratio, inf),
    \amp, 1,
    \rel, 3.1,
    \pan, Pwhite(-1.0, 1.0, inf) * 0.75,
    \out, ~reverbBus
).play(t, quant: 1);
)

((0.2!3) ++ 0.5 ++ 2).sum
(0.1!3) ++ 1


(
~synth.stop;
~synth = Pbind(
    \instrument, \simplest,
    \dur, Pseq([3.1], inf),
    \freq, ~toFreq.("D6") * Pseq([[3, 6], [4, 7]].midiratio, inf),
    \amp, 1.5,
    \rel, 3
).play(t, quant: 1);
)






(
var key = ~toMidi.("D#4");
var c0 = key + [0, 3, 6, 11, 12 + 6, 12 + 3 + 12] + 0;
var c1 = key + [-5, 0, 4, 11, 12 + 4, 12 + 7 + 12] + 0;
var nn = c0 ++ c1;
~pia2.stop;
~pia2 = Pbind(
    \type, \playPiano,
    \dur, Pseq((0.2!3) ++ 0.5 ++ 2.5 ++ 0.5, inf),
    \num, Pseq(nn, inf) + Pseq(-12!1 ++ (0!5), inf) + Pseq([0, 0], inf)
).play(t);
~synth.stop;
~synth = Pbind(
    \instrument, \simplest,
    \dur, Pseq([4.1], inf),
    \freq, ~toFreq.("D#6") * Pseq([[3, 6], [4, 7]].midiratio, inf) * [-12, -24].midiratio,
    \amp, 0.5,
    \rel, 4.1,
    \pan, Pwhite(-1.0, 1.0, inf) * 1,
    \out, ~reverbBus
).play(t);
)

((0.1!3) ++ 0.5 ++ 2.5 ++ 0.5).sum


(
var key = ~toMidi.("D#4");
var c0 = key + [-12 + 3, 3, 6, 11, 12 + 6, 12 + 3 + 12] + 0;
var c1 = key + [-12 + 4, 0, 4, 11, 12 + 4, 12 + 7 + 12] + 0;
var nn = c0 ++ c1;
~pia2.stop;
~pia2 = Pbind(
    \type, \playPiano,
    \dur, Pseq((0.2!3) ++ 0.5 ++ 2.5 ++ 0.5, inf),
    \num, Pseq(nn, inf) + Pseq(0!1 ++ (0!5), inf) + Pseq([-2, 7], inf)
).play(t);
~synth.stop;
~synth = Pbind(
    \instrument, \simplest,
    \dur, Pseq([4.1], inf),
    \freq, ~toFreq.("D#6") * Pseq([[3, 6 - 12], [4, 7 - 12]].midiratio, inf) * -2.midiratio * [0.25, 1],
    \amp, 1,
    \rel, 4.1,
    \pan, Pwhite(-1.0, 1.0, inf) * 0.75,
    \out, ~reverbBus
).play(t);
)


(
var key = ~toMidi.("D#4");
var c0 = key + [0, 3, 6, 11, 12 + 6, 12 + 3 + 12].reverse + 12;
var c1 = key + [-5, 0, 4, 11, 12 + 4, 12 + 7 + 12].reverse + 12;
var nn = c0 ++ c1;
~pia2.stop;
~pia2 = Pbind(
    \type, \playPiano,
    \dur, Pseq((0.1!3) ++ 0.5 ++ 2.5 ++ 0.5, inf),
    \num, Pseq(nn, inf) + Pseq(-48!1 ++ (0!5), inf) + Pseq([-2, 7], inf)
).play(t, quant: 1);
~synth.stop;
~synth = Pbind(
    \instrument, \simplest,
    \dur, Pseq([4.1 - 0.3], inf),
    \freq, ~toFreq.("D#6") * Pseq([[3, 6 - 12], [4, 7 - 12]].midiratio, inf) * -2.midiratio,
    \amp, 1,
    \rel, 4.1 - 0.3,
    \pan, Pwhite(-1.0, 1.0, inf) * 0.75,
    \out, ~reverbBus
).play(t, quant: 1);
)