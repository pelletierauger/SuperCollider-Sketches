(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    ~x3b.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~x3bbb.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);

    if(~tomsW.isPlaying, {~tomsW.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~tomsW = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 2);
        var trig2 = Impulse.kr(~nT.tempo * 4);
        var pat0 = [1, 0, 0, 1, 0, 0, 1, 0].rotate(0);
        var pat3 = [1, 0, 0, 0, 0, 0, 0, 0].rotate(0);
     // var pat1 = [0, 0, 0, 0, 1, 0, 0, 0].rotate(0);
        var pat1 = [0, 1, 0, 0, 1, 0, 0, 0].rotate(0);
        var pat2 = [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var block3 = Demand.kr(trig, 0, Dseq(pat3, inf));
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var hh = Demand.kr(trig * block2, 0, Dseq([0.9, 1.1], inf));
        var scr = Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf));
        var shri = Demand.kr(block0 + block3, 0, Dseq([0.9, 0.9, 1.5], inf));
        var sig = MiPlaits.ar(
            pitch: 27 + [0, 12, 12, 24] + 0,
            engine: [13, 14, 14, 15],
            harm: [0.25, 0.4, 0.4, 0.25] * 0.125,
            timbre: [1, 1, 1, 1] * 0.275,
            morph: 0.75 - [0, 0.2, 0, -0.1],
            trigger: (trig!3)++(trig2!1) * [block0, block1, block1, block2] * trigGate,
            decay: [0.9, 0.6, 0.6, hh] * 0.275,
            lpg_colour: [0.75, 0.75, 0.75, 1] - 0.25,
            fm_mod: 0.5,
            // timb_mod: 0.5
            morph_mod: -1
        );
        var dd = Demand.kr(trig, 0, Dseq([2, 1].stutter(16), inf));
        var ddd = Demand.kr(trig, 0, Dseq([8000, 5000].stutter(16), inf));
        var v = 1;
        var sig3;
        var sig2 = [sig[1][v], sig[2][v]] * 4.5 * Line.kr(0, 1, ~nT.beatDur * 2);
        sig = [sig[0][v] * 2 + (sig[3][v] * 0.15)]!2 + sig2;

        sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        sig3 = [sig2, sig3] * 0.5;
        sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500) - 400, 0, 5) * 8;
        // sig = sig + (sig3 * Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf)).lag(1));
        sig * 2;
    }.play(fadeTime: 0.01).register;
});
)