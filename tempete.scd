~nT = TempoClock.new(2.7074408879193).permanent_(true);

~nT.tempo;
~nT.tempo = 2.7074408879193;
1.39 * 2 * 1.3 * -5.midiratio;

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~hats.isPlaying, {~hats.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
    ~hats = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 2) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 3.85], [2, -8, 'lin']), t);
        var d = Demand.kr(t, 0, Dseq([4, 5, 6, 5].stutter(4) - 0, inf));
        var sig = MiBraids.ar(
            pitch: 45 + 12 + [0.0, 0.1],
            timbre: 0.65 + [0.0, 0.1],
            color: 0.5,
            model: 34,
            trig: t,
            resamp: 2,
            decim: 29 + [0, 4],
            bits: d,
            ws: 0
        ) * 1 * env;
        var lfo = SinOsc.kr(0.1).range(0, 4000);
        // sig = Decimator.ar(sig, 1000, 2) * 1;
        VadimFilter.ar(sig, 100 + (10000 * env) + lfo, 0, 5) * 2;
    }.play(fadeTime: 0.05).register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~drums.isPlaying, {~drums.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 2) * trigGate;
        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0] ++ [0, 0, 1, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0] ++ [0, 0, 0, 0, 1, 1, 0, 0];
        var pat2 = [1, 1];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig, 0, Dseq(pat2, inf));
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8], inf));
        var sig = MiPlaits.ar(
            pitch: 30 + [0, 12, 12, 36] + 12,
            engine: 9,
            harm: 0.25,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0.1, 0.2] - 0,
            trigger: trig * [block0, block1, block1, block2],
            decay: [0.9, 0.8, 0.8, dec] * 0.85,
            lpg_colour: 0.75
        );
        var kickhat = sig[0][1] * 2 + (sig[3][1] * 0.35);
        var snare = [sig[1][1], sig[2][1]] * 3 * Line.kr(0, 1, ~nT.beatDur * 2);
        sig = kickhat!2 + snare;
        sig = Decimator.ar(sig, 8100, 8) * 0.5;
        sig = VadimFilter.ar(sig, 5000, 0, 1) * 0.7;
    }.play(fadeTime: 0.01).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~wind.set(\gate, 0, \fadeTime, 1);
    ~wind = {
        var sig = WhiteNoise.ar(0.525);
        var t = Impulse.kr(~nT.tempo * 0.25);
        var d = Demand.kr(t, 0, Dseq([0, 3, 8 + 1, 7 + 1] + 59 - 12, inf));
        // var sig = SinOsc.ar(100);
        VADiodeFilter.ar(
            sig, freq: d.midicps.lag(0.5),
            res: 0.75, overdrive: 0.5
        ) * 0.125!2 * Line.kr(0, 1, 2);
    }.play;
});
)

(
if(~drums.isPlaying, {~drums.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
if(~hats.isPlaying, {~hats.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
~wind.set(\gate, 0, \fadeTime, 1);
x.set(\gate, 0, \fadeTime, 10.1);
    y.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
[~billes].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});});
[~billesA].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 2.1)});});
)


s.record;
s.stopRecording;
~recordingFolder.openOS;

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~drums.isPlaying, {~drums.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
    ~drums = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 2) * trigGate;
        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0] ++ [0, 0, 1, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0] ++ [0, 0, 0, 0, 1, 1, 0, 0];
        var pat2 = [1, 1];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig, 0, Dseq(pat2, inf));
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8], inf));
        var sig = MiPlaits.ar(
            pitch: 30 + [0, 12, 12, 36] + 12,
            engine: 9,
            harm: 0.25,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0.1, 0.2] - 0,
            trigger: trig * [block0, block1, block1, block2],
            decay: [0.9, 0.8, 0.8, dec] * 0.75,
            lpg_colour: [0, 0.75, 0.75, 0]
        );
        var kickhat = sig[0][1] * 4 + (sig[3][1] * 0.35);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 3 * snareFix;
        sig = kickhat!2 + snare;
        sig = Decimator.ar(sig, 8100 * 2, 8) * 0.5;
        sig = VadimFilter.ar(sig, 3000, 0, 1) * 0.5;
    }.play(fadeTime: 0.01).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    y.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    y = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo) * trigGate;
        var b = t * Demand.kr(t, 0, Dseq(
            [0, 1]
            , inf));
        // var d = Demand.kr(b, 0, Dseq([0.15, 0.15, 0.15, 0.5].rotate(1), inf));
        // var d2 = Demand.kr(b, 0, Dseq([0, 1000].stutter(4), inf));
        var d3 = Demand.kr(b, 0, Dseq(1.5!3 ++ (4!1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, ~nT.beatDur * d3], [0, 6]), b);
        var se = EnvGen.kr(Env([0, 0, 1], [0.1, 0.1]));
        var sig = MiBraids.ar(
            pitch: 20,
            timbre: 0.25,
            color: [0.8, 0.95] - 0.2,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        ) * 2!2 * e;
        sig = (Decimator.ar(sig, 1000, 2) * 0.4);
        sig = VadimFilter.ar(sig, 500, 0, 5);
        VadimFilter.ar(sig, 1700, 0.25, 1) * 1 * se;
    }.play(fadeTime: 0);
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    // cross feedback
    y.set(\gate, 0, \fadeTime, 0.1);
    y = {
        | trigGate = 1 |
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t = Impulse.kr(~nT.tempo * 2) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, -2, 0, 1].stutter(2), inf));
        var dd = Demand.kr(t, 0, Dseq([1, 1].stutter(8), inf));
        var ddd = Demand.kr(t, 0, Dseq([0, 0].stutter(8), inf)).lag(0.1);
        var dddd = Demand.kr(t, 0, Dseq([-4, 2].reverse.stutter(1), inf));

        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 4], [-8, dddd]), t);
        var sig = MiOmi.ar(pit: 75 - 12 - 12 + d - 12, fm1: e * 0.125 * 0, xfb: min(e * dd * 0.25, 1)) * 0.4 * e;
        // sig.poll;
        sig = Sanitize.ar(sig);

        // sig = Decimator.ar(sig, 4100, 8) * 0.5;
        VadimFilter.ar(sig, 4400, 0, 1) * 8 * 1;
    }.play;   // cross feedback
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~drums.isPlaying, {~drums.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 2) * trigGate;
        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0] ++ [0, 0, 1, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0] ++ [0, 0, 0, 0, 1, 1, 0, 0];
        var pat2 = [1, 1];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig, 0, Dseq(pat2, inf));
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8], inf));
        var sig = MiPlaits.ar(
            pitch: 30 + [0, 12, 12, 36] + 12,
            engine: 9,
            harm: 0.25,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0.1, 0.2] - -0,
            trigger: trig * [block0, block1, block1, block2],
            decay: [0.9, 0.8, 0.8, dec] * 0.125,
            lpg_colour: 0.75
        );
        var kickhat = sig[0][1] * 2 + (sig[3][1] * 0.35);
        var snare = [sig[1][1], sig[2][1]] * 3 * Line.kr(0, 1, ~nT.beatDur * 2);
        sig = kickhat!2 + snare;
        sig = Decimator.ar(sig, 8100, 3) * 0.5;
        sig = VadimFilter.ar(sig, 5000, 0, 1) * 0.7;
    }.play(fadeTime: 0.01).register;
});
)