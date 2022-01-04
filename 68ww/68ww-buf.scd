
~path = PathName.new(thisProcess.nowExecutingPath.dirname +/+ "wbbb.wav");

~path = PathName.new("/Users/guillaumepelletier/Desktop/La beauté de 2022/wbbb.wav");

~path.pathOnly.openOS

b = Buffer.read(s, ~path.fullPath);

(
x.set(\fadeTime, 0.01, \gate, 0);
y.set(\gate, 0, \fadeTime, 0.1);
x = {
    | freeze = 0 |
    var sig = PlayBuf.ar(2, b, -2.midiratio, startPos: 0, loop: 1);
    var sig2 = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.5, type: 0) * 0.5;
    var sig3 = MiRings.ar(sig, pit: 48, struct: 0.3, model: 4);
    sig = sig * 0.7 + VadimFilter.ar(sig2, 500, 0, 0) * 2;
    sig + (sig3 * 0.2) * 0.2;
}.play(fadeTime: 0);
)

(
y.set(\fadeTime, 0.01, \gate, 0);
x.set(\fadeTime, 0.01, \gate, 0);
x = {
    | freeze = 0 |
    var sig = PlayBuf.ar(2, b, -2.midiratio, startPos: 0, loop: 1);
    var sig2 = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.5, type: 0) * 0.5;
    var sig3 = MiRings.ar(sig, pit: 48, struct: 0.3, model: 4);
    sig = sig * 0.7 * VadimFilter.ar(sig2, 500, 0, 0) * 2;
    VadimFilter.ar(sig, 2000, 0, 0) * [3, 2] + (sig3 * 0.4) * 2 * 0.1;
}.play(fadeTime: 0);
)

(
{
    x.set(\fadeTime, 0.1, \gate, 0);
    x = {
        | freeze = 0 |
        var sig = PlayBuf.ar(2, b, -2.midiratio, startPos: 0, loop: 1);
        var sig2 = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.5, type: 0) * 0.5;
        var sig3 = MiRings.ar(sig, pit: 48, struct: 0.3, model: 4);
        sig = sig * 0.7 + VadimFilter.ar(sig2, 500, 0, 0) * 2;
        sig + (sig3 * 0.2) * 0.2;
    }.play(fadeTime: 0);
    0.005.wait;
    y.set(\fadeTime, 0.1, \gate, 0);
    y = {
        | freeze = 0 |
        var sig = PlayBuf.ar(2, b, -2.midiratio, startPos: 0, loop: 1);
        var sig2 = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.5, type: 0) * 0.5;
        var sig3 = MiRings.ar(sig, pit: 48, struct: 0.3, model: 4);
        sig = sig * 0.7 * VadimFilter.ar(sig2, 500, 0, 0) * 2;
        sig = VadimFilter.ar(sig, 2000, 0, 0) * [4, 2] * (sig3 * 0.2) * 16;
        sig = sig + (VadimFilter.ar(sig.reverse, 1000, 0, 5) * 8 * 1) * 0.2;
    }.play(fadeTime: 0);
}.fork;
)


// Très doux, feutré, velour

(
[~noLowB].do({|i| i.set(\gate, 0, \fadeTime, 1)});

~nT.sched(~nT.timeToNextBeat(quant: 1), {
    ~noLowB = {
        var trig = Impulse.ar((1 / (~nT.beatDur)));
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0], inf));
        var notes = Demand.ar(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.ar(trig, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.ar(trig * block, 0, Dseq([0, 0], inf));
        var pitch = Demand.ar(trig * block, 0, Dseq([0, -5].stutter(2), inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 24 + 7 - 12 + 7 + pitch,
            timbre: 0.5,
            color: 0.0 + [0, 0.01],
            model: 0,
            resamp: 2,
            decim: 32,
            bits: 16,
            ws: 0
        );
        // sig = LPF.ar(sig, 4000);
        sig = sig * 0.6;
        sig = MiRings.ar(sig,
            pit: 36 + 2 + 7 + 2 - 2 - 12 * [1, 1.005],
            struct: 0.1,
            bright: 0.75,
            // pos: 0,
            model: 1
        ) * 0.1;
        sig * 4 * 4 * 0.2 ;
    }.play(fadeTime: 0.1);
});
)

// Très doux, feutré

