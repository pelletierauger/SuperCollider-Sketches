t = TempoClock.new(90/60);
t.tempo = 118/60;
t.permanent = true;


(
// var f = 880 * 5.midiratio;
SynthDef.new(\pizzicato, {
    arg freq = 880, amp = 1;
    var f = freq;
    var env = EnvGen.kr(Env.new([0, 1, 0.0125, 0], [0.01, 0.1, 4], [3, -3, -3]), doneAction: 2);
    var env2 = Env.new([0, 1, 0], [0.01, 4], [3, -7]).kr;
    var env3 = Env.new([0, 1, 0], [0.0001, 0.025], [3, -7]).kr;
    var pEnv = Env.new([0.9, 1], [0.15], [3]).kr;
    // var

    var lfo = SinOsc.ar(4, [0, pi]).range(0.5, 1);
    var op4 = SinOsc.ar(f * 0.0625) * env3 * 10;
    var op3 = SinOsc.ar(f * 1, lfo * 12);
    var op2 = SinOsc.ar(f * 1, op4 * 12 + (op3 * 4) * (1 - env2)) * env2;
    var op5 = SinOsc.ar(f * 0.5) * 2;
    var op1 = SinOsc.ar(f * [1, 1.001] * 0.125, op2 * 1 + op4 + op5) * lfo * 0.1;
    var op6 = SinOsc.ar(f * 0.25) * 0.1;
    Out.ar(0, op1 + op6 * env * amp);
}).add;
)
(
~piz3.stop;
~piz3 = Pbind(
    \instrument, \pizzicato,
    \dur, Pseq([1, 0.5, 0.5, 1, 0.5, 0.25, 1.25, 0.25, 0.5], inf),
    \freq, 880 * -2.midiratio *
    Pseq([7].stutter(30), inf).midiratio,
    \amp, Pseq(Pgeom(1, 0.9, 30).asStream.nextN(8) * 0.75, inf) * 0.5
).play(t, quant: 2);
)

(
~hat.stop;
~hat = Pbind(
    \instrument, \pizzicato,
    \dur, Pseq([0.5 + (1/32), 0.5 - (1/32)], inf),
    \dur, Pseq([0.5], inf),
    \freq, ~toFreq.("D7") * Pseq([0], inf).midiratio,
    \amp, Pseq([2.25, 1.125, 1.5, 1.125], inf) * Pseq([1, 0.5], inf) * 0.15
).play(t, quant: 4);
)


(
~crossStick.stop;
~crossStick = Pbind(
    \instrument, \pizzicato,
    \dur, Pseq([3, 3, 2] * 0.5, inf),
    // \dur, Pseq([2, 3, 3] ++ [3, 3, 2] * 0.5, inf),
    \dur, Pseq([2, 3, 3] * 0.5, inf),
    \dur, Pseq([3, 3, 2] ++ [Rest(2), 3, 3] * 0.5, inf),
        \freq, ~toFreq.("G6") * Pseq([0], inf).midiratio,
    \amp, 2
).play(t, quant: [4]);
~kick.stop;
~kick = Pbind(
    \instrument, \pizzicato,
    \dur, Pseq([3, 1] * 0.5, inf),
        \freq, ~toFreq.("G3") * Pseq([0], inf).midiratio,
    \amp, Pseq([3, 1.5], inf) * 2
).play(t, quant: [4]);
)