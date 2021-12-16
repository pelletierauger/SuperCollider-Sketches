(

    ~nT.sched(~nT.timeToNextBeat(quant: 8), {
    // cross feedback
    y.set(\gate, 0, \fadeTime, 0.1);
    y = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t = Impulse.kr(~nT.tempo * 2) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 1, 3, 1].stutter(8) + 7, inf));
        var dd = Demand.kr(t, 0, Dseq([1, 1].stutter(8), inf));
        var ddd = Demand.kr(t, 0, Dseq([0, 0].stutter(8), inf)).lag(0.1);
        var dddd = Demand.kr(t, 0, Dseq([-4, 2].reverse.stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 4], [-8, dddd]), t).lag(0.1);
        var d5 = Demand.kr(t, 0, Dseq(Dseries(0, 1/2, 16), inf)).lag(0.5);
        var sig = MiOmi.ar(pit: 76 + d - 12, fm1: e * 0.125 * d5, xfb: min(e * dd * 0.5, 1)) * 0.4 * e;
        // sig.poll;
        // d5.poll;

        sig = Sanitize.ar(sig);

        // sig = Decimator.ar(sig, 4100, 8) * 0.5;
        sig = VadimFilter.ar(sig, 2400, 0, 1) * 2 * 0.1;
        Out.ar(~reverb, sig);
    }.play;
    });

)

// ~toMidi.("E1")
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
        var d5 = Demand.kr(trig, 0, Dseq(Dseries(0, 1/64, 32), inf)).lag(0);
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8] + 0.1, inf));
        var dec2 = Demand.kr(trig, 0, Dseq([0, -2].stutter(32), inf));
        var sig = MiPlaits.ar(
            pitch: 28 + [0, 12, 12, 36 + 7] + -12 + 0,
            engine: 5,
            harm: 0.5,
            timbre: [1, 1, 0.8, 1],
            morph: 0.45 - [0, 0.2, 0.1, 0.4] + 0,
            trigger: trig * [block0, block1, block1, block2],
            decay: [0.9, 0.8, 0.8, dec] * 0.75,
            lpg_colour: [0, 0.75, 0.75, 0],
            // morph_mod: d5 * -1
        );
        var kickhat = sig[0][1] * 4 + (sig[3][1] * 0.35);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 3 * snareFix;
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 8100 * 2, 8) * 0.5;
        sig = VadimFilter.ar(sig, 7000, 0, 1) * 0.35 * 0.0625;
    }.play(fadeTime: 0.01).register;
});
)