MIDIClient.init;
MIDIIn.connect;

(
{
    arg freq;
    var env = EnvGen.kr(Env.new([0, 0.5, 0], [0.01, 4], [1, 1]), doneAction: 2);
    var sig = MiTides.ar(freq: 110,
        shape: 0.5,
        slope: 0.5 - (env * 0.5),
        smooth: env,
        shift: 0.5,
        trig: 0,
        clock: 0,
        output_mode: 3,
        ramp_mode: 1,
        ratio: 9,
        rate: 1) * 0.1;
    sig;
}.play;
)

(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    {
        var env = EnvGen.kr(Env.new([0, 0.5, 0], [0.001, 4], [1, 1]), doneAction: 2);
        var lenv = EnvGen.kr(Env.circle([0.5, 0], [0.05], [8]));
        var env2 = EnvGen.kr(Env.new([0.5, 0.75], [4], [1, 1]));
        var lfo = SinOsc.kr(2).range(0, 0.1);
        var sig = MiTides.ar(freq: num.midicps,
            shape: env2,
            slope: 0.5 - (env * 0.5),
            smooth: lenv,
            shift: 0.5,
            trig: 0,
            clock: 0,
            output_mode: 3,
            ramp_mode: 1,
            ratio: 9,
            rate: 1) * 0.1;
        sig * env * 2 * 1 + (sig.pow(6) * 2400000 * 0 * env) * lenv;
    }.play;
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)

(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
MIDIIn.removeFuncFrom(\noteOff, ~noteOff);
)


(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    {
        var env = EnvGen.kr(Env.new([0, 0.5, 0], [0.001, 6], [1, 1]), doneAction: 2);
        var lenv = EnvGen.kr(Env.circle([0.5, 0], [0.05], [8]));
        var env2 = EnvGen.kr(Env.new([0.5, 0.75] * 0.1, [4], [1, 1]));
        var lfo = SinOsc.kr(0.5).range(0, 0.1);
        var sig = MiTides.ar(freq: num.midicps,
            shape: env2,
            slope: 0.75,
            smooth: env + lfo * 0.5,
            shift: 0.45,
            trig: 0,
            clock: 0,
            output_mode: 3,
            ramp_mode: 1,
            ratio: 9,
            rate: 1) * 0.1;
        sig * env * 4 * 3;
    }.play;
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)
~sh;
~sh = 0.5;
(
MIDIIn.removeFuncFrom(\control, ~tidesControl);
~tidesControl = {arg ... args;
    args.postln;
    if (args[2] == 71, {
        ~sh = args[3] / 128 * 0.5;
    });
    if (args[2] == 91, {
        var n = args[3] / 128;
        args.postln;
        ~modSynth.set(\n, n * 0.5);
    });
};
MIDIIn.addFuncTo(\control, ~tidesControl);
)



(
// ~tClock.sched(~tClock.timeToNextBeat, {
var pul = 1.4;
q.free;
q = {
    var trig = In.ar(~pulseBus);
    var sig = MiPlaits.ar(31 + 24 + 0 + [0, 0.1] + 2,
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        morph: SinOsc.kr(0.1).range(0.75, 0.95),
        // morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 1,
        mul: 1.25);
    HPF.ar(sig, 5000) * 0.6;
    // sig;
}.play;
t.free;
t =
{
    var trig = In.ar(~pulseBus);
    var sig = MiPlaits.ar(31 + 24 + 5 + [0, 0.1] + 2,
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        morph: SinOsc.kr(0.1).range(0.75, 0.95),
        // morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 1,
        mul: 1.25);
    HPF.ar(sig, 5000) * 0.6;
    // sig;
}.play;
/*f.free;
f =    {
var trig = In.ar(~pulseBus3);
var sig = MiPlaits.ar(31 + 24 + 2 - 7 - 12,
engine: 11,
harm: 0.25,
timbre: 0.0,
morph: SinOsc.kr(0.1).range(0, 0.95),
morph: 0.5,
trigger: trig,
usetrigger: 1,
decay: 0.1,
lpg_colour: 0,
mul: 8);
sig[0]!2;
}.play;*/
/*TempoClock.default.sched(1.4 * 0.25, {
g.free;
g =    {
var trig = Impulse.ar(1.4 * 0.25);
var sig = MiPlaits.ar(31 + 24 + 2 + 10 - 5,
engine: 11,
harm: 0.25,
timbre: 0.0,
morph: SinOsc.kr(0.1).range(0, 0.95),
morph: 0.5,
trigger: trig,
usetrigger: 1,
decay: 0.1,
lpg_colour: 0,
mul: 8);
sig[0]!2 * 0.5;
}.play;
nil;
});
});*/
)


(
f.free;
f =    {
    var trig = In.ar(~pulseBus3);
    var sig = MiPlaits.ar(31 + 24 + 2 - 7 - 12,
        engine: 11,
        harm: 0.25,
        timbre: 0.0,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 0.1,
        lpg_colour: 0,
        mul: 8);
    sig[0]!2 * 0.5;
}.play;
)