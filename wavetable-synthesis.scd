~sig = Signal.newClear(513);
(
~sig.waveFill({
    arg x, y, i;
    // i.linlin(0, 512, -1, 1);
    // sin(x);
    sin(x.cubed * 20);
}, 0, 1);
~sig.plot;
~w = ~sig.asWavetableNoWrap;
~b = Buffer.loadCollection(s, ~w);
)

(
~sig = Signal.fill(256, { |i|
    var t = i/255.0;
    t + (0.1 * (max(t, 0.1) - 0.1) * sin(2pi * t * 80 + sin(2pi * 25.6 * t)))
})
);

VOsc3
~w.plot;
~b.plot;
(
{
    var sig, index, index2, fond;
    fond = 440 * -12.midiratio;
    index = SinOsc.ar(fond) * SinOsc.kr(0.1, mul:0.5, add:0.5).range(0.25, 1);
    index2 = SinOsc.ar(fond + 0.1) * SinOsc.kr(0.11, mul:0.5, add:0.5).range(0.25, 1);
    sig = Shaper.ar(~b.bufnum, [index, index2]);
    // sig = sig + Shaper.ar(~b.bufnum, index2) * 0.5;
    sig = LeakDC.ar(sig * 0.3);
}.play;
)

s.scope;

(
// from: "https://sc-users.bham.ac.narkive.com/HvlQRbrf/wave-shaping-transfer-function-using-shaper"
~bernie = { arg x; (20.48 * (x ** 11)) - (43.52 * (x ** 9)) + (12.8 * (x ** 8))
+ (40.32 * (x ** 7)) - (16 * (x ** 6)) - (17.44 * (x ** 5)) + (7.2 * (x **
4)) + (3.6 * (x ** 3)) - (1.82 * (x ** 2)) - (1.27 * x) - 0.3 };
)

(
~sig.waveFill(~bernie, 0, 1);
)