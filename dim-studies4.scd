t = TempoClock.new(90/60);
t.permanent = true;

(
~count = 0;
~shifts = [[1, 1, 0, 0], [-1, -1, 0, 0]];
~globalShift = 0;
~dimCluster = {
    var key = ~toMidi.("B3");
    var dim = key + [0, 3, 6, 9].rotate(-1) + ~shifts[(~count % 2)];
    var nn = dim ++ (dim[3] + 24);
    // nn = nn.rotate(3);
    // nn[3] = nn[2] + 24;
    // nn.postln;
    ~shifts.postln;
    // ~shifts = ~shifts.rotate(-3);
    // if (~count + 1 % 2 == 0, {~shifts = ~shifts.rotate(-1)});
    Pbind(
        \type, \playPiano,
        \dur, Pseq(0.5!1 ++ (0.25!2) ++ [0.75, 0.5], 1),
        \num, Pseq(nn + ~globalShift, inf),
        \dyn, Pseq(1!2 ++ (2!3), inf),
        \amp, Pseq(10!2 ++ (2!3), inf)
    ).play(t, quant: [1, -0.4]);
/*    Pbind(
        \type, \playPiano,
        \dur, Pseq([1], 2),
        \num, Pseq([~toMidi.("E2")], inf),
        \dyn, Pseq([1], inf),
        \amp, Pseq([4], inf)
    ).play(t, quant: [1, -0.4]);*/
    Pbind(
        \instrument, \throb,
        \dur, Pseq([1], 2),
        \freq, Pseq(~toMidi.("E2").midicps * [0, 0].midiratio, inf),
        \dyn, Pseq([1], inf),
        \amp, Pseq([4], inf)
    ).play(t, quant: [1, -0.4]);
    ~count = ~count + 1;
};
)
~count;
~globalShift = 0;
(
~shifts[0] = ~shifts[0].rotate(1);
~shifts[1] = ~shifts[1].rotate(1);
)
(
~shifts[0] = ~shifts[0].rotate(1);
~shifts[1] = ~shifts[1].rotate(1);
~globalShift = -1;
)
(
~shifts[0] = ~shifts[0].rotate(1);
~shifts[1] = ~shifts[1].rotate(1);
~globalShift = 0;
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


(
SynthDef.new(\throb, {
    arg freq = 440, fe1 = 25;
    var env = EnvGen.kr(Env.new([0, 1, 0.5, 0], [0.005, 0.1, 0.25]), doneAction: 2);
    var envReciprocal = 1 / env;
    var cy = SinOsc.kr(0.1).range(env * 0.25, env * 0.1);
    var op1 = SinOsc.ar(freq * 2);
    var op2 = SinOsc.ar(freq * 1, op1 * fe1 * cy);
    var op3 = SinOsc.kr(0.1, cy * 40).range(0.25, 0.5);
    var sig = SinOsc.ar(freq * [1, 1.005], op1 * op2 * 1 * op3) * 3;
    Out.ar(0, sig * env);
}).add;
)