s.boot;

(
SynthDef(\cfstring1, { arg i_out, freq = 360, gate = 1, pan, amp=0.1;
    var out, eg, fc, osc, a, b, w;
    fc = LinExp.kr(LFNoise1.kr(Rand(0.25, 0.4)), -1, 1, 500, 2000);
    osc = Mix.fill(8, {LFSaw.ar(freq * [Rand(0.99, 1.01), Rand(0.99, 1.01)], 0, amp) }).distort * 0.2;
    eg = EnvGen.kr(Env.asr(1, 1, 1), gate, doneAction: Done.freeSelf);
    out = eg * RLPF.ar(osc, fc, 0.1);
    #a, b = out;
    Out.ar(i_out, Mix.ar(PanAz.ar(4, [a, b], [pan, pan+0.3])));
}).add;

e = Pbind(
    \degree, Pseq((0..12), inf),
    \dur, 0.2,
    \instrument, \cfstring1
).play; // returns an EventStream
)

( // an interactive session
e.stop
e.play
e.reset

e.mute; // keeps playing, but replaces notes with rests

e.unmute;

e.reset; // reset the stream.
e.reset; // reset the stream.
e.reset; // reset the stream.
e.reset; // reset the stream.

e.pause; // will resume where paused.

e.play;

e.stop; // will reset before resume.

e.play;
)

(
e.stream = Pbind(
    \degree, Pseq([0, 1, 2, 4, 6, 3, 4, 8], inf),
    \dur, Prand([0.2, 0.4, 0.8], inf),
    \amp, 0.05, \octave, 5,
    \instrument, \cfstring1, \ctranspose, 0
).asStream;
)

(
e.stream = Pbind(
    \degree, Pseq([0, 1, 2, 4, 6, 3, 4, 8], inf),
    \dur, Prand([0.2, 0.4, 0.8], inf),
    \amp, 0.05, \octave, 5,
    \instrument, \cfstring1, \ctranspose, 0
).asStream;
)

(
e.stream = Pbind(
    \degree, Pxrand([0, 1, 2, 4, 6, 3, 5, 7, 8], inf),
    \dur, Prand([0.2, 0.4, 0.8], inf), \amp, 0.05,
    \octave, 5, \instrument, \cfstring1
).asStream;
)