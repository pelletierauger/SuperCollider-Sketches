(
SynthDef(\wave, {
	var sig, freq, lpf, amp, dist, gate, baseEnv, sustain, feed;

	baseEnv = { |default| Env(default ! 6, [1, 0, 0, 0, 0]).asArray };

	sustain = \sustain.kr(1);
	gate = \gate.kr(1);
	dist = \dist.kr(0.5);

	freq = \freq.kr(100);
	freq = freq + EnvGen.kr(\freqMod.kr(baseEnv.(0)), gate:gate);
	freq = freq + SinOsc.ar(freq*4).range(-25, 25);

	lpf = \lpf.kr(baseEnv.(600));
	lpf = EnvGen.kr(lpf, timeScale:sustain, gate:gate).min(20000);

	amp = \ampEnv.kr(baseEnv.(1));
	amp = \amp.kr(1) * EnvGen.kr(amp, timeScale: sustain, doneAction:2, gate:gate);

	feed = LocalIn.ar(2);
	feed = Rotate2.ar(feed[0], feed[1], SinOsc.kr(1/10).range(-1, 1), Rand(0, 2));
	feed = FreqShift.ar(feed, [0.1, -0.1]) * 0.2;
	feed = LeakDC.ar(feed).tanh;

	sig = LFPulse.ar(
		freq * [1, 1.01, 1.002, 2, 4],
		{Rand(0, 0.5)} ! 3,
		amp.linlin(0, 1, 0.9, 0.2)
	);
	sig = Splay.ar(sig.scramble);
	sig = LeakDC.ar(sig);
	sig = sig + feed;
	sig = LPF.ar(sig, lpf);
	sig = CombC.ar(
		sig,
		1,
		{ SinOsc.ar(1/Rand(20, 30), Rand(0, 0.5)).range(0, 1/100) } ! 4,
		0.4
	);
	sig = Splay.ar(sig);

	sig = sig.blend(
		(sig * dist * amp).tanh,
		dist.clip(0, 1)
	);
	LocalOut.ar(sig);

	sig = sig * amp;

	Out.ar(\out.kr, sig);
}).add;

Event.addParentType(\wave, (
	instrument: \wave,

	freqMod: 0,
	lpfEnv: 200,
	ampEnv: Env.perc,

	// Fix up all of our env arguments when we're about to play our event
	finish: {
		var envParams = [\freqMod, \lpf, \ampEnv];
		envParams.do {
			|param|
			var value = currentEnvironment[param];
			if (value.isArray.not) { value = [value] };
			value = value.collect {
				|v|
				if (v.isRest) {
					v; // pass rests along...
				} {
					if (v.isKindOf(Env).not) {
						v = Env([v, v], [1]) // a continuous, fixed value envelope
					}
				};
				v.duration = 1.0; // fixed duration, we re-scale via timeScale in our synth
				v;
			};
			currentEnvironment[param] = value;
		}
	},


));

Pdef(\wave).clear;
Pdef(\wave, Pbind(
	\type, \wave,
	\dur, 1/4,

	\timingOffset, Pfunc({
		if ((thisThread.beats % 0.5) >= 0.25)
		{
			0.02
		} {
			0
		}
	}),
	\strum, 0.05,


	\scale, Scale.chromatic,
	\octave, Pseq([
		Pseq([3], 32),
		Pseq([3, 5], 32),
		Pseq([3], 32),
		Pseq([3, 6], 16),
		Pseq([3, 4], 16),
	], inf),

	\degree, Pseq([
		Prand([0, 2], 16),
		Prand([0, 3, 8], 16),
		Prand([0, 2], 16),
		Prand([-4, 3, 7], 16),
	], inf),
	\degree, (
		Pkey(\degree)
		+ Pif(
			Pfunc({ rrand(0.0, 1.0) < (1/18) }),
			24,
			0
		)
	),

	\dist, Pwrand([0.2, 0.6, 2, 5], [10, 5, 3, 1].normalizeSum, inf),

	\lpfBase, Pseg([2400, 13000, 2400], [32, 32], \exp, inf),
	\lpfSkew, { exprand(0, 5) },
	\lpfAttack, { rrand(0.0, 1.0) },
	\lpf, {
		Env(
			[~lpfBase, ~lpfBase * (1 + ~lpfSkew)],
			[~lpfAttack, 1 - ~lpfAttack] // remember, this gets reset to dur=1 later anyway
		)
	},

	\freqModAmt, Pwrand([0, 5, 90], [10, 2, 1].normalizeSum, inf),
	\freqModAmt, Pseg([0, 1, 0], [32, 32], [4, -6]).repeat * Pkey(\freqModAmt),
	\freqMod, Pfunc({
		|e|
		Env([0, [-1, 1].choose * e.freqModAmt], [1], -8)
	}),

	\longAttack, Pwnrand([0.01, 1], [10, 1].normalizeSum, inf),
	\legato, Pfunc({ |e| e.use { ( ~longAttack < 0.5).if(6, 1) } }),

	\ampEnv, Pfunc({
		|e|
		e.use { Env.perc(attackTime:~longAttack, releaseTime:1 - ~longAttack, curve:-2) }
	})
)).play;
)