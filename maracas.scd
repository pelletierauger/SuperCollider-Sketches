(
SynthDef.new(\pebble, {
    arg freq = 880, amp = 1, filt = 5000;
    var f = freq * 8;
    var env = EnvGen.kr(Env.new([0, 1, 0.0125, 0], [0.001, 0.01, 0.001], [3, -3, -3]), doneAction: 2);
    // var op1 = SinOsc.ar(f * [1, 1.001]) * 0.1;
    // var sig = Impulse.ar(0.1, mul: 0.4)!2;
    var op1 = WhiteNoise.ar(1!2) * 0.1;
    // sig = Ringz.ar(sig, [freq, freq + 2], 0.125);
    op1 = LPF.ar(op1, 60 + (1800 * amp));
    op1 = HPF.ar(op1, filt);
    Out.ar(0, op1 * env * amp);
}).add;
)



Synth.new(\pebble);


(
~pizc.stop;
~pizc = Pbind(
    \instrument, \pebble,
    // \dur, Pwhite(0.001, 0.5, 40),
    \dur, Pseq([0.125 * 0.0625] * 0.5, inf) * Pwhite(0.8, 1.2, inf),
    \amp, Pseq(Pseries(0, 0.0125, 160).asStream.nextN(160).mirror, inf) * 1,
    // \rate, Pwhite(0.25, 2, 40)  * 8,
    // \freq, Pseq([220], inf)
    \freq, Pseq([440 * 1], inf) + (Pwhite(-50, 50, inf)),
    \filt, 5000
).play(quant: [1, 0.125]);
)
(
~pizd.stop;
~pizd = Pbind(
    \instrument, \pebble,
    // \dur, Pwhite(0.001, 0.5, 40),
    \dur, Pseq([0.125 * 0.0625] * 0.5, inf) * Pwhite(0.8, 1.2, inf),
    \amp, Pseq(Pseries(0, 0.0125 * 2, 80).asStream.nextN(80).mirror, inf) * 1,
    // \rate, Pwhite(0.25, 2, 40)  * 8,
    // \freq, Pseq([220], inf)
    \freq, Pseq([440 * 1], inf) + (Pwhite(-50, 50, inf)),
    \filt, 7000
).play(quant: [1, 0.125]);
)

(
~pize.stop;
~pize = Pbind(
    \instrument, \pebble,
    // \dur, Pwhite(0.001, 0.5, 40),
    \dur, Pseq([0.125 * 0.0625] * 0.5, inf) * Pwhite(0.8, 1.2, inf),
    \amp, Pseq(Pseries(0, 0.0125 * 4, 40).asStream.nextN(40).mirror, inf) * 1.5,
    // \rate, Pwhite(0.25, 2, 40)  * 8,
    // \freq, Pseq([220], inf)
    \freq, Pseq([440 * 1], inf) + (Pwhite(-50, 50, inf)),
    \filt, 10000
).play(quant: [1, 0.125]);
)

Pseries(0, 0.1, 20).asStream.nextN(20).mirror[20]


(
var build = Pseries(0, 0.0125, 160).asStream.nextN(160);
var release = build.reverse.stutter(4);
var amps = build ++ release;
~pizc.stop;
~pizc = Pbind(
    \instrument, \pebble,
    // \dur, Pwhite(0.001, 0.5, 40),
    \dur, Pseq([0.125 * 0.0625] * 0.5, inf) * Pwhite(0.8, 1.2, inf),
    \amp, Pseq(amps, inf) * 1,
    // \rate, Pwhite(0.25, 2, 40)  * 8,
    // \freq, Pseq([220], inf)
    \freq, Pseq([440 * 1], inf) + (Pwhite(-50, 50, inf)),
    \filt, 5000
).play(quant: [1, 0.125]);
)

[0, 1, 2].reverse


(
var build = Pseries(0, 0.0125, 160).asStream.nextN(160);
var release = build.reverse.stutter(4);
var amps = build ++ release;
~pizc.stop;
~pizc = Pbind(
    \instrument, \pebble,
    // \dur, Pwhite(0.001, 0.5, 40),
    \amp, Pseq(amps, inf) * 1,
    \dur, Pseq([0.125 * 0.0625] * 0.5, inf) * Pwhite(0.8, 1.2, inf) * (2 - Pkey(\amp)),
    // \rate, Pwhite(0.25, 2, 40)  * 8,
    // \freq, Pseq([220], inf)
    \freq, Pseq([440 * 1], inf) + (Pwhite(-50, 50, inf)),
    \filt, 7000
).play(quant: [1, 0.125]);
)