(
[~noLowB].do({|i| i.set(\gate, 0, \fadeTime, 1)});

~nT.sched(~nT.timeToNextBeat(quant: 1), {
    ~noLowB = {
        var trig = Impulse.ar((1 / (~nT.beatDur)));
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0], inf));
        var notes = Demand.ar(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.ar(trig, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.ar(trig * block, 0, Dseq([0, 0], inf));
        var pitch = Demand.ar(trig * block, 0, Dseq([0, -5].stutter(2), inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 24 + 7 - 12 + 7 + pitch,
            timbre: 0.5,
            color: 0.0 + [0, 0.01],
            model: 0,
            resamp: 2,
            decim: 32,
            bits: 16,
            ws: 0
        );
        // sig = LPF.ar(sig, 4000);
        sig = sig * 0.6;
        sig = MiRings.ar(sig,
            pit: 36 + 2 + 7 + 2 - 2 - 12 * [1, 1.005],
            struct: 0.4,
            bright: 1,
            // pos: 0,
            model: 1
        ) * 0.1;
        [sig[1], sig[0]] * 8 * 0.2;
    }.play(fadeTime: 0.1);
});
)


(
    y.set(\fadeTime, 0.1, \gate, 0);
    y = {
        | freeze = 0 |
        var sig = PlayBuf.ar(2, b, -2.midiratio, startPos: 0, loop: 1);
        var sig2 = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.5, type: 0) * 0.5;
        var sig3 = MiRings.ar(sig, pit: 48, struct: 0.3, model: 4);
        sig = sig * 0.7 * VadimFilter.ar(sig2, 500, 0, 0) * 2;
        sig = VadimFilter.ar(sig, 5000, 0, 0) * [4, 2] * (sig3 * 0.2) * 16;
        sig = sig + (VadimFilter.ar(sig.reverse, 4000, 0, 5) * 8 * 8);
    sig * 0.5 + MiRings.ar(sig, pit: 24 + 7, struct: 0.3, model: 4) * 0.1;
    }.play(fadeTime: 0);

    x.set(\fadeTime, 0.1, \gate, 0);
    x = {
        | freeze = 0 |
        var sig = PlayBuf.ar(2, b, -2.midiratio, startPos: 0, loop: 1);
        var sig2 = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.5, type: 0) * 0.5;
        var sig3 = MiRings.ar(sig, pit: 48, struct: 0.3, model: 4);
        sig = sig * 0.7 + VadimFilter.ar(sig2, 500, 0, 0) * 2;
        sig + (sig3 * 0.2) * 0.1;
    }.play(fadeTime: 0);
)



// -----------------------------------------------------------
// Drone modder
// -----------------------------------------------------------

~nT = TempoClock.new(1.39 * 1.25 * 1.075).permanent_(true);

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~lushZ.set(\pulseGate, 0, \gate, 0, \fadeTime, 10.1);
    ~lushZ = {
        | pulseGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.125 * 0.5) * pulseGate;
        var sig = MiBraids.ar(
            42 - 12 + 3 + Demand.kr(t, 0, Dseq([0, -5], inf)),
            timbre: 0.89,
            color: 0.8 + 0,
            model: 43,
            resamp: 0,
            decim: 32,
            bits: 2,
            ws: 0
        );
        sig = sig * Line.ar(0, 1, 0.1);
        sig = VadimFilter.ar(sig, 100 + In.kr(~kB, 1), resonance: 0.25, type: 1);
        sig = sig * 4!2 * 0.2;
    }.play(fadeTime: 3);
});
)

~kB = Bus.control(s, 1);

{Out.kr(~kB, EnvGen.kr(Env([0, 1000, 0], [5, 15] * 0.1), doneAction: 2))}.play;

~lushZ.set(\press, 2000);
~lushZ.set(\press, 0);

~polly = {In.kr(~kB, 1).poll}.play;
~polly.free;


(
~droneModder = Task {
    {
        {
            var rise = [100, 500, 1000].choose;
            var dec = [15, 5, 1].choose;
            var env = EnvGen.kr(Env([0, rise, 0], [5, dec] * 0.1), doneAction: 2);
            Out.kr(~kB, env);
        }.play;
        [1, 2, 4].choose.wait;
    }.loop;
}.start(~nT, quant: [4]);
)
~droneModder.stop;