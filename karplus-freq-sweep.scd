(
MIDIIn.removeFuncFrom(\control, ~control);
~control = {arg ... args;
    // args[2].postln;
    // if (args[2] == 74, {x.set(\struct, args[3]/128)});
    if (args[2] == 71, {~rel = (args[3]/128).linlin(0.0, 1.0, 0.0625, 16)});
    ~rel.postln;
};
MIDIIn.addFuncTo(\control, ~control);
)

(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    // if (num >= 60, {
        Synth.new(\ks_guitar, [\note, num.midicps, \rel, 16, \buf, c, \rate, ~rel]);
// }, {
    // x.set(\bright, vel/128);
    // x.set(\pit, num);
    // Synth.new(\guitar, [\out, ~pluckBus]);
// });
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)

(
SynthDef(\ks_guitar, { arg buf = b, spos = 0.0, rel = 0.01, rate = 1.0, note, pan = 0, rand = 0.1, delayTime = 16, noiseType=1;

	var x, x2, y, env, sig, sig2;
	    env = EnvGen.kr(Env.new([0, 1, 0], [0.001, 0.001], ['lin', -8]));
    spos = Rand(0.1, 0.9);
    spos = 0.35 - (Rand(4, 4).round * 0.01);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    sig2 = PlayBuf.ar(2, buf, rate * 2 * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    sig = sig * env;
    sig2 = sig2 * env;
	// A simple exciter x, with some randomness.
    // x = Decay.ar(Impulse.ar(0, 0, rand), 0.1+rand, WhiteNoise.ar);
 	x = CombL.ar(sig, 0.05, note.reciprocal, delayTime);
 	x2 = CombL.ar(sig2, 0.05, note.reciprocal, delayTime);
    // x = SinOsc.ar(note!2, x * 100 + (SinOsc.ar(note) * 40) % 2pi) * x * 1;
	x = Pan2.ar(x, pan) * SinOsc.ar(8, 0).range(0.25, 1);
    x2 = Pan2.ar(x2, pan) * SinOsc.ar(8, pi).range(0.25, 1);// * Line.kr(0, 1, 0.1);
    Line.kr(0, 1, 10, doneAction: 2);
	Out.ar(0, LeakDC.ar(x + x2) * 5 * 4 * 4 * 0.1 * Line.kr(0, 1, 0.1));
}).add;
)

(
SynthDef(\ks_guitar, { arg buf = b, spos = 0.0, rel = 0.01, rate = 1.0, note, pan = 0, rand = 0.1, delayTime = 16, noiseType=1;

	var x, y, env, sig;
	    env = EnvGen.kr(Env.new([0, 1, 0], [0.001, 0.001], ['lin', -8]));
    spos = Rand(0.1, 0.9);
    spos = 0.35 - (Rand(4, 4).round * 0.01);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    sig = sig * env;
	// A simple exciter x, with some randomness.
    // x = Decay.ar(Impulse.ar(0, 0, rand), 0.1+rand, WhiteNoise.ar);
 	x = CombL.ar(sig, 0.05, note.reciprocal, delayTime);
    // x = SinOsc.ar(note!2, x * 100 + (SinOsc.ar(note) * 40) % 2pi) * x * 1;
	x = Pan2.ar(x, pan); // * Line.kr(0, 1, 0.1);
    Line.kr(0, 1, 10, doneAction: 2);
	Out.ar(0, LeakDC.ar(x) * 5 * 4 * 4 * 0.1 * Line.kr(0, 1, 0.1));
}).add;
)

(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    // if (num >= 60, {
        Pbind(\instrument, \ks_guitar,
        \dur, 0.5,
        \note, num.midicps,
        \rel, 16,
        \buf, c,
        \rate, Pseq(Pgeom(0.0625, 2, 10).asStream.nextN(10), 1)
    ).play;
// }, {
    // x.set(\bright, vel/128);
    // x.set(\pit, num);
    // Synth.new(\guitar, [\out, ~pluckBus]);
// });
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)
