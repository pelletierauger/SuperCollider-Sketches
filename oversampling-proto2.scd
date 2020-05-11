Server.local.options.sampleRate = 48000;

~signalSize = 48000 * 20;
~sigC = Signal.newClear(~signalSize);

(
var kOversampling = 4;
var fir_coefficient = [0.02442415, 0.09297315, 0.16712938, 0.21547332];
var ds_head = 0.0;
var ds_tail = 0.0;

var accumulate = {
    |i, sample|
    ds_head = ds_head + sample * fir_coefficient[3 - (i & 3)];
    ds_tail = ds_tail + sample * fir_coefficient[i & 3];
};

var read = {
    var value = ds_head;
    ds_head = ds_tail;
    ds_tail = 0.0;
    value;
};

var car_phase = 0;

var f = 55 * 12.midiratio;
~sigC.do({
    |item, j|
    kOversampling.do({
        |item, i|
        var op1, op2, op3, ramp, ramp2, lfo;
        ramp = ((j * kOversampling) + i) / ~signalSize * 1;
        ramp2 = 1 - ramp;
        car_phase = car_phase + (1 / ~signalSize * 20 * 2pi);
        lfo = abs(sin(car_phase * 0.0625 * 0.5)).linlin(0.0, 1.0, 0.25, 1.0);
        op3 = sin(car_phase * 16 * f * kOversampling.reciprocal) * 0.25;
        op2 = sin(car_phase + op3 * 1 * f * kOversampling.reciprocal) * 0.25 * 0.125 * lfo;
        op1 = sin((car_phase + op2) * f * kOversampling.reciprocal);
        accumulate.(i, op1);
    });
    ~sigC[j] = read.();
});
f = 55 * 5.midiratio;
~sigA.do({
    |item, j|
    kOversampling.do({
        |item, i|
        var op1, op2, op3, ramp, ramp2, lfo;
        ramp = ((j * kOversampling) + i) / ~signalSize * 1;
        ramp2 = 1 - ramp;
        car_phase = car_phase + (1 / ~signalSize * 20 * 2pi);
        lfo = abs(sin(car_phase * 0.0625 * 0.5)).linlin(0.0, 1.0, 0.25, 1.0);
        op3 = sin(car_phase * 16 * f * kOversampling.reciprocal) * 0.25;
        op2 = sin(car_phase + op3 * 1 * f * kOversampling.reciprocal) * 0.25 * 0.125 * lfo;
        op1 = sin((car_phase + op2) * f * kOversampling.reciprocal);
        accumulate.(i, op1);
    });
    ~sigA[j] = read.();
});
)

~signalSize = 48000 * 20;
~sigB = Signal.newClear(~signalSize);
(
2.linlin
var f = 110;
var car_phase = 0;

~sigB.do({
    |item, i|
    var sample, modulator, ramp;
    ramp = i / ~signalSize;
    car_phase = car_phase + (1 / ~signalSize * 20 * 2pi);
    modulator = sin(car_phase * f);
    sample = sin((car_phase + (modulator * 1 * ramp)) * f);
    ~sigB[i] = sample * 0.02;
});
)



~sig.plot;

~sigB.plot;

a = Buffer.loadCollection(s, ~sigA, 1);
b = Buffer.loadCollection(s, ~sigB, 1);

c = Buffer.loadCollection(s, ~sigC, 1);
b.plot;
b.play;
(
{PlayBuf.ar(1, a, rate: 1 * 0.midiratio * [1, 1.01], doneAction: 2) * 5}.play;
{PlayBuf.ar(1, c, rate: 1 * 0.midiratio * [1, 1.01], doneAction: 2) * 2}.play;
)
{PlayBuf.ar(1, b, rate: 1 * 0.midiratio * [1, 1.01], doneAction: 2) * 5}.play;
s.record;
s.stopRecording;
4.reciprocal


(
var f = 55;
{
    var ramp = Line.kr(0, 1, 20);
    var modulator = SinOsc.ar(f * 4 * [1, 1.01]);
    SinOsc.ar(f * [1, 1.01], modulator * 25 * 2 * ramp) * 0.1;
}.play;
)

-1 * 0.midiratio * [1, 1.01]

a.numFrames;
{PlayBuf.ar(1, a, rate: -1 * [1, 1.01], startPos: 480000 * 2 - 2, doneAction: 2) * 4}.play;
{PlayBuf.ar(1, b, rate: -1 * [1, 1.01], startPos: 480000 * 2 - 2, doneAction: 2) * 5}.play;


(
var coin = [0, 1].choose;
if (coin == 0, {
    {PlayBuf.ar(1, a, rate: -1 * [1, 1.01], startPos: 480000 - 2, doneAction: 2) * 4}.play;
}, {
    {PlayBuf.ar(1, b, rate: -1 * [1, 1.01], startPos: 480000 - 2, doneAction: 2) * 5}.play;
});
["sigA", "sigB"][coin];
)


(
{PlayBuf.ar(1, a, rate: 1 * 0.midiratio * [1, 1.01], doneAction: 2) * 5}.play;
{PlayBuf.ar(1, a, rate: 1 * 5.midiratio * [1, 1.01], doneAction: 2) * 5}.play;
)

