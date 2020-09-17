(
SynthDef.new(\bardane, {
    arg freq = 440;
    var f = freq;
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 8], [3, -3]), doneAction: 2);
    var env2 = Env.new([0, 1, 0], [0.01, 4], [3, -7]).kr;
    var lfo = SinOsc.ar(4, [0, pi]).range(0.5, 1);
    var op3 = SinOsc.ar(f * 0.25);
    var op2 = SinOsc.ar(f * 1.999, op3 * 2 * (1 - env2)) * env2;
    var op1 = SinOsc.ar(f * [1, 1.001], op2 * 1) * lfo * 0.2;
    Out.ar(0, op1 * env);
}).add;
)

(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    Synth.new(\bardane, [\freq, num.midicps]);
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)

~buf = Buffer.read(s, "/Users/guillaumepelletier/Downloads/301622__modularsamples__roland-hs-80-excessivevelocity-c5-72c4-730x.aiff");
~buf2 = Buffer.read(s, "/Users/guillaumepelletier/Downloads/301719__modularsamples__roland-hs-80-excessivevelocity-c6-84c5-yjyt.aiff");

(
SynthDef(\sNoteWarble, {
    arg buf = ~buf, rate = 1, pan = 0, amp = 1, rel = 16, atk = 0.1, out = 0, gate = 1;
    var sig, sig2, env, lfo, lenv;
    env = EnvGen.ar(Env.new([0.0, 1.0, 0.00001], [atk, rel], [\linear, \exponential]), doneAction: 2);
    sig = PlayBuf.ar(1, buf, rate * BufRateScale.ir(buf), startPos: 0, doneAction: 2);
    sig2 = PlayBuf.ar(1, ~buf2, rate * BufRateScale.ir(~buf2), startPos: 0, doneAction: 2);
    lenv = EnvGen.kr(Env.circle([0.5, 0], [0.05], [8]));
    lfo = SinOsc.kr(2).range(0.25, 1);
    sig2 = sig2 * lfo;
    sig = sig + sig2;
    sig = sig * env * amp * lenv;
    sig = Balance2.ar(sig, sig, pan, 1);
    Out.ar(out, sig);
}).add;
)
(
SynthDef(\sNote, {
    arg buf = ~buf, rate = 1, pan = 0, amp = 1, rel = 16, atk = 0.01, out = 0, gate = 1;
    var sig, sig2, env, lfo, lenv;
    env = EnvGen.ar(Env.new([0.0, 1.0, 0.00001], [atk, rel], [\linear, \exponential]), doneAction: 2);
    sig = PlayBuf.ar(1, buf, rate * BufRateScale.ir(buf), startPos: 0, doneAction: 2);
    sig2 = PlayBuf.ar(1, ~buf2, rate * BufRateScale.ir(~buf2), startPos: 0, doneAction: 2);
    lenv = EnvGen.kr(Env.circle([0.5, 0], [0.05], [8]));
    lfo = SinOsc.kr(2).range(0.25, 1);
    sig2 = sig2 * lfo;
    // sig = sig + sig2;
    sig = sig * env * amp;
    sig = Balance2.ar(sig, sig, pan, 1);
    Out.ar(out, sig);
}).add;
)

~note = Synth.new(\sNote, [\buf, ~buf, \rel, 16]);

(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    var rate = (60 - num * -1).midiratio;
    rate.postln;
    if (num > 60, {
        Synth.new(\sNoteWarble, [\buf, ~buf, \rate, rate, \amp, 2]);
    }, {
        Synth.new(\sNote, [\buf, ~buf, \rate, rate, \amp, 2]);
    });

};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)

~buf = Buffer.read(s, "/Users/guillaumepelletier/Downloads/301335__modularsamples__roland-hs-80-excessivevelocity-c2-36c1-m117.aiff");
(
SynthDef(\sNote, {
    arg buf = ~buf, rate = 1, pan = 0, amp = 1, rel = 2, atk = 0.05, out = 0, gate = 1;
    var sig, env, lfo, lenv;
    env = EnvGen.ar(Env.new([0.0, 1.0, 0.00001], [atk, rel], [\linear, \exponential]), doneAction: 2);
    sig = PlayBuf.ar(1, buf, rate * BufRateScale.ir(buf), startPos: 0.2, doneAction: 2);
    // sig2 = PlayBuf.ar(1, ~buf2, rate * BufRateScale.ir(~buf2), startPos: 0, doneAction: 2);
    lenv = EnvGen.kr(Env.circle([0.5, 0], [0.05], [8]));
    lfo = SinOsc.kr(2).range(0.25, 1);
    // sig2 = sig2 * lfo;
    // sig = sig + sig2;
    sig = sig * env * amp;
    sig = Balance2.ar(sig, sig, pan, 1);
    Out.ar(out, sig);
}).add;
)