(
SynthDef.new(\pebble, {
    arg freq = 880, amp = 1, filt = 5000;
    var f = freq * 8;
    var env = EnvGen.kr(Env.new([0, 1, 0.0125, 0], [0.001, 0.01, 0.001], [3, -3, -3]), doneAction: 2);
    // var op1 = SinOsc.ar(f * [1, 1.001]) * 0.1;
    // var sig = Impulse.ar(0.1, mul: 0.4)!2;
    var op1 = WhiteNoise.ar(1!2) * 0.1;
    // sig = Ringz.ar(sig, [freq, freq + 2], 0.125);
    op1 = LPF.ar(op1, 60 + (1800 * amp));
    op1 = HPF.ar(op1, filt + Rand(0, 10));
    Out.ar(0, op1 * env * amp);
}).add;
)

(
var build = Pseries(0, 0.0125 * 2, 80).asStream.nextN(80);
var release = build.reverse.stutter(2);
var amps = build ++ release;
~pizd.stop;
~pizd = Pbind(
    \instrument, \pebble,
    // \dur, Pwhite(0.001, 0.5, 40),
    \amp, Pseq(amps, inf) * 1,
    \dur, Pseq([0.125 * 0.0625] * 0.5, inf) * Pwhite(0.8, 1.2, inf) * (2 - Pkey(\amp)),
    // \rate, Pwhite(0.25, 2, 40)  * 8,
    // \freq, Pseq([220], inf)
    \freq, Pseq([440 * 1], inf) + (Pwhite(-50, 50, inf)),
    \filt, 7000
).play(quant: [1, 0.125]);
)
(
var build = Pseries(0, 0.0125 * 2, 80).asStream.nextN(80);
var release = build.reverse.stutter(4);
var amps = build ++ release;
~pizdh.stop;
~pizdh = Pbind(
    \instrument, \pebble,
    // \dur, Pwhite(0.001, 0.5, 40),
    \amp, Pseq(amps, inf) * 1,
    \dur, Pseq([0.125 * 0.0625] * 0.5, inf) * Pwhite(0.8, 1.2, inf) * (2 - (Pkey(\amp) * 0.75)),
    // \rate, Pwhite(0.25, 2, 40)  * 8,
    // \freq, Pseq([220], inf)
    \freq, Pseq([440 * 1], inf) + (Pwhite(-50, 50, inf)),
    \filt, 9000
).play(quant: [1, 0.125]);
)

Pseries(0, 0.0125 * 2, 80).asStream.nextN(80).stutter(2).size
160 + 80
var rise = Pseries(1, -0.0125, 80).asStream.nextN(80) ++ (0.0125!80)

(
var build = Pseries(0, 0.0125 * 2, 80).asStream.nextN(80);
var fall = Pseries(1.025, -0.0125, 80).asStream.nextN(80);
var valley = 0.0125!80;
var rise = fall.reverse;
var counterMovement = fall ++ valley ++ rise;
var release = build.reverse.stutter(2);
var amps = build ++ release;
amps = amps;
~pizd.stop;
~pizd = Pbind(
    \instrument, \pebble,
    // \dur, Pwhite(0.001, 0.5, 40),
    \amp, Pseq(amps, inf) * 1,
    \dur, Pseq([0.125 * 0.0625] * 0.5, inf) * Pwhite(0.8, 1.2, inf) * (2 - (Pkey(\amp) * 1)),
    // \rate, Pwhite(0.25, 2, 40)  * 8,
    // \freq, Pseq([220], inf)
    \freq, Pseq([440 * 1], inf) + (Pwhite(-50, 50, inf)),
    \filt, 9000
).play(quant: [1, 0.125]);
)
(
var build = Pseries(0, 0.0125 * 2, 80).asStream.nextN(80);
var fall = Pseries(1.025, -0.0125, 80).asStream.nextN(80);
var valley = 0.0125!80;
var rise = fall.reverse;
var counterMovement = fall ++ valley ++ rise;
var release = build.reverse.stutter(2);
var amps = build ++ release;
amps = amps.reverse;
~pizdv.stop;
~pizdv = Pbind(
    \instrument, \pebble,
    // \dur, Pwhite(0.001, 0.5, 40),
    \amp, Pseq(amps, inf) * 1,
    \dur, Pseq([0.125 * 0.0625] * 0.5, inf) * Pwhite(0.8, 1.2, inf) * (2 - Pkey(\amp)),
    // \rate, Pwhite(0.25, 2, 40)  * 8,
    // \freq, Pseq([220], inf)
    \freq, Pseq([440 * 1], inf) + (Pwhite(-50, 50, inf)),
    \filt, 7000
).play(quant: [1, 0.125]);
)





