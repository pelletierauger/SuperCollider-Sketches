~nT = TempoClock.new(1.39 * 2 * 1.05).permanent_(true);

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {

    ~x3bb.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~x3bb = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 2) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 1.85], [2, -8, 'lin']), t);
        var d = Demand.kr(t, 0, Dseq([4, 5, 6, 5].stutter(4) - 0, inf));
        var sig = MiBraids.ar(
            pitch: 45 + 24 + -12 + [0.0, 0.1] + 12,
            timbre: 0.65 + [0.0, 0.1],
            color: 0.5,
            model: 36,
            trig: t,
            resamp: 2,
            decim: 9 + [0, 4],
            bits: d,
            ws: 0
        ).sum ! 2 * 1 * env;
        // sig;
        // sig = Decimator.ar(sig, 100, 12) * 4;
        VadimFilter.ar(sig, 100 + (10000 * env) + SinOsc.kr(0.1).range(0, 4000), 0, 5) * 1;
    }.play(fadeTime: 0);
});
)
(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~toms.isPlaying, {~toms.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~toms = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 2);
        var trig2 = Impulse.kr(~nT.tempo * 4);
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0];
        var pat2 = [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var hh = Demand.kr(trig * block2, 0, Dseq([0.9, 1.1], inf));
        var scr = Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf));
        var sig = MiPlaits.ar(
            pitch: 27 + [0, 12, 12, 24],
            engine: 9,
            harm: [0.25, 0.4, 0.4, 0.25],
            timbre: [1, 1, 1, 1],
            morph: 0.75 - [0, 0.2, 0, -0.1],
            trigger: (trig!3)++(trig2!1) * [block0, block1, block1, block2] * trigGate,
            decay: [0.9, 0.6, 0.6, hh] * 0.5,
            lpg_colour: [0.75, 0.75, 0.75, 1],
            // fm_mod: -0.5,
            // timb_mod: 0.5
            morph_mod: -1
        );
        var dd = Demand.kr(trig, 0, Dseq([2, 1].stutter(16), inf));
        var ddd = Demand.kr(trig, 0, Dseq([8000, 5000].stutter(16), inf));
        var v = 1;
        var sig3;
        var sig2 = [sig[1][v], sig[2][v]] * 1.5 * Line.kr(0, 1, ~nT.beatDur * 2);
        sig = [sig[0][v] * 2 + (sig[3][v] * 0.15)]!2 + sig2;

        sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        sig3 = [sig2, sig3] * 0.25;
        sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500), 0, 5) * 8;
        // sig = sig + (sig3 * Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf)).lag(1));
        sig;
    }.play(fadeTime: 0.01).register;
});
)


(
    if(~toms.isPlaying, {~toms.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~x3bbb.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);

)