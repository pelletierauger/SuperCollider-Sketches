(
p.stop;
p = Pbind(
	\instrument, \pinkTest,
	\dur, Pseq([0.6 * 2, 0.3, 0.3, 0.9], inf),
	\frequency, Pseq([330, 247, 370], inf)
).play;
)
(
~pink2.stop;
~pink2 = Pbind(
	\instrument, \pinkTest,
	\dur, Pseq([0.6 * 2, 0.9, 0.6, 0.9], inf),
	\frequency, Pseq([330 * 2, 247 * 0.5, 330 * 3], inf)
).play;
)
p.stop;

(
d.stop;
d = Pbind(
	\instrument, \pulseTest,
	\dur, Pseq([1, 0.3, 0.15, 0.15, 1], inf),
	\frequency, Pseq([330, 247 * 1, 370 * 1, 165 * 3], inf)
).play;
)

(
e.stop;
e = Pbind(
	\instrument, \pulseTest,
	\dur, Pseq([0.25, 1, 0.3, 0.9 + 0.3], inf),
	\frequency, Pseq([330, 247 * 0.5, 370 * 0.5, 247], inf)
).play;
)

s.freeAll;