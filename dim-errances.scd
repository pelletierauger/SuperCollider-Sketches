(
~count = 0;
~shifts = [1, 1, 0, 0];
~globalShift = [0, 0, -1, -1];
~dimCluster = {
    var key = ~toMidi.("B3");
    var dim = key + [0, 3, 6, 9] + (~shifts * ((((~count % 2) * 2)-1) * -1));
    var nn = dim ++ (dim[3] + 12);
    nn = nn - ~globalShift[~count % 4];
    nn.postln;
    ~shifts.postln;
    if (~count + 1 % 2 == 0, {~shifts = ~shifts.rotate(-1)});
    Pbind(
        \type, \playPiano,
        \dur, Pseq(0.5!1 ++ (0.25!2) ++ [0.75, 0.5], 1),
        \num, Pseq(nn, inf),
        \dyn, Pseq([1], inf),
        \amp, Pseq([10], inf)
    ).play(t, quant: [1, -0.4]);
    ~count = ~count + 1;
};
)

1 % 2

(~shifts * ((((1 % 2) * 2)-1) * -1));
(0.5!1 ++ (0.25!2) ++ [0.75, 0.5]).sum
(
~dimClusters = Task {
    {~dimCluster.(); (2.5).wait;}.loop;
}.start(t, quant: [4]);
)
~dimClusters.stop;

[1, 2, 3, 4, 5].rotate(1).postln;
[1, 2, 3, 4, 5].rotate(-1).postln;
[1, 2, 3, 4, 5].rotate(3).postln;

~a = [1, 1, 0, 0];
~a.rotate(1)
~a



(
~count = 0;
~shifts = [[1, 1, 0, 0], [-1, -1, 0, 0]];
~globalShift = 1;
~dimCluster = {
    var key = ~toMidi.("B3");
    var dim = key + [0, 3, 6, 9].rotate(-1) + ~shifts[(~count % 2)];
    var nn = dim ++ (dim[3] + 24);
    // nn = nn - ~globalShift[~count % 4];
    // nn = nn.rotate(3);
    // nn[3] = nn[2] + 24;
    // nn.postln;
    ~shifts.postln;
    // ~shifts = ~shifts.rotate(-3);
    // if (~count + 1 % 2 == 0, {~shifts = ~shifts.rotate(-1)});
    Pbind(
        \type, \playPiano,
        \dur, Pseq(0.5!1 ++ (0.25!2) ++ [0.75, 0.5], 1),
        \num, Pseq(nn, inf),
        \dyn, Pseq(1!2 ++ (2!3), inf),
        \amp, Pseq(10!2 ++ (2!3), inf)
    ).play(t, quant: [1, -0.4]);
    if (~count == 8, {
       ~count = 0;
        ~globalShift = ~globalShift * -1;
    }, {
        ~count = ~count + 1;
    });
};
)
~count;
4 % 4
(
~shifts[0] = ~shifts[0].rotate(1);
~shifts[1] = ~shifts[1].rotate(1);
)
Pdef(\throbFreq, ~toFreq.("E3"));
Pdef(\throbFreq, ~toFreq.("E#3"));
(0.5!1 ++ (0.25!2) ++ [0.75, 0.5]).sum
(
~dimClusters = Task {
    {~dimCluster.(); (2.5).wait;}.loop;
}.start(t, quant: [4]);
)
~dimClusters.stop;

nn

x = [1, 2, 3]
x[0] = 100;
x


(
var f = ~toFreq.("D#3") * 5.midiratio;
~throb.free;
~throb = {
    var env = Env.circle([0, 1, 0.5, 0], [0.005, 0.05, 0.1, 0.125]).kr;
    var envReciprocal = 1 / env;
    var cy = SinOsc.kr(0.1).range(env * 0.25, env * 0.1);
    var op1 = SinOsc.ar(f * 1);
    var op2 = SinOsc.ar(f * 1, op1 * 25 * cy);
    var op3 = SinOsc.kr(0.1, cy * 40).range(0.25, 0.5);
    var sig = SinOsc.ar(f * [1, 1.001], op1 * op2 * 1 * op3) * 4;
    // HPF.ar(sig, 100);

    sig * env;
}.play;
)
(
var f = ~toFreq.("D#3") * 1.midiratio;
~throb2.free;
~throb2 = {
    var env = Env.circle([0, 1, 0.5, 0], [0.005, 0.1, 0.0125, 0.125]).kr;
    var envReciprocal = 1 / env;
    var cy = SinOsc.kr(0.1).range(env * 0.25, env * 0.1);
    var op1 = SinOsc.ar(f * 1);
    var op2 = SinOsc.ar(f * 1, op1 * 25 * cy);
    var op3 = SinOsc.kr(0.1, cy * 40).range(0.25, 0.5);
    var sig = SinOsc.ar(f * [1, 1.001], op1 * op2 * 1 * op3) * 4;
    // HPF.ar(sig, 100);

    sig * env;
}.play;
)

(
SynthDef.new(\throb, {
    arg freq = 440, fe1 = 25;
    var env = EnvGen.kr(Env.new([0, 1, 0.5, 0], [0.005, 0.4, 0.5]), doneAction: 2);
    var envReciprocal = 1 / env;
    var cy = SinOsc.kr(0.1).range(env * 0.25, env * 0.1);
    var op1 = SinOsc.ar(freq * 1);
    var op2 = SinOsc.ar(freq * 1, op1 * fe1 * cy);
    var op3 = SinOsc.kr(0.1, cy * 40).range(0.25, 0.5);
    var sig = SinOsc.ar(freq * [1, 1.005], op1 * op2 * 1 * op3) * 3;
    Out.ar(0, sig * env);
}).add;
)
Pdef(\throbFreq).nextN(1);
Pdef(\throbFreq, ~toFreq.("E3"));
Pdef(\throbFreq, ~toFreq.("E#3"));
(
~throbby.stop;
~throbby = Pbind(
    \instrument, \throb,
    \dur, Pseq([0.5], inf),
    \freq, Pseq([Pdef(\throbFreq)], inf) * Pseq([0.5, 1, 1, 1], inf),
    \dyn, Pseq(1!2 ++ (2!3), inf),
    \fe1, Pseq(Pseries(25, 4, 16).asStream.nextN(16), inf),
    \amp, Pseq([0.1], inf)
).play(t, quant: [2]);
)


Synth.new(\throb, [\freq, 110]);