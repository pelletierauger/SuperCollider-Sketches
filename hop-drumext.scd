(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~snare.isPlaying, {~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~snare = {
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
            pitch: 30 + [ 0, 12, 12, 36 + 24 ] + 12,
            engine: 9,
            harm: 0.75,
            timbre: 0.95,
            morph: 0.25 - [0, 0.2, 0, 0],
            trigger: (trig!3)++(trig2!1) * [block0, block1, block1, block2] * trigGate,
            decay: [0.9 * 2, 0.6, 0.6, 0.7 * 2] * 0.5,
            lpg_colour: 0.5,
            // fm_mod: -0.5,
            // timb_mod: 0.5
            morph_mod: -0.95
        );
        var dd = Demand.kr(trig, 0, Dseq([2, 1].stutter(16), inf));
        var ddd = Demand.kr(trig, 0, Dseq([8000, 5000].stutter(16), inf));
        var v = 1;
        var sig3;
        var sig2 = [sig[1][v], sig[2][v]] * 5 * Line.kr(0, 1, ~nT.beatDur * 2);
        sig = [sig[0][v] * 2 + (sig[3][v] * 0.5)]!2 + sig2;

        sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.5, 0.25, algo: 2, timb: 0.1)[0]);
        sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.5, 0.25, algo: 2, timb: 0.1)[0]);
        sig = [sig2, sig3] * 0.5;
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