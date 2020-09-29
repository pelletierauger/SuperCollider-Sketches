DelayN
(
x.free;
x = {
    var trig = Delay2.kr(Impulse.kr(0));
    var amp = Demand.kr(trig, 0, Dseq(Pseries(1, -1/16, 16).asStream.nextN(16), inf));
    var sig = MiElements.ar(
        gate: trig,
        pit: 32 + 12 + 15,
        contour: 0.5,
        bow_level: 0.0,
        strike_level: 0.1 * amp,
        mallet: amp * 0.5 + 0.5,
        bow_timb: 0.5,
        bright: 0.5,
        damp: 0.4,
        geom: 0.85,
        pos: 0.15,
        space: 0.6,
        model: 1
    );
    sig * 8;
}.play;
)

(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    num.postln;
    x = {
    var trig = Delay2.kr(Impulse.kr(0));
    var env = EnvGen.kr(Env.new([0, 1, 0], [1, 4]), doneAction: 2);
    var sig = MiElements.ar(
        gate: trig,
        pit: num,
        contour: 0.5,
        bow_level: 0.0,
        strike_level: 0.1,
        mallet: 0.85,
        bow_timb: 0.1,
        bright: 0.9,
        damp: 0.9,
        geom: 0.85,
        pos: 0.15,
        space: 0.2,
        model: 1
    );
    Out.ar(~toCloud, sig * 16);
    }.play;
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)


~toCloud = Bus.audio(s, 2);

b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01-44_1.aiff");
(  // basic granulation
y.free;
y = {
    var input = In.ar(~toCloud);
    var dens = LFNoise1.kr(0.3).range(0.3, 0.45);
    var sig = MiClouds.ar(
        inputArray: input,
        pit: 0,
        pos: 0,
        size: 0,
        dens: 0.6,
        tex: 0.25,
        drywet: 1,
        in_gain: 1,
        spread: 0.5,
        rvb: 0.2,
        fb: 0.4,
        mode: 2);
    sig + (SinOsc.ar(220) * 0.0);
}.play;
)



(
// ~tClock.sched(~tClock.timeToNextBeat, {
var pul = 1.4 * 1.5;
var amp = 0.3;
q.free;
q = {
    var trig = Impulse.ar(pul);
    var sig = MiPlaits.ar(31 + 24 + 0 + [0, 0.1] + 2 - 1,
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
        HPF.ar(sig, 5000) * 0.6 * amp;
        // sig;
    }.play;
t.free;
t =
    {
    var trig = Impulse.ar(pul);
    var sig = MiPlaits.ar(31 + 24 + 5 + [0, 0.1] + 2 - 1,
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
        HPF.ar(sig, 5000) * 0.6 * amp;
        // sig;
    }.play;
)

s.record;
s.stopRecording;