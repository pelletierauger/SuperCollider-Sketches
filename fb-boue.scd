(
{
    var in = LocalIn.ar(2);
    var lfo = SinOsc.ar(0.1).range(0.1, 1);
    var sig = SinOsc.ar(220 * 1!2, in * lfo * 8);
    var deltimes = 0.01;
    var delSig = DelayC.ar(sig.lag(0.01), deltimes, deltimes);
    LocalOut.ar(delSig);
    // (sig[0] - sig[1]);
    sig;
}.play;
)


(
SynthDef(\boue, {
    arg buf = b, rate = 1, spos = 0, pan = 0, amp = 1, atk = 0.001, rel = 0.05, out = 0, rrate = 0;
    var in, sig, env, delSig, delTime;
    in = LocalIn.ar(2);
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel], ['lin', -8]));
    spos = Rand(0.1, 0.9);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    sig = sig.clip(-0.001, 0.001);
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    delTime = rrate.midicps.reciprocal * 0.5 * 0.midiratio;
    // delTime = 440.reciprocal;
    delTime = (ControlDur.ir * (rrate.midiratio)) * [1, 1.001];
    // delTime = (rrate.midicps.reciprocal / ControlDur.ir) * [1, 1.001];
    // delTime = 1 / (s.sampleRate / rrate.midicps);
    // delTime = (rrate.midicps * ControlDur.ir).reciprocal;
    delSig = DelayC.ar(in + sig.lag(0.001) * 0.991, delTime, delTime);
    LocalOut.ar(delSig);
    Out.ar(out, sig + delSig * 4 * EnvGen.ar(Env.new([0, 1, 0], [0.25, 2]), doneAction: 2)
    * SinOsc.kr(6).range(0.5, 1));
    (rrate.midicps / ControlDur.ir).reciprocal.poll;
}).add;
)







(
SynthDef(\boue, {
    arg buf = b, rate = 1, spos = 0, pan = 0, amp = 1, atk = 0.001, rel = 0.05, out = 0, rrate = 0;
    var in, sig, env, delSig, delTime;
    in = LocalIn.ar(2);
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel], ['lin', -8]));
    spos = Rand(0.1, 0.9);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    sig = sig.clip(-0.001, 0.001);
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    delTime = rrate.midicps.reciprocal * 0.5 * 0.midiratio;
    // delTime = 440.reciprocal;
    delTime = (ControlDur.ir * (rrate.midiratio)) * [1, 1.001];
    // delTime = (rrate.midicps.reciprocal / ControlDur.ir) * [1, 1.001];
    // delTime = 1 / (s.sampleRate / rrate.midicps);
    // delTime = (rrate.midicps * ControlDur.ir).reciprocal;
    // delSig = DelayC.ar(in + sig.lag(0.001) * 0.991, delTime, delTime);
    delSig = CombL.ar(x, 0.05, note.reciprocal, delayTime, EnvGen.ar(env, doneAction:2));
    LocalOut.ar(delSig);
    Out.ar(out, sig + delSig * 4 * EnvGen.ar(Env.new([0, 1, 0], [0.25, 2]), doneAction: 2)
    * SinOsc.kr(6).range(0.5, 1));
    (rrate.midicps / ControlDur.ir).reciprocal.poll;
}).add;
)





12.midiratio
(7.midiratio) * 7.midiratio.log
7.midiratio.log

{ ControlDur.ir.reciprocal.poll }.play;
{SinOsc.ar(ControlDur.ir.reciprocal)*0.1!2}.play
s.record;
s.stopRecording;

{SinOsc.ar(440) * 0.1!2}.play;

1 / s.sampleRate * 440

440.reciprocal
1 / 440

48.midicps.reciprocal
60.midicps.reciprocal;
72.midicps.reciprocal;

Synth.new(\boue, [\spos, 0.3, \amp, 64]);

(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    // num.postln;
    var deviation = 60 - num;
    Synth.new(\boue, [\spos, 0.3, \amp, 64, \rrate, deviation, \out, 0]);
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)