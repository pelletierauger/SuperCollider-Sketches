s.boot;
​
a = Scale.major;
a.degrees;        // [ 0, 2, 4, 5, 7, 9, 11 ]
a.semitones;        // [ 0, 2, 4, 5, 7, 9, 11 ]
a.cents;        // [ 0, 200, 300, 500, 700, 900, 1100 ]
a.ratios;        // [ 1, 1.1224620483089, 1.2599210498937, 1.3348398541685, etc. ]
​
Pbind(\scale, a, \degree, Pseq((0..7) ++ (6..0) ++ [\rest], 1), \dur, 0.25).play;
​
// use non-standard tuning
a.tuning_(\just);
a.degrees;        // no change; degrees are independent of tuning
a.semitones;        // [ 0, 2.0391000173077, 3.1564128700055, 4.9804499913461, etc. ]
a.ratios.collect(_.round(0.001));    // [ 1, 1.125, 1.2, 1.333, 1.5, 1.667, 1.875 ]
​

~tune = Tuning.et(pitchesPerOctave: 15);
~tune = Tuning.et12;

a.tuning = ~tune;

(
f = {
    a;
};
)

(
Pbind(\scale, f.value, \degree,
    Pseq([
        Pseq([[-12, 0, 4, 7]], 4),
        Pseq([[-5, -2, 4, 7]], 4),
        Pseq([[-9, -2, 2, 5]], 8)
    ], inf),
    \amp, Pseq([1.5, 0.6, 0.8, 0.6], inf),
    \sus, 8,
    \dur, Pseq([0.5, 0.5, 0.25, 0.25, 0.25], inf)
).play;
)

Tuning.default;