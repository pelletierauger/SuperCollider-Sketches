~signalSize = 48000 * 20;
~sigD = Signal.newClear(~signalSize);

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

var f = 55 * 19.midiratio;
~sigD.do({
    |item, j|
    kOversampling.do({
        |item, i|
        var sample, modulator, ramp;
        ramp = ((j * kOversampling) + i) / ~signalSize;
        car_phase = car_phase + (1 / ~signalSize * 20 * 2pi);
        modulator = sin(car_phase * 1 * f * kOversampling.reciprocal);
        sample = sin((car_phase + (modulator * 1 * ramp)) * f * kOversampling.reciprocal);
        accumulate.(i, sample);
    });
    ~sigD[j] = read.();
});
)

d = Buffer.loadCollection(s, ~sigD, 1);

~signalSize = 48000 * 20;
~sigE = Signal.newClear(~signalSize);

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

var f = 55 * 14.midiratio;
~sigE.do({
    |item, j|
    kOversampling.do({
        |item, i|
        var sample, modulator, ramp;
        ramp = ((j * kOversampling) + i) / ~signalSize;
        car_phase = car_phase + (1 / ~signalSize * 20 * 2pi);
        modulator = sin(car_phase * 1 * f * kOversampling.reciprocal);
        sample = sin((car_phase + (modulator * 1 * ramp)) * f * kOversampling.reciprocal);
        accumulate.(i, sample);
    });
    ~sigE[j] = read.();
});
)

e = Buffer.loadCollection(s, ~sigE, 1);