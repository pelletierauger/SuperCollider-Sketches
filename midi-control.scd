(
MIDIIn.removeFuncFrom(\noteOn, ~noteOnFunc);
MIDIIn.removeFuncFrom(\noteOff, ~noteOffFunc);
MIDIIn.disconnectAll;
)

MIDIClient.init;
MIDIIn.connect;
s.boot;

(
// ~cur = ~cur + 1;
MIDIIn.removeFuncFrom(\control, ~control);
// MIDIIn.removeFuncFrom(\noteOff, ~myOff);
~control = {arg ... args;
    // ~mainCaller.value(80, 100, 10000);
    args.postln;
    if (args[2] == 32, {~cur.postln; ~cur = ~cur + 1;});
    // num.postln;
};
MIDIIn.addFuncTo(\control, ~control);
)

(
var src = 10;
var chan = 2;
var num = 3;
(src + ", " + chan + num).postln;

)


~cBus = Bus.control(s, 1);

~modBus = Bus.control(s, 1);
(
SynthDef(\lfo, { arg out = 0, freq = 1;
    var sig;
    sig = SinOsc.kr(freq).range(0.25, 1);
    Out.kr(out, sig);
}).add;
)


(
SynthDef(\mod, { arg out = 0, n = 1;
    Out.kr(out, n);
}).add;
)

~pvBus = Bus.audio(s, 2);
(
SynthDef(\verb, {arg in = 0;
    var sig = In.ar(in);
    sig = MiVerb.ar(sig);
    Out.ar(0, sig);
}).add;
)

v = Synth(\verb, ~pvBus);
x = Synth(\lfo, ~cBus);

~modSynth = Synth(\mod, ~modBus);
~modSynth.permanent = true;

(
// ~cur = ~cur + 1;
MIDIIn.removeFuncFrom(\control, ~control);
// MIDIIn.removeFuncFrom(\noteOff, ~myOff);
~control = {arg ... args;
    // ~mainCaller.value(80, 100, 10000);
    if (args[2] == 91, {
            var n = args[3] / 128;
    args.postln;
    ~modSynth.set(\n, n * 0.5);
    });

    // n.postln;
    // num.postln;
};
MIDIIn.addFuncTo(\control, ~control);
)


x.set(\freq, 10);

(
// var f = 880 * 5.midiratio;
SynthDef.new(\pizzicato, {
    arg freq = 880, amp = 1, mult = 1, pan = 0, modBus = 0, out = 0;
    var modIn = In.kr(modBus);
    var f = freq;
    var env = EnvGen.kr(Env.new([0, 1, 0.0125, 0], [0.01, 0.1, 0.5], [3, -3, -3]), doneAction: 2);
    var env2 = Env.new([0, 1, 0], [0.01, 1], [3, -7]).kr;
    var env3 = Env.new([0, 1, 0], [0.0001, 0.025], [3, -7]).kr;
    var pEnv = Env.new([0.9, 1], [0.15], [3]).kr;
    // var

    var lfo = SinOsc.ar(4, [0, pi]).range(0.5, 1);
    var op4 = SinOsc.ar(f * 0.0625) * env3 * 10;
    var op3 = SinOsc.ar(f * 1, lfo * 12);
    var op2 = SinOsc.ar(f * 1, op4 * 12 + (op3 * 4) * (1 - env2)) * env2;
    var op5 = SinOscFB.ar(f * 0.25, 0.125) * 2;
    var op1 = SinOsc.ar(f * [1, 1.001] * 0.5, op2 * mult + op4 + op5 * modIn) * lfo * 0.1;
    var op6 = SinOsc.ar(f * 0.25) * 0.1;
    var sig = op1 + op6 * env * amp;
    sig = sig * LFTri.ar(f * 0.5).range(0.92, 1);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    sig = sig + (LPF.ar(sig, 110) * 12) + (LPF.ar(sig, 55) * 24);
    Out.ar(out, sig);
}).add;
)

~modSynth.set(\n, 2);
(
MIDIIn.removeFuncFrom(\noteOn, ~note);
~note = {arg src, chan, num, vel;
{
   Pbind(
    \instrument, \pizzicato,
    \dur, Pfin(60, 0.1),
    \freq, num.midicps,
    \amp, Pgeom(1, 0.8, 60) * 1.5,
    \mult, 1.85 - (Pkey(\amp, 60) * 4.5),
    \out, 0
).play();
        "note!".postln;
}.();
};
MIDIIn.addFuncTo(\noteOn, ~note);
)

(

{
    "ah".postln;
}.();
)

(
{
   Pbind(
    \instrument, \pizzicato,
    \dur, 0.1,
    \freq, 80.midicps,
    \amp, Pgeom(1, 0.9, 60) * 1.5,
    \mult, 1.85 - (Pkey(\amp, 60) * 4.5)
).play();
}.();

)



(
// ~cur = ~cur + 1;
MIDIIn.removeFuncFrom(\noteOn, ~myOn);
// MIDIIn.removeFuncFrom(\noteOff, ~myOff);
// MIDIIn.removeFuncFrom(\noteOn, ~myOn);
// MIDIIn.removeFuncFrom(\noteOff, ~myOff);
~myOn = {arg src, chan, num, vel;
{
    var freq = num - 12;
        // var timbre = In.kr(~modBus, 1);
    var timbre = 0.25;
    var trig = Impulse.ar(0);
    var engine = 2, harm = 0.65, morph = 0.5, decay = 0.95;
        var amp = EnvGen.ar(Env.new([0.001, 1.0, 0.001], [0.001, 4], [8, 8]), doneAction: 2);
    // var dem = 0;
    var sig1 = MiPlaits.ar(freq,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig,
        // usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig2 = MiPlaits.ar(freq + 0.1,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig,
        // usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig = [sig1[0], sig2[0]] * SinOsc.kr(6).range(0.25, 1);
    var verb = sig * amp * Line.kr(0, 1, 0.1);
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    var filSig = LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo + verb * Line.kr(0, 1, 0.01) * 0.225 * 2;
    sig = filSig * amp * vel * 0.01;
}.play;


    vel.post;
};
MIDIIn.addFuncTo(\noteOn, ~myOn);
// MIDIIn.addFuncTo(\noteOff, ~myOff);
)
