~nT = TempoClock.new(1.39).permanent_(true);

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
            [~billes2].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});});

    if(~snare.isPlaying, {~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~snare = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 1);
        var trig2 = Impulse.kr(~nT.tempo * 2);
        var pat0 = [1, 0, 0, 0, 0, 1, 0, 0];
        var pat1 = [0, 0, 1, 0, 0, 0, 1, 1];
        var pat2 = [1];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var sig = MiPlaits.ar(
            pitch: 30 + [ 0, 12, 12, 36 ],
            engine: 9,
            harm: 0.25,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0, 0],
            trigger: (trig!3)++(trig2!1) * [block0, block1, block1, block2] * trigGate,
            decay: [0.9, 0.6, 0.6, 0.7] * 0.85,
            lpg_colour: 0
        );
        var dd = Demand.kr(trig, 0, Dseq([2, 1].stutter(16), inf));
        var ddd = Demand.kr(trig, 0, Dseq([8000, 5000].stutter(16) - 0, inf));
        var sig2 = [sig[1][1], sig[2][1]] * 1.5;
        sig = [sig[0][1] * 2 + (sig[3][1] * 0.25)]!2 + sig2;
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = VadimFilter.ar(sig, 2500, 0.5, 1);
        sig = Decimator.ar(sig, 1100 * dd, 12) * 0.5;
        sig = VadimFilter.ar(sig, ddd, 0.25, 1) * 2;
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 3.6 * 1 * 0.25;
    }.play(fadeTime: 0.01).register;
    [~billes].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});});

    ~billes = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * [2, 4]) * trigGate;
        var sig = MiPlaits.ar(
            pitch: [62, 59].stutter(2) - 5 + [0, 0.1].wrapExtend(4),
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.75, 0.95),
            trigger: trig.stutter(2),
            decay: 1,
            lpg_colour: 1
        );
        sig = [sig[0] + sig[2], sig[1] + sig[3]];
        VadimFilter.ar(sig, 2000, 0.25, 5) * 1.6 * 0.25;
    }.play.register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    if(~snare.isPlaying, {~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~snare = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 1);
        var trig2 = Impulse.kr(~nT.tempo * 2);
        var pat0 = [1, 0, 0, 0, 0, 1, 0, 0];
        var pat1 = [0, 0, 1, 0, 0, 0, 1, 1];
        var pat2 = [1];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var sig = MiPlaits.ar(
            pitch: 30 + [ 0, 12, 12, 36 ] + 12,
            engine: 9,
            harm: 0.25,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0, 0],
            trigger: (trig!3)++(trig2!1) * [block0, block1, block1, block2] * trigGate,
            decay: [0.9, 0.6, 0.6, 0.7] * 0.85,
            lpg_colour: 0
        );
        var dd = Demand.kr(trig, 0, Dseq([2, 1].stutter(16), inf));
        var ddd = Demand.kr(trig, 0, Dseq([8000, 5000].stutter(16), inf));
        var sig2 = [sig[1][1], sig[2][1]] * 1.5 * Line.kr(0, 1, ~nT.beatDur * 2);
        sig = [sig[0][1] * 2 + (sig[3][1] * 0.25)]!2 + sig2;
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = VadimFilter.ar(sig, 2500, 0.5, 1);
        sig = Decimator.ar(sig, 1100 * dd, 12) * 0.5;
        sig = VadimFilter.ar(sig, ddd * Amplitude.kr(sig) + 2000, 0.25, 1);
        // sig.unipolar.poll;
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 3.6 * 1.1 * 0.25;
    }.play(fadeTime: 0.01).register;
        [~billes].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});});

    ~billes = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * [2, 4]) * trigGate;
        var sig = MiPlaits.ar(
            pitch: [62, 59].stutter(2) - 0 + [0, 0.1].wrapExtend(4),
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.75, 0.95),
            trigger: trig.stutter(2),
            decay: 1,
            lpg_colour: 1
        );
        sig = [sig[0] + sig[2], sig[1] + sig[3]];
        VadimFilter.ar(sig, 2000, 0.25, 5) * 1.6 * 0.25;
    }.play.register;
});
)

(

    if(~snare.isPlaying, {~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    [~billes].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 20.1)});});
    ~x3b.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);

)



(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

    ~x3b.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~x3b = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 8) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 3.85], [2, -8, 'lin']), t);
        var d = Demand.kr(t, 0, Dseq([4, 5, 6, 5].stutter(4) - 4, inf));
        var sig = MiBraids.ar(
            pitch: 45 + 24 + -12 + [0.0, 0.1],
            timbre: 0.65 + [0.0, 0.1],
            color: 0.5,
            model: 34,
            trig: t,
            resamp: 2,
            decim: 29 + [0, 4],
            bits: d,
            ws: 0
        ) * 1 * env;
    // sig;
        // sig = Decimator.ar(sig, 100, 12) * 4;
    VadimFilter.ar(sig, 100 + (3000 * env) + SinOsc.kr(0.1).range(0, 4000), 0.25, 5) * 0.25;
    }.play(fadeTime: 0);
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

    ~x3b.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~x3b = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 8) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 3.85], [2, -8, 'lin']), t);
        var d = Demand.kr(t, 0, Dseq([4, 5, 6, 5].stutter(4) - 4, inf));
        var sig = MiBraids.ar(
            pitch: 45 + 24 + -12 + [0.0, 0.1],
            timbre: 0.65 + [0.0, 0.1],
            color: 0.5,
            model: 34,
            trig: t,
            resamp: 2,
            decim: 29 + [0, 4],
            bits: d,
            ws: 0
        ) * 1 * env * Line.kr(0, 1, 0.5);
    // sig;
        // sig = Decimator.ar(sig, 100, 12) * 4;
    sig = VadimFilter.ar(sig, 100 + (3000 * env) + 0, 0.25, 5) * 4;
    VadimFilter.ar(sig, 500, 0.25, 1) * 32 * 4 * 4;
    }.play(fadeTime: 0);
});
)