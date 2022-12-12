~nT = TempoClock.new(1.39 * 2).permanent_(true);

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
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0];
        var pat2 = [1, 0];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var sig = MiPlaits.ar(
            pitch: 30 + [ 0, 12, 12, 36 ],
            engine: 9,
            harm: 0.25,
            timbre: 1,
            morph: 0.75 - [0, 0.2, 0, 0],
            trigger: (trig!3)++(trig2!1) * [block0, block1, block1, block2] * trigGate,
            decay: [0.9, 0.6, 0.6, 0.7] * 0.5,
            lpg_colour: 0.75,
            // fm_mod: -0.5,
            // timb_mod: 0.5
            morph_mod: -0.95
        );
        var dd = Demand.kr(trig, 0, Dseq([2, 1].stutter(16), inf));
        var ddd = Demand.kr(trig, 0, Dseq([8000, 5000].stutter(16), inf));
        var v = 1;
        var sig3;
        var sig2 = [sig[1][v], sig[2][v]] * 1.5 * Line.kr(0, 1, ~nT.beatDur * 2);
        sig = [sig[0][v] * 2 + (sig[3][v] * 0.25)]!2 + sig2;

        sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.9, algo: 5, timb: 0.7)[0]);
        sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.9, algo: 5, timb: 0.7)[0]);
        // sig = [sig2, sig3];
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = VadimFilter.ar(sig, 2500, 0.5, 1);
        // sig = Decimator.ar(sig, 1100 * dd, 12) * 0.5;
        // sig = VadimFilter.ar(sig, ddd * Amplitude.kr(sig) + 4000, 0, 1);
        // sig.unipolar.poll;
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);x
        sig = sig * 3.6 * 1.1 * 0.25;
    }.play(fadeTime: 0.01).register;
});
)


(
if(~snare.isPlaying, {~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
~x3b.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
~wind.set(\gate, 0, \fadeTime, 1);
x.set(\gate, 0, \fadeTime, 10.1);
[~billes].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});});
[~billesA].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 2.1)});});
)