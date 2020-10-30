(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn2);
~noteOn2 = {
    arg src, chan, num, vel;
    if (num >= 60, {
        // Synth.new(\ks_guitar, [\note, (num - 0).midicps, \rel, ~rel, \buf, c, \amp, vel/128]);
    // (
            // ~piz3.stop;
/*            Pbind(
                \instrument, \ks_guitar,
                \dur, Pseq([0.0625 * 0.25], 16),
                // \amp, Pseq([1, 0.5], 16) * 3,
                \note, num.midicps,
                \rel, ~rel, \buf, c
                // \buf, Pseq([~pizziSamples[0], ~pizziSamples[2]].stutter(1), 16)
            ).play();*/
// )
        }, {
        x.set(\bright, 128/128);
        x.set(\pit, num - 0);
        Synth.new(\guitar, [\out, ~pluckBus]);
        });
};
MIDIIn.addFuncTo(\noteOn, ~noteOn2);
)
~rel = 0.1;

(
x.free;
x = {
    var freq = 31 + 12 + 24 + -5;
    var trig = In.ar(~pluckBus);
    var engine = 11, harm = 0.165, morph = SinOsc.ar(1).range(0.25, 0.25), decay = 0.9;
    var amp = EnvGen.ar(Env.new([0, 1, 0], [0.05, 0.025]), trig);
    // var dem = 0;
    var sig1 = MiPlaits.ar(\pit.kr(60),
        engine: engine,
        harm: harm,
        timbre: \timbre.kr(0.25),
        morph: morph,
        trigger: trig,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig2 = MiPlaits.ar(\pit.kr(60),
        engine: engine,
        harm: harm,
        timbre: \timbre.kr(0.25),
        morph: morph,
        trigger: trig,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig3 = MiPlaits.ar(\pit.kr(60) + 0.1,
        engine: engine,
        harm: harm + 0.1,
        timbre: \timbre.kr(0.25),
        morph: morph,
        trigger: trig,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig4 = MiPlaits.ar(\pit.kr(60) + 0.1,
        engine: engine,
        harm: harm + 0.1,
        timbre: \timbre.kr(0.25),
        morph: morph,
        trigger: trig,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig5 = MiPlaits.ar(\pit.kr(60) - 0.1,
        engine: engine,
        harm: harm + 0.1,
        timbre: \timbre.kr(0.25),
        morph: morph,
        trigger: trig,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig6 = MiPlaits.ar(\pit.kr(60) - 0.1,
        engine: engine,
        harm: harm + 0.1,
        timbre: \timbre.kr(0.25),
        morph: morph,
        trigger: trig,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig = [sig1[0] + sig3[0] + sig5[0] * 0.333, sig2[0] + sig4[0] + sig6[0] * 0.333];
    // sig;
    LPF.ar(sig, 2000) * 8;
}.play;
)


(
SynthDef(\ks_guitar, { arg buf = b, amp = 1, spos = 0.0, rel = 0.01, rate = 1.0, note, pan = 0, rand = 0.1, delayTime = 9, noiseType=1;

    var x, y, z, env, sig;
    env = EnvGen.kr(Env.new([0, 1, 0], [0.001, rel], ['lin', -8]));
    spos = Rand(0.1, 0.9);
    spos = 0.35 - (Rand(4, 4).round * 0.01);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    sig = sig * env;
    // A simple exciter x, with some randomness.
    // x = Decay.ar(Impulse.ar(0, 0, rand), 0.1+rand, WhiteNoise.ar);
    x = CombL.ar(sig, 0.05, note.reciprocal, delayTime);
    y = CombL.ar(sig, 0.05, (note + [0.25, 0.5]).reciprocal, delayTime);
    z = CombL.ar(sig, 0.05, (note - [0.5, 0.25]).reciprocal, delayTime);
    x = (x + y + z * 0.333); // * Line.ar(0, 1, 0.5);
    // x = SinOsc.ar(note!2, x * 100 + (SinOsc.ar(note) * 40) % 2pi) * x * 1;
    x = Pan2.ar(x, pan);
    Line.kr(0, 1, 10, doneAction: 2);
    Out.ar(0, LeakDC.ar(x) * 5 * 1.5 * amp * 1.5);
}).add;
)



(
SynthDef(\ks_guitar_burst, { arg buf = b, spos = 0.0, rel = 0.01, rate = 1.0, note, pan = 0, rand = 0.1, delayTime = 9, noiseType=1;

    var x, y, z, env, sig, imp;
    imp = Impulse.kr(4);
    env = EnvGen.kr(Env.new([0, 1, 0], [0.001, rel], ['lin', -8]), gate: imp);
    spos = Rand(0.1, 0.9);
    spos = 0.35 - (Rand(4, 4).round * 0.01) + SinOsc.ar(50).range(0.01, 0.02);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), imp, startPos: spos * BufFrames.ir(buf));
    sig = sig * env;
    // A simple exciter x, with some randomness.
    // x = Decay.ar(Impulse.ar(0, 0, rand), 0.1+rand, WhiteNoise.ar);
    x = CombL.ar(sig, 0.05, note.reciprocal, delayTime);
    y = CombL.ar(sig, 0.05, (note + [0.25, 0.5]).reciprocal, delayTime);
    z = CombL.ar(sig, 0.05, (note - [0.5, 0.25]).reciprocal, delayTime);
    x = (x + y + z * 0.333); // * Line.ar(0, 1, 0.5);
    x = SinOsc.ar(note * 0.25, x * 200 % 2pi) * x;
    x = LPF.ar(x, 2000);
    // x = SinOsc.ar(note!2, x * 100 + (SinOsc.ar(note) * 40) % 2pi) * x * 1;
    x = Pan2.ar(x, pan) * Line.kr(1, 0, 10, doneAction: 2);
    Out.ar(0, LeakDC.ar(x) * 5 * 1.5);
}).add;
)