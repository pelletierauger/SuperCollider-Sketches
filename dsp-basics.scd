a = Array.rand(1024, -1, 1)
b = a.


~signalSize = 44100 * 3;
~sig = Signal.newClear(~signalSize);

// Creating white noise
(
~sig.do({
    |item, i|
    ~sig[i] = rand2(-1.0, 1.0) * 0.1;
});
)


(
var f = 880;
~sig.do({
    |item, i|
    var x = i / ~signalSize * 3 * 2pi;
    var modulator = sin(x * f * 0.5);
    var lfo = sin(x * 3);
    ~sig[i] = sin(x * f + (modulator * 3 * lfo)) * 0.5;
});
)


// The most basic Low Pass filter possible.
(
a.do({
    |item, i|
    if (i > 0, {
        a[i] = a[i] + a[i - 1];
    });
});
)

// A Low Pass filter with a filter coeffecient (a).
(
var a = 0.1;
~sig.do({
    |item, i|
    if (i > 0, {
        ~sig[i] = (~sig[i] * a) + (~sig[i - 1] * (1 - a));
    });
});
)

(
~sig.do({
    |item, i|
    ~sig[i] = ~sig[i] * 10;
});
)

~sig.plot;
~sig.play;
b = Buffer.loadCollection(s, ~sig, 1);
b.play;
{PlayBuf.ar(1, b, rate: 1 * 0.midiratio * [1, 1.01], doneAction: 2) * 0.1}.play;

//----------------


(
// A Low Pass filter with a time-varying filter coeffecient (a);
// Because we only consider 1 previous sample (~sig[i - 1]), this is called a
// 1st order Finite Impulse Response (FIR) Filter.
// If we considered two previous samples, it would be 2nd order, etc.
~sig.do({
    |item, i|
    var a = i.linlin(0, ~signalSize, 1, 0.01);
    if (i > 0, {
        ~sig[i] = (~sig[i] * a) + (~sig[i - 1] * (1 - a));
    });
});
)

(
// A Low Pass filter with a time-varying filter coeffecient (a);
~sig.do({
    |item, i|
    var a = i.linlin(0, ~signalSize, 0.3, 0.3);
    if (i > 0, {
        ~sig[i] = (~sig[i] * a) - (~sig[i - 1] * (1 - a));
    });
});
)

(
a.do({
    |item, i|
    a[i] = a[i] - 5 * 0.1;
});
)

(
a.do({
    |item, i|
    a[i] = sin(i * 220) * 0.4;
});
)

(
a.do({
    |item, i|
    if (i > 0, {
        if (i < (a.size - 1), {
            a[i] = (a[i - 1] + a[i + 1]) / 2;
        });
    });
});
)

// ------------------------------------------------------------------------

(
var f = 880;
~sig.do({
    |item, i|
    var x = i / ~signalSize * 3 * 2pi;
    var modulator = sin(x * f * 0.5);
    var lfo = sin(x * 3);
    ~sig[i] = sin(x * f + (modulator * 3 * lfo)) * 0.5;
});
)

// --------------A flanger------------------------------------------
(
var a = 0.5;
var d = 50;
~sig.do({
    |item, i|
    if (i > d, {
        ~sig[i] = (~sig[i] * a) + (~sig[i - d] * (1 - a));
    });
});
)
~sig.plot;
~sig.play;
b = Buffer.loadCollection(s, ~sig, 1);
b.play;
{PlayBuf.ar(1, b, rate: 1 * -12.midiratio * [1, 1.01], doneAction: 2) * 0.4}.play;

(
var a = 0.1;
var d = 50;
~sig.do({
    |item, i|
    // var a = i.linlin(0, ~signalSize, 1, 0);
    d = sin(i * 0.0001) + 1 * 25;
    if (i > d, {
        ~sig[i] = (~sig[i] * a) + (~sig[i - d] * (1 - a));
    });
});
)

