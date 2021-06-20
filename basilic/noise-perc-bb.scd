(
~k.free;
~k = {
    var t = Impulse.kr(1);
    var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
    var sig = MiBraids.ar(
        pitch: 72 - 24,
        timbre: 0.7,
        color: 0.5,
        model: 34,
        trig: t,
        resamp: 0,
        decim: 32,
        bits: 6,
        ws: 1
    );
    sig = LPF.ar(sig, 200);
    sig!2 * 0.25 * 1;
}.play;
b.free;
b = {
    var t = Impulse.kr(1);
    var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 32], [2, -8, 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
    var sig = MiBraids.ar(
        pitch: 60 - 5 - 12,
        timbre: 0.9,
        color: 0.1,
        model: 43,
        // trig: t,
        resamp: 0,
        decim: 32,
        bits: 6,
        ws: 1
    ) * env;
    sig = LPF.ar(sig, 1400 + (SinOsc.kr(0.1).unipolar * 1400));
    sig!2 * 0.25 * 0.125;
}.play;
c.free;
c = {
    var t = Impulse.kr(1, pi / 2 * 1.5);
    var note = Demand.kr(t, 0, Dseq([4, 4] * 4, inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * note], [2, -8, 'lin']), t);

    var note2 = Demand.kr(t, 0, Dseq([2, -3].stutter(4), inf));
    var sig = MiBraids.ar(
        pitch: 60 - 5 - 12 + note2,
        timbre: 0.9,
        color: 0.1,
        model: 43,
        // trig: t,
        resamp: 0,
        decim: 32,
        bits: 6,
        ws: 1
    ) * env;
    sig = LPF.ar(sig, 1400 + (SinOsc.kr(0.1).unipolar * 1400));
    sig!2 * 0.25 * 0.125;
}.play;
d.free;
d = {
    var t = Impulse.kr(0.25);
    var note = Demand.kr(t, 0, Dseq([4, 4] * 32, inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * note], [2, -8, 'lin']), t);

    var note2 = Demand.kr(t, 0, Dseq([0, -3], inf));
    var sig = MiBraids.ar(
        pitch: 60 - 5 - 12 - 7 + note2 + [0, 0.01],
        timbre: 0.9,
        color: 0.1,
        model: 43,
        // trig: t,
        resamp: 0,
        decim: 32,
        bits: 6,
        ws: 1
    ) * env;
    sig = LPF.ar(sig, 1400 + (SinOsc.kr(0.1).unipolar * 1400));
    sig * 0.25 * 0.25;
}.play;
)



//--------------------------------------
// Accomp
//--------------------------------------

(
p.free;
p = {
    var f = 28;
    var lfo = SinOsc.kr(0.1).range(0.1, 0.2);
    var alg = 5;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    [sig1[0], sig2[0]] * 8 * Line.kr(0, 1, 10) * 0.1;
}.play;
)

(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
q.free;
q = {
    var trig = Impulse.ar(10);
    var sig = MiPlaits.ar(31 + 28 + 0 + [0, 0.1],
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
        HPF.ar(sig, 5000) * 0.4;
        // sig;
    }.play;
)
(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
t.free;
t =
    {
    var trig = Impulse.ar(10);
    var sig = MiPlaits.ar(28 + 24 + 5 + [0, 0.1],
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
        HPF.ar(sig, 5000) * 0.4;
        // sig;
    }.play;
)



//--------------------------------------
// Granular
//--------------------------------------

s.sendMsg(\b_allocRead, 10, "/Users/guillaumepelletier/Desktop/0001 7-Audio-1-mono.wav");


(
j.set(\gate, 0, \fadeTime, 1);
j = {
    | low = 1, high = 1.0, pitch = -2 |
    var sig, b = 10, trate, dur, clk, pos, pan, dem, beat, melody;
    beat = Impulse.kr(0.25);
    melody = Demand.kr(beat, 0, Dseq([-5].midiratio, inf));
    trate = 16.8561;
    dur = 12 / trate;
    clk = Impulse.kr(trate * 4);
    dem = Demand.kr(clk, 0, Dseq([1, 0.5], inf)) * TRand.kr(low, high, clk);
    pos = 33.3614 + TRand.kr(0, 0.01, clk);
    pan = WhiteNoise.kr(1);
    sig = TGrains2.ar(
        numChannels: 2,
        trigger: clk,
        bufnum: b,
        rate: dem * pitch.midiratio * melody,
        centerPos: pos,
        dur: dur,
        pan: pan,
        amp: 0.1,
        att: dur * 0.3,
        dec: dur * 8,
        interp: 4
    );
    LPF.ar(sig, 18000) * 0.25 * 1;
}.play(fadeTime: 0.1);
)




//--------------------------------------
// Petits bruits pour accompagner
//--------------------------------------


(
[~noLowB].do({|i| i.set(\gate, 0, \fadeTime, 1)});

// ~t.sched(~t.timeToNextBeat(quant: 1), {
    ~noLowB = {
        var trig = Impulse.ar(1);
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0].wrapExtend(18), inf));
        var notes = Demand.ar(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.ar(trig, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.ar(trig * block, 0, Dseq([0.2, 0.9], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 2,
            timbre: dem2.lag(0.5) * 0.5,
            color: 0.0 + dem2.lag(0.5) + [0, 0.01],
            model: 1,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        );
    sig = LPF.ar(sig, 4000);
    sig = HPF.ar(sig, 300);
        sig * 0.75 * 0.5 * 0.4 * 8 * 0.25;
    }.play(fadeTime: 0.1);
// });
)



(
[~noLow].do({|i| i.set(\gate, 0, \fadeTime, 1)});

// ~t.sched(~t.timeToNextBeat(quant: 1), {
    ~noLow = {
        var trig = Impulse.ar(1);
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0].wrapExtend(18), inf));
        var notes = Demand.ar(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.ar(trig, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.ar(trig * block, 0, Dseq([0.2, 0.9], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 55 - 12,
            timbre: dem2.lag(0.5) * 0.5,
            color: 0.0 + dem2.lag(0.5) + [0, 0.01],
            model: 1,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        );
    sig = LPF.ar(sig, 4000);
    sig = HPF.ar(sig, 300);
        sig * 0.75 * 0.5 * 0.4 * 4 * 0.0625;
    }.play(fadeTime: 0.1);
// });
)
