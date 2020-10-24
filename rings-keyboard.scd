MiRings


c = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider-Sketches/piano-loop-2-quiet-2-48kh.aiff")


~pulseBus = Bus.audio(s, 1);

(
SynthDef(\pulse, { arg out = 0;
    var env = EnvGen.kr(Env.new([0, 1], [0.1]), doneAction: 2);
    Out.ar(out, Impulse.ar(1));
}).add;
)

~pulseSynth = Synth(\pulse, [\out, ~pulseBus]);

(
x.free;
x = {
    var pul = In.ar(~pulseBus);
    var in = LocalIn.ar(2);
    var sig = MiRings.ar(
        in: 0,
        trig: pul,
        pit: \pit.kr(60),
        struct: \pos.kr(0.7),
        bright: \bright.kr(0.5) * 0.5,
        damp: 0.4,
        pos: 0.6,
        model: 1
    );
    // sig = CombL.ar(sig + (in * 0.005), 0.05, pit.midicps.reciprocal, 3);
    sig = CombL.ar(sig, 0.05, 0.1, 3);
    /*    sig = sig + (CombL.ar(sig, 0.05, \pit.kr(60).midicps.reciprocal, 3) * 0.25
    * SinOsc.ar(3).range(0.25, 1)
    );*/
    LocalOut.ar(sig);
    // sig = CombL.ar(sig, 0.05, pit.midicps.reciprocal, 9);
    sig;
}.play
)

(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    // num.postln;
    x.set(\bright, vel/128);
    x.set(\pit, num);
    Synth.new(\pulse, [\out, ~pulseBus]);
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)

(
MIDIIn.removeFuncFrom(\control, ~control);
~control = {arg ... args;
    if (args[2] == 74, {x.set(\struct, args[3]/128);});
};
MIDIIn.addFuncTo(\control, ~control);
)

~pluckBus = Bus.audio(s, 2);




(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    // num.postln;
    x.set(\bright, vel/128);
    x.set(\pit, num);
    Synth.new(\guitar, [\out, ~pluckBus]);
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)



(
SynthDef(\guitar, { arg buf = b, out = 0, spos = 0.0, rate = 1.0, note, pan = 0, rand = 0.1, delayTime = 9, noiseType=1;
    var x, y, env, sig, in, fb, lfo;
    in = LocalIn.ar(2);
    env = EnvGen.kr(Env.new([0, 1, 0], [0.001, 0.001], ['lin', -8]), doneAction: 2);
    spos = 0.35;
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    Out.ar(out, sig * env * 16);
}).add;
)

(
x.free;
x = {
    var pul = In.ar(~pulseBus);
    var in = LocalIn.ar(2);
    var sig = MiRings.ar(
        in: In.ar(~pluckBus),
        trig: 0,
        pit: \pit.kr(60),
        struct: \struct.kr(0.7),
        // struct: SinOsc.kr(1).range(0.05, 0.95), // très beau
        bright: 0.1 + \bright.kr(0.5),
        damp: 0.4,
        pos: 0.6,
        model: 1
    );
    // sig = CombL.ar(sig + (in * 0.005), 0.05, pit.midicps.reciprocal, 3);
    sig = sig + (CombL.ar(sig, 0.05, 0.1, 3) * 0.125 * 0);
    /*    sig = sig + (CombL.ar(sig, 0.05, \pit.kr(60).midicps.reciprocal, 3) * 0.25
    * SinOsc.ar(3).range(0.25, 1)
    );*/
    LocalOut.ar(CombL.ar(sig, 0.1, 0.1, 3));
    // sig = CombL.ar(sig, 0.05, pit.midicps.reciprocal, 9);
    sig * 2;
}.play
)

~flip = 1;

(
MIDIIn.removeFuncFrom(\control, ~control);
~control = {arg ... args;
    // args[2].postln;
    if (args[2] == 63, {
        if (~flip == 1, {
            MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
            ~noteOn = {
                arg src, chan, num, vel;
                // num.postln;
                x.set(\bright, vel/128);
                x.set(\pit, num);
                Synth.new(\guitar, [\out, ~pluckBus]);
            };
            MIDIIn.addFuncTo(\noteOn, ~noteOn);
            ~flip = ~flip * -1;
        }, {
            MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
            ~noteOn = {
                arg src, chan, num, vel;
                // num.postln;
                // var deviation = 60 - num;
                Synth.new(\ks_guitar, [\note, num.midicps]);
            };
            MIDIIn.addFuncTo(\noteOn, ~noteOn);
            ~flip = ~flip * -1;
        });

    });
};
MIDIIn.addFuncTo(\control, ~control);
)

~rel = 0.01;


(
MIDIIn.removeFuncFrom(\control, ~control);
~control = {arg ... args;
    // args[2].postln;
    if (args[2] == 74, {x.set(\struct, args[3]/128)});
    if (args[2] == 71, {~rel = args[3]/128 * 2});
};
MIDIIn.addFuncTo(\control, ~control);
)

(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    if (num >= 60, {
        Synth.new(\ks_guitar, [\note, num.midicps, \rel, ~rel, \buf, c]);
    }, {
        x.set(\bright, vel/128);
        x.set(\pit, num);
        Synth.new(\guitar, [\out, ~pluckBus]);
    });
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)

b.numFrames
c.numFrames

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
SynthDef(\ks_guitar, { arg buf = b, spos = 0.0, rel = 0.01, rate = 1.0, note, pan = 0, rand = 0.1, delayTime = 9, noiseType=1;

	var x, y, env, sig;
	    env = EnvGen.kr(Env.new([0, 1, 0], [0.01, rel], ['lin', -8]));
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

e
~sy = Synth.new(\ks_guitar_b, [\buf, e, \note, ~toFreq.("D#5"), \rate, -6.midiratio]);
~sy.free;

(
SynthDef(\ks_guitar_b, {
    arg buf = e, spos = 0.0, rel = 0.01, rate = 1.0, note = 440.0, pan = 0, rand = 0.1, delayTime = 9, noiseType=1;
	var x, y, sig;
    // env = EnvGen.kr(Env.new([0, 1, 0], [0.01, rel], ['lin', -8]));
    spos = Rand(0.1, 0.9);
    spos = 0.35 - (Rand(0, 4).round * 0.01);
    sig = PlayBuf.ar(2, e, rate * BufRateScale.ir(e), startPos: spos * BufFrames.ir(e));
    // sig = sig * env;
	// A simple exciter x, with some randomness.
    // x = Decay.ar(Impulse.ar(0, 0, rand), 0.1+rand, WhiteNoise.ar);
    x = sig + (CombL.ar(sig, 0.05, note.reciprocal, delayTime) * 0.5);
    // x = SinOsc.ar(note!2, x * 100 + (SinOsc.ar(note) * 40) % 2pi) * x * 1;
	x = Pan2.ar(x, pan);
    Line.kr(0, 1, 240, doneAction: 2);
	Out.ar(0, LeakDC.ar(x) * 1);
}).add;
)