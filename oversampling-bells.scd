Server.local.options.sampleRate = 48000;

~signalSize = 48000 * 120;
~sigA = Signal.newClear(~signalSize);
~sigB = Signal.newClear(~signalSize);

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

var f = 59.midicps * 1;
~sigA.do({
    |item, j|
    kOversampling.do({
        |item, i|
        var sample, modulator, ramp;
        ramp = ((j * kOversampling) + i) / ~signalSize;
        car_phase = car_phase + (1 / ~signalSize * 120 * 2pi);
        modulator = sin(car_phase * pi * 1.5 * f * kOversampling.reciprocal);
        sample = sin((car_phase + (modulator * 2 * ramp)) * f * kOversampling.reciprocal);
        accumulate.(i, sample);
    });
    ~sigA[j] = read.();
});
f = 59.midicps * -17.midiratio;
~sigB.do({
    |item, j|
    kOversampling.do({
        |item, i|
        var sample, modulator, ramp;
        ramp = ((j * kOversampling) + i) / ~signalSize;
        car_phase = car_phase + (1 / ~signalSize * 120 * 2pi);
        modulator = sin(car_phase * pi * 1.5 * f * kOversampling.reciprocal);
        sample = sin((car_phase + (modulator * 2 * ramp)) * f * kOversampling.reciprocal);
        accumulate.(i, sample);
    });
    ~sigB[j] = read.();
});
)

~signalSize = 48000 * 20;
~sigB = Signal.newClear(~signalSize);
(

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
b.plot;
b.play;
(
{PlayBuf.ar(1, a, rate: 1 * 0.midiratio * [1, 1.01], doneAction: 2) * 0.5}.play;
{PlayBuf.ar(1, b, rate: 1 * 0.midiratio * [1.01, 1], loop: 1) * 0.5}.play;
)
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
    var modulator = sin(x);
    sin(x + (modulator * 100 * ramp)) * 0.1;
}.play();
)
{PlayBuf.ar(1, b, rate: 1 * 0.midiratio * [1, 1.01], doneAction: 2) * 5}.play;