// timed
// Le premier
80 * 3;
0.125 * 0.0625 * 0.5
(
var build = Pseries(0, 0.0125 * 2, 80).asStream.nextN(80);
var release = build.reverse.stutter(2);
var amps = build ++ release;
var durs = 0.00390625!240 * Pseq([Pwhite(0.8, 1.2, 240)], 240).asStream.nextN(240) * (2 - amps);
// amps = amps;
// durs = durs.normalizeSum;
durs[239] = durs[239] + (1 - durs.sum);
// durs.sum
~pizd.stop;
~pizd = Pbind(
    \instrument, \pebble,
    \amp, Pseq(amps, inf),
    \dur, Pseq(durs, inf),
    \filt, 9000
).play(quant: [2]);
)

(
var build = Pseries(0, 0.0125 * 2, 80).asStream.nextN(80);
var release = build.reverse.stutter(2);
var amps = (build ++ release).reverse;
var durs = 0.00390625!240 * Pseq([Pwhite(0.8, 1.2, 240)], 240).asStream.nextN(240) * (2 - amps);
// amps = amps;
// durs = durs.normalizeSum;
durs[239] = durs[239] + (1 - durs.sum);
durs = durs.wrapExtend(480);
durs[479] = durs[479] + 1;
// durs.sum
~pizd2.stop;
~pizd2 = Pbind(
    \instrument, \pebble,
    \amp, Pseq(amps, inf),
    \dur, Pseq(durs, inf),
    \filt, 8000
).play(quant: [2, 0.5]);
)

// Le second
(
var build = Pseries(0, 0.0125 * 2, 80).asStream.nextN(80);
var release = build.reverse.stutter(2);
var amps = (build ++ release);
var durs = 0.00390625!240 * Pseq([Pwhite(0.8, 1.2, 240)], 240).asStream.nextN(240) * (2 - amps);
// amps = amps;
// durs = durs.normalizeSum;
durs[239] = durs[239] + (1 - durs.sum);
// durs.sum
~pizdb.stop;
~pizdb = Pbind(
    \instrument, \pebble,
    \amp, Pseq(amps, inf),
    \dur, Pseq(durs, inf),
    \globAmp, 0.75,
    \filt, 12000
).play(quant: [2, 0.5]);
)



(
SynthDef.new(\pebble, {
    arg freq = 880, amp = 1, filt = 5000, globAmp = 1;
    var f = freq * 8;
    var env = EnvGen.kr(Env.new([0, 1, 0.0125, 0], [0.001, 0.01, 0.001], [3, -3, -3]), doneAction: 2);
    // var op1 = SinOsc.ar(f * [1, 1.001]) * 0.1;
    // var sig = Impulse.ar(0.1, mul: 0.4)!2;
    var op1 = WhiteNoise.ar(1!2) * 0.1;
    // sig = Ringz.ar(sig, [freq, freq + 2], 0.125);
    op1 = LPF.ar(op1, 60 + (1800 * amp));
    op1 = HPF.ar(op1, filt + Rand(0, 10));
    Out.ar(0, op1 * env * amp * globAmp);
}).add;
)


(
SynthDef.new(\pebbles, {
    arg freq = 880, amp = 1, filt = 5000, globAmp = 1;
    var f = freq * 8;
    var env = EnvGen.kr(Env.new([0, 1, 0.25, 0], [0.2, 0.4, 4], [3, -3, -3]), doneAction: 2);
    // var op1 = SinOsc.ar(f * [1, 1.001]) * 0.1;
    // var sig = Impulse.ar(0.1, mul: 0.4)!2;
    var op1 = WhiteNoise.ar(1!2) * 0.1;
    // sig = Ringz.ar(sig, [freq, freq + 2], 0.125);
    op1 = LPF.ar(op1, 60 + (1800 * env * 2));
    op1 = HPF.ar(op1, filt + Rand(0, 10));
    Out.ar(0, op1 * env * amp * globAmp);
}).add;
)

Synth.new(\pebbles, [\filt, 9000]);

// Le troisième
(
~pebs.stop;
~pebs = Pbind(
    \instrument, \pebbles,
    \amp, Pseq([1, 0.5] * 0.5, inf),
    \dur, Pseq([0.25], inf),
    \globAmp, 0.75,
    \filt, Pseq([9000, 7000], inf)
).play(quant: [2, 0.6]);
)