(
SynthDef("plucking", {arg amp = 0.1, freq = 440, decay = 5, coef = 0.1;
	var env, snd;
	env = EnvGen.kr(Env.linen(0.5, decay, 0), doneAction: 2);
	snd = Pluck.ar(
		in: BrownNoise.ar(amp),
		trig: Impulse.kr(0),
		maxdelaytime: 1.2,
        delaytime: [freq.reciprocal, freq.reciprocal * 1.001],
		decaytime: decay,
		coef: coef) * env;
	Out.ar(0, [snd[0], snd[1]]);
}).add;
)

1/11;
11.reciprocal;

Synth.new("plucking", [\freq, 220 * 24.midiratio, \coef, 0.6, \decay, 3]);


~line = Pseq([0, 4, 7, 4]);
~line = Pseq([0, 3, 7, 3]);
~line = PatternProxy(Pseq([0, 4, 7, 4]));
~line.source = Pseq([0, 3, 7, 3]);
~line.source = Pseq([0, 4, 7, 4]);
~line.quant = 4;
(
~list = [0, 3, 5, 3, 0, 3, 7, 3];
~count = 0;
~evalList = {
    var oldCount = ~list[~count];
    ~count = ~count + 1;
    if (~count > (~list.size - 1), {~count = 0});
    oldCount;
}
)
~list.size;

(
~fr.stop;
~fr = Pbind(
    \instrument, \simplest,
    \dur, Pseq([0.125, 0.0625], inf) * 4,
    \freq, 220 * Pseq([Plazy(~evalList)].midiratio, inf) * 0.midiratio,
    // \coef, Pseq([max(min(Pgeom(0.6, 1.1, 4), 0.99), 0.1)], inf),
    \decay, 0.5,
    \amp, Pseq([3, 2, 3, 2], inf) * 0.1,
    \rel, 1
).play();
)

(
Pseq(
	[
		~twinkle,
		Ppar([~drone1, ~drone2], 1),
		Ppar([~drone1, ~drone2, ~accent], 1),
		Ppar([~drone1, ~drone2, ~accent, ~high1, ~high2], 1),
		~romanianMinor,
		~melody,
		Pn(a, 16),
		Ppar([Pn(a, 4), b], 2),
		Ppar([Pn(a, 4), b, c], 1),
		Ppar([Pn(a, 4), d], 2),
		d,
		Ppar([d, Pn(e, 4)], 1),
		Pn(f, 4),
		Ppar([f, g], 4),
		Ppar([Pn(a, 4), b], 2),
		d,
		Ppar([d, Pn(e, 4)], 1),
		Pn(f, 4),
		Ppar([f, g], 4),
		Ppar([Pn(a, 4), b], 4),
		~mixolydian,
		~spanish,
		~egyptian2,
		~egyptian1,
		~egyptian3,
		~egyptian1,
		~freq1,
		Ppar([~freq1, ~siren2], 1),
		~freq3,
		Ppar([~freq2, ~siren3], 1),
		Ppar([~drone1, ~drone2, ~up, ~down], 1),
		~twinkle
	]
).play;
)

// ---------------
// PLUCK PATTERNS
// ---------------

// Twinkle
(
~twinkle = Pbind(
	\instrument, "plucking",
	\scale, Scale.major,
	\degree, Pwhite(0,12),
	\ctranspose, 36,
	\amp, Pwhite(0.5, 0.9),
	\decay, Pwhite(7, 12),
	\coef, Pwhite(0.01, 0.1),
	\dur, Prand([3/16, 3/8, 1/8, 1/16], 50);
);
)


// Melodic Minor Chords
(
Pbind(
	\instrument, "plucking",
	\scale, Scale.melodicMinor,
	\degree, Prand([
		[0, 2, 4, 6],
		[0, 2, 4, 5],
		[-4, 1, 5, 7]
	], inf),
	\amp, Pwhite(0.1, 0.2),
	\decay, Pwhite(2, 4),
	\coef, Pseq([0.2, 0.3, 0.4], inf),
	\dur, Pwrand([1/4, 1/8, 3/16], [0.8, 0.1, 0.1], inf)
).play;
)
