// let's create a synthdef using Karplus-Strong

(
SynthDef(\ks_guitar, { arg note, pan = 0, rand = 0.1, delayTime = 9, noiseType=1;

	var x, y, env;

	env = Env.new(#[1, 1, 0],#[2, 0.001]);

	// A simple exciter x, with some randomness.

	x = Decay.ar(Impulse.ar(0, 0, rand), 0.1+rand, WhiteNoise.ar);

 	x = CombL.ar(x, 0.05, note.reciprocal, delayTime, EnvGen.ar(env, doneAction:2));

	x = Pan2.ar(x, pan);

	Out.ar(0, LeakDC.ar(x));

}).add;
)



(
SynthDef(\ks_guitar, { arg buf = b, spos = 0.0, rate = 1.0, note, pan = 0, rand = 0.1, delayTime = 9, noiseType=1;

	var x, y, env, sig;
	    env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.01], ['lin', -8]));
    spos = Rand(0.1, 0.9);
    spos = 0.35 - (Rand(0, 4).round * 0.01);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    sig = sig * env;
	// A simple exciter x, with some randomness.
    // x = Decay.ar(Impulse.ar(0, 0, rand), 0.1+rand, WhiteNoise.ar);
 	x = CombL.ar(sig, 0.05, note.reciprocal, delayTime);
    // x = SinOsc.ar(note!2, x * 100 + (SinOsc.ar(note) * 40) % 2pi) * x * 1;
	x = Pan2.ar(x, pan);
    Line.kr(0, 1, 10, doneAction: 2);
	Out.ar(0, LeakDC.ar(x) * 5);
}).add;
)
Rand

/*(
SynthDef(\ks_guitar, { arg buf = b, spos = 0.0, rate = 1.0, note, pan = 0, rand = 0.1, delayTime = 9, noiseType=1;

	var x, y, env, sig, in, fb, lfo;
    in = LocalIn.ar(2);
	    env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.01], ['lin', -8]));
    spos = Rand(0.1, 0.9);
    spos = 0.25;
    spos = 0.1;
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    // sig = sig * env;
	// A simple exciter x, with some randomness.
    // x = Decay.ar(Impulse.ar(0, 0, rand), 0.1+rand, WhiteNoise.ar);
    fb = HPF.ar(in * 0.04 * EnvGen.ar(Env.new([0, 1, 0], [0.1, 4]), doneAction: 2), 2000);
    lfo = SinOsc.ar(2).range(1, 10);
    x = CombL.ar(sig, 0.05, note.reciprocal, delayTime);
    LocalOut.ar(x);
    x = SinOsc.ar(note!2, x * 100 % 2pi) * x * 1;
	x = Pan2.ar(x, pan);
	Out.ar(0, LeakDC.ar(x) * 10 * SinOsc.ar(6).range(0.85, 1));
}).add;
)*/

// and play the synthdef


(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    // num.postln;
    // var deviation = 60 - num;
    Synth.new(\ks_guitar, [\note, num.midicps]);
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)



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



(
SynthDef(\ks_guitar, { arg buf = b, spos = 0.0, rate = 1.0, note, pan = 0, rand = 0.1, delayTime = 9, noiseType=1;

	var x, y, env, sig, in, fb, lfo;
    in = LocalIn.ar(2);
	    env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.01], ['lin', -8]));
    spos = Rand(0.1, 0.9);
    spos = 0.25;
    spos = 0.1;
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    // sig = sig * env;
	// A simple exciter x, with some randomness.
    // x = Decay.ar(Impulse.ar(0, 0, rand), 0.1+rand, WhiteNoise.ar);
    fb = HPF.ar(in * 0.04 * EnvGen.ar(Env.new([0, 1, 0], [0.1, 4]), doneAction: 2), 2000);
    lfo = SinOsc.ar(2).range(1, 10);
    x = CombL.ar(sig + (in * 0.001), 0.05, note.reciprocal, delayTime);
    LocalOut.ar(x);
    x = SinOsc.ar(note!2, x * 100 % 2pi) * x * 1;
	x = Pan2.ar(x, pan);
	Out.ar(0, LeakDC.ar(x) * 10 * SinOsc.ar(6).range(0.85, 1));
}).add;
)