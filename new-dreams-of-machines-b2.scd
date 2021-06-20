y.set(\gate, 0, \fadeTime, 30);


[y, x, ~noLowB].do({|i| if(i.isPlaying, {i.set(\gate, 0, \fadeTime, 30)})});



if(y.isKindOf(Synth), {"oy!".postln});
y.get(\gate)
y.nodeID
y.isPlaying
y.isRunning
y.register
(
if(y.isPlaying, {y.set(\gate, 0, \fadeTime, 0.1)});
y = {
    var f = 33;
    var lfo = SinOsc.kr(0.1).range(0.1, 0.12);
    var trig = Impulse.ar(4);
    var dem = Demand.ar(trig, 0, Dseq(Pseries(0, 0.025, 16).asStream.nextN(16), inf));
    var lfo2 = SinOsc.kr(0.1, pi / 2).range(0.6, 0.6) - 0.00025;
    var dem2 = Demand.ar(trig, 0, Dseq([0, -5, -2, -7].stutter(16), inf));
    var alg = 6;
    var sig1 = MiPlaits.ar(f + dem2, alg, harm: lfo, morph: lfo2, trigger: trig, mul: 0.2);
    // var sig2 = MiPlaits.ar(f + 0.1 + dem2, alg, harm: lfo, morph: lfo2, trigger: trig, mul: 0.2);
    var sig = [sig1[0], sig1[0]] * 2;
    LPF.ar(sig, SinOsc.kr(0.1).range(800, 8000)) * 2;
    // sig;
}.play.register;
if(x.isPlaying, {x.set(\gate, 0, \fadeTime, 0.1)});
x = {
    var t = Demand.kr(Impulse.kr(4), 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0], inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.05, 1], [2, -5, 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-5, -5, -2].stutter(1), inf));
    var f = 220 * 1 * 2.midiratio;
    var car = SinOsc.ar(f * note.midiratio);
    var mod = LFTri.ar(f * note.midiratio);
    var sig = MiWarps.ar(
        carrier: car,
        modulator: mod,
        lev1: 0.95,
        lev2: 0.95,
        algo: 6,
        timb: SinOsc.kr(1).range(0.35, 0.75) + [0, 0.2],
        osc: 0,
        freq: 71
    );
    sig = [sig[0][0], sig[1][0]] * 0.5 * env;
    sig = sig * 0 + (MiRings.ar(sig,
        pit: f.cpsmidi,
        struct: Demand.kr(t, 0, Dseq([1, 0.2].stutter(6), inf)),
        bright: 1,
        damp: Demand.kr(t, 0, Dseq([0.0].stutter(6), inf)),
        pos: 1,
        model: 0,
        poly: 2
    ) * 0.35);
    // sig = LPF.ar(sig, 1400) * 16;
    // sig = sig + (LPF.ar(CombN.ar(sig, maxdelaytime: 0.05, delaytime: 0.0025, decaytime: 4) * 0.5, 200) * 32);
    // sig = CombN.ar(sig, maxdelaytime: 0.05, delaytime: 0.05, decaytime: 2) * 0.5;

    // sig[0]!2 * 0.95;

}.play(fadeTime: 0.1).register;

if(~noLowB.isPlaying, {~noLowB.set(\gate, 0, \fadeTime, 0.1)});
// ~t.sched(~t.timeToNextBeat(quant: 1), {
~noLowB = {
    var trig = Impulse.ar(0.25);
    var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0].wrapExtend(18), inf));
    var notes = Demand.ar(trig, 0,
        Dseq(32 + [0] + 0, inf)
    );
    var dem = Demand.ar(trig, 0, Dseq([0, 2], inf));
    var dem2 = Demand.ar(trig * block, 0, Dseq([0.9, 0.9], inf));
    var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
    var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
    var lfo3 = SinOsc.kr(1).range(0, 2000);
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
    var sig = MiBraids.ar(
        pitch: 36 + dem,
        timbre: dem2.lag(0.5) * 0.5,
        color: 0.0 + dem2.lag(0.5) + [0, 0.01],
        model: 42,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    );
    // sig = LPF.ar(sig, 1200) * 2;
    // sig = HPF.ar(sig, 300);
    sig * 0.75 * 0.5 * 0.4 * 8 * 0.125;
}.play(fadeTime: 10).register;
)


/*z.set(\gate, 0, \fadeTime, 0.1);
z = {
var t = Demand.kr(Impulse.kr(4), 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0], inf));
var env = EnvGen.kr(Env([0, 1, 0], [0.05, 1], [2, -5, 'lin']), t);
var note = Demand.kr(t, 0, Dseq([-5, -12, -7, -5, -12, -2], inf));
var f = 220 * 1 * 4.midiratio;
var car = SinOsc.ar(f * note.midiratio);
var mod = LFTri.ar(f * note.midiratio);
var sig = MiWarps.ar(
carrier: car,
modulator: mod,
lev1: 0.95,
lev2: 0.95,
algo: 6,
timb: SinOsc.kr(1).range(0.35, 0.75) + [0, 0.2],
osc: 0,
freq: 71
);
sig = [sig[0][0], sig[1][0]] * 0.5 * env;
sig = MiRings.ar(sig,
pit: f.cpsmidi,
struct: Demand.kr(t, 0, Dseq([1, 0.9].stutter(12), inf)),
bright: 1,
damp: Demand.kr(t, 0, Dseq([0.0, 0.5].stutter(6), inf)),
pos: 1,
model: 4,
poly: 2
) * 0.35;
HPF.ar(sig, 1000);
// sig[0]!2 * 0.95;

}.play(fadeTime: 0.1);*/

s.record;
s.stopRecording;