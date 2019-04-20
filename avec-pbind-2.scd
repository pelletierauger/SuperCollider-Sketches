(Scale.minor.degrees+60).midicps.choose

(
p.stop;
p = Pbind(
	\instrument, \pinkTest,
	\dur, Pseq([0.6 * 4], inf),
	\frequency, (Scale.major.degrees+60).midicps.choose, inf),
).play;
)