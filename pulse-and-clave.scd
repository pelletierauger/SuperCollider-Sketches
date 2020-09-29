~tClock = TempoClock.new(1.4);
~tClock.permanent = true;

~pulseBus = Bus.audio(s, 1);
~pulseBus2 = Bus.audio(s, 1);
~pulseBus3 = Bus.audio(s, 1);
~pulseBus4 = Bus.audio(s, 1);

(
SynthDef(\pulse, { arg out = 0;
    var env = EnvGen.kr(Env.new([0, 1], [0.1]), doneAction: 2);
    Out.ar(out, Impulse.ar(1));
}).add;
)

~pulseSynth = Synth(\pulse, [\out, ~pulseBus]);
~pulseSynth2 = Synth(\pulse, [\out, ~pulseBus2]);
~pulseSynth4 = Synth(\pulse, [\out, ~pulseBus4]);

(
var r = Rest(1);
~pulsePatternA.stop;
~pulsePatternA = Pbind(
    \instrument, \pulse,
    \dur, Pseq([1] * 1, inf),
    \out, ~pulseBus
).play(~tClock, quant: [1]);
)
(
var r = Rest(1);
~pulsePatternB.stop;
~pulsePatternB = Pbind(
    \instrument, \pulse,
    \dur, Pseq([r, r, r, 1, r, r, 1, r] ++ [r, r, 1, r, 1, r, r, r] * 0.25, inf),
    // \dur, Pseq([1, r, r, 1, r, r, 1, r] * 0.25, inf),
    \out, ~pulseBus2
).play(~tClock, quant: [1]);
)
(
var r = Rest(1);
~pulsePatternC.stop;
~pulsePatternC = Pbind(
    \instrument, \pulse,
    \dur, Pseq([2] * 1, inf),
    \out, ~pulseBus3
).play(~tClock, quant: [1]);
)
(
var r = Rest(1);
~pulsePatternD.stop;
~pulsePatternD = Pbind(
    \instrument, \pulse,
    // \dur, Pseq([1, r, r, 1, r, r, 1, r] ++ [r, r, 1, r, 1, r, r, r] * 0.25, inf),
    // \dur, Pseq([r, r, 1, 1, r, r, 1, 1] * 0.25, inf),
    \dur, Pseq([1] * 0.25, inf),
    \out, ~pulseBus4
).play(~tClock, quant: [1]);
)
(
var ver = 1;
var i = 1.4 * 16;
k.free;
k = {
    var freq = 31 + 12 + 24 + -5 + 12 - 12 - 3 + 12;
    var trig = In.ar(~pulseBus2);
    var engine = 2, harm = 0.65, timbre = 0.25, morph = 0.45, decay = 0.15;
    var dem = Demand.ar(trig, 0, Dseq(([3]).stutter(4), inf));
    var dem2 = Demand.ar(trig, 0, Dseq(Pseries(0.5, 1/64, 64).asStream.nextN(64), inf));
    var amp = EnvGen.ar(Env.new([0, 1, 0], [0.05, 0.025]), trig);
    // var dem = 0;
    var sig1 = MiPlaits2.ar(freq + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig,
        // usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig2 = MiPlaits2.ar(freq + 0.1 + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig,
        // usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig = [sig1[0], sig2[0]] * dem2;
    // LPF.ar(sig, 3000) + MiVerb.ar(sig, mul: 0.125 * 0.5) * Line.kr(0, 1, 0.01);
    // LPF.ar(sig, 3000) * Line.kr(0, 1, 0.01);
    var verb = MiVerb.ar(sig * amp * Line.kr(0, 1, 0.1), diff: 0.95, mul: 0.125 * ver) * 0.5;
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    LPF.ar(sig * (Line.kr(0, 1, 0.001).floor), 3000) + verb * Line.kr(0, 1, 0.01) * 0.125;
    // LPF.ar(sig, 3000) + GVerb.ar(sig, mul: 0.125 * 0.25) * Line.kr(0, 1, 0.01);
}.play;
)


~buf = Buffer.read(s, "/Users/guillaumepelletier/Desktop/single/shimm.wav");
~buf.play;
~buf.numFrames
~samps = Synth(\samplerMono, [\buf, ~buf]);
(
SynthDef(\samplerMono, {
    arg buf = 0, rate = 1, pan = 0, amp = 1, rel = 4, atk = 0.1, out = 0, gate = 1;
    var sig, sig2, env, lfo, lenv;
    env = EnvGen.ar(Env.new([0.0, 1.0, 0.00001], [atk, rel], [\linear, \exponential]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: 134144 * 0.01, doneAction: 2);
    Out.ar(out, sig * 16);
}).add;
)

(
var r = Rest(1);
~shimm.stop;
~shimm = Pbind(
    \instrument, \samplerMono,
    \dur, Pseq([4], inf),
    \buf, ~buf
).play(~tClock, quant: [1]);
)

(
var ver = 1;
var i = 1.4 * 16;
l.free;
l = {
    var n = 16;
    var freq = 31 + 12 + 24 + -5 + 12 - 12 - 3 - 7 + 15 - 24;
    var trig = In.ar(~pulseBus4);
    var engine = 2, harm = 0.65, timbre = 0.25, morph = 0.45, decay = 0.15;
    var dem = Demand.ar(trig, 0, Dseq(([7, 6, 11]).stutter(n), inf));
    var dem2 = Demand.ar(trig, 0, Dseq(Pseries(0.0, 1/n, n).asStream.nextN(n), inf));
    var amp = EnvGen.ar(Env.new([0, 1, 0], [0.05, 0.025]), trig);
    var sig1 = MiPlaits2.ar(freq + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: dem2 * 0.5,
        trigger: trig,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig2 = MiPlaits2.ar(freq + 0.1 + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: dem2 * 0.5,
        trigger: trig,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig = [sig1[0], sig2[0]] * dem2;
    var verb = MiVerb.ar(sig * amp * Line.kr(0, 1, 0.1), diff: 0.95, mul: 0.125 * ver) * 0.5;
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    LPF.ar(sig * (Line.kr(0, 1, 0.001).floor), 5000) + verb * Line.kr(0, 1, 0.01) * 0.2;
}.play;
)