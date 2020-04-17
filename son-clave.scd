t = TempoClock.new(90/60);

(
var key = ~toFreq.("C#5");
~chirps3.stop;
~chirps3 = Pbind(
    \instrument, \fancypulse,
	\dur, Pseq([3, 3, 2, Rest(2), 2, 4] * 0.25, inf),
    \freq, Pseq(key * [0].midiratio, inf),
	\pan, Pwhite(-0.5, 0.5, inf),
    \amp, 1.5,
    \out, 0
).play(t, quant: 1);
)

(
var key = ~toFreq.("C5");
~chirps3.stop;
~chirps3 = Pbind(
    \instrument, \fancypulse,
	\dur, Pseq([3, 2, 3] * 0.25, inf),
    \freq, Pseq(key * [0].midiratio, inf),
	\pan, Pwhite(-0.5, 0.5, inf),
    \amp, 1.5,
    \out, 0
).play(t, quant: 1);
)


t.tempo = 85/60
(
var key = ~toFreq.("C5");
~chirps3.stop;
~chirps3 = Pbind(
    \instrument, \fancypulse,
    \dur, Pseq([3, 2, 3] * 0.25, inf),
    \freq, Pseq(key * [7, 0, 0].midiratio, inf),
	\pan, Pwhite(-0.5, 0.5, inf),
    \amp, 1.5,
    \out, 0
).play(t, quant: 1);
)

(
var key = ~toFreq.("G4");
~chirps2.stop;
~chirps2 = Pbind(
    \instrument, \fancypulse,
    \dur, Pseq([1], inf),
    \freq, Pseq(key * [0].midiratio, inf),
	\pan, Pwhite(-0.5, 0.5, inf),
    \amp, 1.5,
    \out, 0
).play(t, quant: 1);
)