(
{PlayBuf.ar(1, a, rate: 1 * 0.midiratio * [1, 1.01], doneAction: 2) * 5}.play;
{PlayBuf.ar(1, a, rate: 1 * (1 + (1 / 3)) * [1, 1.01], doneAction: 2) * 5}.play;
)

5.midiratio

(
var f = 55;
{
    var x = Phaser.ar(f * 0.5 * [1, 1.01], 0) - 0.5 * 2pi;
    var ramp = Line.kr(0, 1, 20);
    // x;
    var modulator = [sin(x[0]), sin(x[1])];
    var sig0 = sin(x[0] + (modulator[0] * 100 * ramp)) * 0.1;
    var sig1 = sin(x[1] + (modulator[1] * 100 * ramp)) * 0.1;
    // sin(x);
    [sig0, sig1];
}.play();
)

(
var f = 55;
{
    var x = Phaser.ar(f * 0.5 * [1, 1.01], 0) - 0.5 * 2pi;
    var ramp = Line.ar(0, 1, 20);
    var op2 = sin(x);
    var op1 = sin(x + (op2 * 100 * ramp)) * 0.1;
    op1;
}.play();
)


(
{
    var sig1 = PlayBuf.ar(1, a, rate: 1 * 0.midiratio * [1, 1.01], doneAction: 2) * 5;
    var sig2 = PlayBuf.ar(1, c, rate: 1 * 0.midiratio * [1, 1.01], doneAction: 2) * 2;
    var lfo = SinOsc.ar(6).range(0, 1);
    HPF.ar(sig1 + sig2, 880) * lfo * 0.5 * Line.kr(0, 1, 4) * 20;
}.play;
)
(
{
    var trig = Impulse.ar(0.25);
    var env = EnvGen.ar(Env.new([0, 1, 0], [0.01, 4]), gate: trig);
    PlayBuf.ar(1, b, rate: 1 * 0.midiratio * [1, 1.01], trigger: trig, doneAction: 2) * 20 * env;
}.play;
)
(
{
    var trig = Impulse.ar(1);
    var env = EnvGen.ar(Env.new([0, 1, 0], [0.01, 1 - 0.01]), gate: trig);
    PlayBuf.ar(1, b, rate: 1 * 0.midiratio * [1, 1.01], trigger: trig, doneAction: 2) * 80 * env;
}.play;
)

(
{
    var f = 4;
    var fr = f.reciprocal;
    var trig = Impulse.ar(f);
    var trig2 = Impulse.ar(f * 0.125);
    var env = EnvGen.ar(Env.new([0, 1, 0], [0.01, fr - 0.01]), gate: trig);
    PlayBuf.ar(1, c, rate: 1 * 0.midiratio * [1, 1.01], trigger: trig2, doneAction: 2) * 20 * env;
}.play;
{
    var f = 1;
    var fr = f.reciprocal;
    var trig = Impulse.ar(f);
    var trig2 = Impulse.ar(f * 0.25);
    var env = EnvGen.ar(Env.new([0, 1, 0], [0.01, fr - 0.01]), gate: trig);
    PlayBuf.ar(1, a, rate: 1 * 0.midiratio * [1, 1.01], trigger: trig2, doneAction: 2) * 20 * env;
}.play;
)

(
z = {
    var f = 8;
    var fr = f.reciprocal;
    var trig = Impulse.ar(f);
    var trig2 = Impulse.ar(f * 0.0625);
    var env = EnvGen.ar(Env.new([0, 1, 0], [0.01, fr - 0.01]), gate: trig);
    PlayBuf.ar(1, d, rate: 1 * 0.midiratio * [1, 1.01], trigger: trig2, doneAction: 2) * 16 * env;
}.play;
)
z.free;

(
v = {
    var trig = Impulse.ar(1);
    var env = EnvGen.ar(Env.new([0, 1, 0], [0.01, 1 - 0.01]), gate: trig);
    PlayBuf.ar(1, b, rate: 1 * 0.midiratio * [1, 1.01], trigger: trig, doneAction: 2) * 80 * env;
}.play;
w = {
    var f = 4;
    var fr = f.reciprocal;
    var trig = Impulse.ar(f);
    var trig2 = Impulse.ar(f * 0.125);
    var env = EnvGen.ar(Env.new([0, 1, 0], [0.01, fr - 0.01]), gate: trig);
    PlayBuf.ar(1, c, rate: 1 * 0.midiratio * [1, 1.01], trigger: trig2, doneAction: 2) * 20 * env;
}.play;
x = {
    var f = 1;
    var fr = f.reciprocal;
    var trig = Impulse.ar(f);
    var trig2 = Impulse.ar(f * 0.25);
    var env = EnvGen.ar(Env.new([0, 1, 0], [0.01, fr - 0.01]), gate: trig);
    PlayBuf.ar(1, a, rate: 1 * 0.midiratio * [1, 1.01], trigger: trig2, doneAction: 2) * 20 * env;
}.play;
y = {
    var f = 8;
    var fr = f.reciprocal;
    var trig = Impulse.ar(f);
    var trig2 = Impulse.ar(f * 0.0625);
    var env = EnvGen.ar(Env.new([0, 1, 0], [0.01, fr - 0.01]), gate: trig);
    PlayBuf.ar(1, d, rate: 1 * 0.midiratio * [1, 1.01], trigger: trig2, doneAction: 2) * 16 * env;
}.play;
z = {
    var f = 4;
    var fr = f.reciprocal;
    var trig = Impulse.ar(f);
    var trig2 = Impulse.ar(8 * 0.0625);
    var env = EnvGen.ar(Env.new([0, 1, 0], [0.005, fr - 0.005]), gate: trig);
    PlayBuf.ar(1, e, rate: 1 * 0.midiratio * [1.0025, 1], trigger: trig2, doneAction: 2) * 16 * env;
}.play;
)
y.free;

