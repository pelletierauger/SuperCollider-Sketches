// "https://sccode.org/1-5cM"

(
SynthDef("plucking", {arg out = 0, amp = 0.1, freq = 440, decay = 5, coef = 0.1;
	var env, snd;
	env = EnvGen.kr(Env.linen(0, decay, 0), doneAction: 2);
	snd = Pluck.ar(
		in: PinkNoise.ar(amp),
		trig: Impulse.kr(0),
		maxdelaytime: 0.1,
		delaytime: freq.reciprocal,
		decaytime: decay,
		coef: coef);
	snd = LeakDC.ar(snd).clip2;
	Out.ar(out, snd * env);
}).add;

b = Bus.audio(s,1);

SynthDef("reverbBus", { arg outBus = 0, inBus, wet = 0.5;
	var input, rev;
	input = In.ar(inBus,1);
	rev = JPverb.ar(input * wet, t60:3);
    Out.ar(outBus, input + rev);
}).add;
)


( // start reverb at the end of the group
~reverb = Synth("reverbBus", [\inBus, b, \wet, 0.6]);

Pbind(
	\instrument, "plucking",
	\out, b,
	\scale, Scale.major.tuning_(\just),
	\octave, 4,
	\degree, Pseq([1,3,7,8,Prand([7,10,11,13,14]),8,7,3], inf),
	\dur, Pseq([Pwrand([
		Pseq([0.2,0.2]),
		//0.2,
		0.4,
		Pseq([0.1],4),
		Pseq([0.05],4)],
		[0.5,0.3,0.1,0.1] // weights
	)], 240),
	\coef, Pwrand([0.8, 0.6, 0.4, 0.2], [0.4,0.3,0.2,0.1], inf),
	\amp, 1,
	\addAction, 0, // make sure new synths are added to head of group (optional)
).play;
)

// set reverb 'wetness'
~reverb.set(\wet,0);

( // set tempo
var bpm = 50;
t = TempoClock.default;
t.tempo_(bpm/60) // beats per minute
)