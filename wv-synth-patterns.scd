(
SynthDef(\muddy, {
    arg pan = 0, freq = 440, osc = 1, out = 0, atk = 0.1, rel = 2, amp = 1, startF = 0.01;
    var sig, index, index2, env, envf;
    envf = XLine.kr(startF, 20, 0.5);
    env = EnvGen.ar(Env.new([0.0, 1.0, 0.00001], [atk, rel], [\linear, \exponential]), doneAction: 2);
    index = SinOsc.ar(freq) * SinOsc.kr(envf, mul:0.5, add:0.5).range(0.25, 1);
    index2 = SinOsc.ar(freq + 0.1) * SinOsc.kr(envf + 0.1, mul:0.5, add:0.5).range(0.25, 1);
    sig = Shaper.ar(~b.bufnum, [index, index2]) * env * amp;
    // sig = sig * LFSaw.ar([fond + 0.1, fond] * 4);
    // sig = sig + Shaper.ar(~b.bufnum, index2) * 0.5;
    sig = LeakDC.ar(sig * 0.3);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)
Synth.new(\muddy, [\freq, 440]);


(
~muds.stop;
{
var a = [0, 2, 5, 9];
var b = [14, 10, 9, 5];
var c = [14, 12, 9, 5];
    var d = [-7, -2, 5, 9];
~muds = Pbind(
    \instrument, \muddy,
    \dur, Pseq([0.25, 0.125], inf),
    \freq, ~toFreq.("Bb3") * Pseq([0, 2, 5, 9, 14, 10, 9, 5, 0, 2, 5, 9, 14, 12, 9, 5].stutter(1).midiratio, inf) * [1],
    \freq, ~toFreq.("Bb3") * Pseq((a++b++d++c).stutter(1).midiratio, inf) * [1],
    \atk, 0.00125,
    \rel, 1.05,
            \rel, Pseq([1, 1.5, 2.5, 4] * 1, inf),
    \amp, Pseq([1, 0.5, 0.25, 0.125] * 2, inf),
    \startF, Pseq([Pgeom(0.1, 1.1, 48)], inf),
    \startF, Pseq(Pgeom(0.1, 1.1, 48).asStream.nextN(48).mirror, inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play;
}.();
)

a = [0, 2];
b = [3, 5];
(a++b++a++b).stutter(2);

(
~muds2.stop;
~muds2 = Pbind(
    \instrument, \muddy,
    \dur, Pseq([0.125] * 1.5, inf),
    \freq, ~toFreq.("Bb3") * Pseq([7, 5].stutter(1).midiratio, inf) * [1],
    \atk, 0.00125,
    \atk, 0.25,
    // \atk, Pseq([0.00125, 0.0125, 0.125, 0.25], inf),
    \rel, 0.5,
    \amp, Pseq([1, 0.5, 0.25, 0.125] * 1, inf),
    \startF, Pseq(Pgeom(0.1, 1.1, 48).asStream.nextN(48).mirror, inf),
    // \startF, Pseq([Plazy(~sinTime)], inf),
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(quant: 1);
)

Pgeom(0.1, 1.1, 48).asStream.nextN(48);

(
~forward = 0;
~sinTime = {
    ~forward = ~forward + 0.01;
    abs(sin(~forward)) + 0.01 * 18;
}
)

(
~muds3.stop;
~muds3 = Pbind(
    \instrument, \muddy,
    \dur, Pseq([0.125] * 2, inf),
    \freq, ~toFreq.("Bb3") * 0.midiratio * Pseq([12, 16, 19, 24].stutter(1).midiratio, inf) * [1],
    \atk, 0.00125,
    \rel, 0.5,
    \amp, Pseq([1, 0.5, 0.25, 0.125] * 2, inf),
    \startF, Pseq([Pgeom(0.1, 1.1, 48)], inf),
    \pan, Pwhite(-0.5, 0.5, inf),
    \pan, Pseq([-0.75, 0.75], inf),
    \out, 0
).play;
)

FreqScope.new;

[1, 2, 3, 4].mirror.postln;
6 * 8;
~te = Pgeom(0.1, 1.1, 60).asStream;
~te.next;

~toFreq.("Bb1");
440 * -36.midiratio;
(
~drone = {
    var sig, index, index2, fond;
    fond = ~toFreq.("Bb1") * 0.midiratio;
    index = SinOsc.ar(fond) * SinOsc.kr(0.1, mul:0.5, add:0.5).range(0.25, 1);
    index2 = SinOsc.ar(fond + 0.1) * SinOsc.kr(0.11, mul:0.5, add:0.5).range(0.25, 1);
    sig = Shaper.ar(~b.bufnum, [index, index2]) * 0.5;
    // sig = sig * LFSaw.ar([fond + 0.1, fond] * 4);
    // sig = sig + Shaper.ar(~b.bufnum, index2) * 0.5;
    sig = LeakDC.ar(sig * 0.2);
}.play;
)

~drone.free;


(
~drone2 = {
    var sig, index, index2, fond;
    fond = ~toFreq.("Bb1") * -12.midiratio;
    index = SinOsc.ar(fond) * SinOsc.kr(0.1, mul:0.5, add:0.5).range(0.25, 1);
    index2 = SinOsc.ar(fond + 0.1) * SinOsc.kr(0.11, mul:0.5, add:0.5).range(0.25, 1);
    sig = Shaper.ar(~b.bufnum, [index, index2]) * 0.5;
    // sig = sig * LFSaw.ar([fond + 0.1, fond] * 4);
    // sig = sig + Shaper.ar(~b.bufnum, index2) * 0.5;
    sig = LeakDC.ar(sig * 0.1);
}.play;
)
~drone2 = [];
~drone2.free;
~drone2;
~drone2.do({|item| item.free;});
a = [2];
a = a ++ 3;