(
v = {
    var f = 4;
    var fr = f.reciprocal;
    var trig = Impulse.ar(f);
    var trig2 = Impulse.ar(f * 0.125 * 1);
    var env = EnvGen.ar(Env.new([0, 1, 0], [0.05, fr - 0.05]), gate: trig);
    PlayBuf.ar(1, b, rate: 1 * 0.midiratio * [1, 1.01], trigger: trig2, doneAction: 2) * 80 * env;
}.play;
TempoClock.default.sched(0.25, {
    y = {
        var f = 2;
        var fr = f.reciprocal;
        var trig = Impulse.ar(f);
        var trig2 = Impulse.ar(f * 0.25);
        var env = EnvGen.ar(Env.new([0, 1, 0], [0.01, fr - 0.01]), gate: trig);
        PlayBuf.ar(1, d, rate: 1 * 0.midiratio * [1, 1.01], trigger: trig2, doneAction: 2) * 4 * env;
    }.play;
    nil;
});
w = {
    var f = 4;
    var fr = f.reciprocal;
    var trig = Impulse.ar(f);
    var trig2 = Impulse.ar(f * 0.125);
    var env = EnvGen.ar(Env.new([0, 1, 0], [0.01, fr - 0.01]), gate: trig);
    PlayBuf.ar(1, c, rate: 1 * 0.midiratio * [1, 1.01], trigger: trig2, doneAction: 2) * 10 * env;
}.play;
x = {
    var f = 1;
    var fr = f.reciprocal;
    var trig = Impulse.ar(f);
    var trig2 = Impulse.ar(f * 0.25);
    var env = EnvGen.ar(Env.new([0, 1, 0], [0.01, fr - 0.01]), gate: trig);
    PlayBuf.ar(1, a, rate: 1 * 0.midiratio * [1, 1.01], trigger: trig2, doneAction: 2) * 10 * env;
}.play;

)

w.free;
(
v = {
    var f = 4;
    var dec = 0.1;
    var fr = f.reciprocal;
    var trig = Impulse.ar(f);
    var dem = Demand.ar(trig, 0, Dseq([0, -5].stutter(8), inf));
    var trig2 = Impulse.ar(f * 0.125 * 0.5);
    var env = EnvGen.ar(Env.new([0, 1, 0.125, 0], [0.05, dec, fr - 0.05 - dec]), gate: trig);
    PlayBuf.ar(1, b, rate: 1 * 0.midiratio * [1, 1.01], trigger: trig2, doneAction: 2) * 40 * env;
}.play;
w = {
    var f = 4;
    var fr = f.reciprocal;
    var trig = Impulse.ar(f);
    var dem = Demand.ar(trig, 0, Dseq([1, 0.5], inf));
    var trig2 = Impulse.ar(f * 0.125 * 0.25);
    var env = EnvGen.ar(Env.new([0, 1, 0], [0.01, fr - 0.01]), gate: trig);
    PlayBuf.ar(1, c, rate: 1 * 0.midiratio * [1, 1.01], trigger: trig2, doneAction: 2) * dem * 5 * env;
}.play;
TempoClock.default.sched(0.5, {
x = {
    var f = 1;
    var fr = f.reciprocal;
    var dec = 0.0125 * 0.5 * 32;
    var trig = Impulse.ar(f);
    var trig2 = Impulse.ar(f * 0.25);
    var env = EnvGen.ar(Env.new([0, 1, 0.125, 0], [0.0625, dec, 0.75 - 0.0625 - dec]), gate: trig);
    PlayBuf.ar(1, a, rate: 1 * 0.midiratio * [1, 1.01], trigger: trig2, doneAction: 2) * 30 * env;
}.play;
        nil;
});
)

w.free;
(
y = {
    var f = 2;
    var fr = f.reciprocal;
    var trig = Impulse.ar(f);
    var trig2 = Impulse.ar(f * 0.125);
    var env = EnvGen.ar(Env.new([0, 0, 1], [0.2, fr + 1]), gate: trig);
    PlayBuf.ar(1, d, rate: 1 * 0.midiratio * [1, 1.01], trigger: trig2, doneAction: 2) * 16 * env;
}.play;
)