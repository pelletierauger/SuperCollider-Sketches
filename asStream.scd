(
q.stop;
q = Pbind(
	\instrument, \bubble,
	\out, ~reverbBus,
	\dur, 2,
	\freq, 3.midiratio * 220 * 1,
	// \freq, Pwhite(60, 900, inf).round(30),
	\lon, 12,
	\amp, 0.5,
	\lfoFreq, 3
	// \spos, Pwhite(1047552 - 850000 + a, 1047552 - 840000 + a, inf).round,
	// \rate, Pseq([1 * -2.midiratio, 1 * 5.midiratio, 1 * -7.midiratio], inf),
	// \pan, Pwhite(-1, 1, inf)
).play();
)


t = TempoClock(20/60);

t.tempo;

(
q.stream = Pbind(
	\instrument, \bubble,
	\out, ~reverbBus,
	\dur, 1,
    \freq, [0.midiratio * 330, 3.midiratio * 330, 7.midiratio * 330],
	// \freq, Pwhite(60, 900, inf).round(30),
	\lon, Pseq([1, 0.5], inf),
    \amp, Pseq([1, 0.25], inf),
	\lfoFreq, Pseq([4, 12], inf)
	// \spos, Pwhite(1047552 - 850000 + a, 1047552 - 840000 + a, inf).round,
	// \rate, Pseq([1 * -2.midiratio, 1 * 5.midiratio, 1 * -7.midiratio], inf),
	// \pan, Pwhite(-1, 1, inf)
).asStream;
)