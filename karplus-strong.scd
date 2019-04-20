// we use a noise ugen to generate a burst

(

{

 var burstEnv, att = 0, dec = 0.001; //Variable declarations

 burstEnv = EnvGen.kr(Env.perc(att, dec), gate: Impulse.kr(1)); //envelope

 PinkNoise.ar(burstEnv); //Noise, amp controlled by burstEnv

}.play

)



// but then we use Comb delay to create the delay line that creates the tone





// let's create a synthdef using Karplus-Strong
(
SynthDef(\ks_guitar, { arg note, pan, rand, delayTime, noiseType=1;

	var x, y, env;

	env = Env.new(#[1, 1, 0],#[2, 0.001]);

	// A simple exciter x, with some randomness.

	x = Decay.ar(Impulse.ar(0, 0, rand), 0.1+rand, WhiteNoise.ar);

 	x = CombL.ar(x, 0.05, note.reciprocal, delayTime, EnvGen.ar(env, doneAction:2));
	x = Pan2.ar(x, pan);

	Out.ar(0, LeakDC.ar(x));

}).store;

)

// and play the synthdef

(

{

	20.do({

		Synth(\ks_guitar, [\note, 220+(400.rand),

					\pan, 1.0.rand2,

					\rand, 0.1+0.1.rand,

					\delayTime, 2+1.0.rand]);



	   (1.0.rand + 0.5).wait;

	});

}.fork

)



// here using patterns
(
a = Pdef(\kspattern,

		Pbind(\instrument, \ks_guitar, // using our sine synthdef

					\note, Pseq.new([60, 61, 63, 66], inf).midicps, // freq arg

					\dur, Pseq.new([0.25, 0.5, 0.25, 1], inf),  // dur arg

					\rand, Prand.new([0.2, 0.15, 0.15, 0.11], inf),  // dur arg

					\pan, 2.0.rand-1,

					\delayTime, 2+1.0.rand;  // envdur arg



		)

).play;
)

a.stop;