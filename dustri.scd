~nT.tempo * 1.75
~nT.tempo = 6.3245;

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~snare.isPlaying, {~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
    ~snare = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 1);
        var pat0 = [1, 0, 1, 0, 1, 1, 0, 0];
        var pat1 = [0, 0, 1, 0, 0, 0, 1, 1];
        var pat2 = [1, 1];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig, 0, Dseq(pat2, inf));
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var sig = MiPlaits.ar(
            pitch: 30 + [ 0, 12, 12, 36 ] + 12 + 12,
            engine: 9,
            harm: 0.25,
            timbre: 1,
            morph: 0.25 - [0, 0.2, 0, 0],
            trigger: trig * [block0, block1, block1, block2] * trigGate,
            decay: [0.96, 0.6, 0.6, 0.7] * 0.45,
            lpg_colour: 0.9,
            fm_mod: -0.5,
            morph_mod: -0.5,
        );
        // var dd = Demand.kr(trig, 0, Dseq([2, 1].stutter(16), inf));
        // var ddd = Demand.kr(trig, 0, Dseq([8000, 5000].stutter(16), inf));
        var sig2 = [sig[1][0], sig[2][0]] * 1.5;
        sig = [sig[0][0] * 2 + (sig[3][0] * 0.35)]!2 + sig2;
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = VadimFilter.ar(sig, 2500, 0.5, 1);
        // sig = Decimator.ar(sig, 1100 * dd, 12) * 0.5;
        sig = VadimFilter.ar(sig, 12000, 0, 1) * 0.5;
        // sig.unipolar.poll;
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 1.6 * 1;
    }.play(fadeTime: 0.01).register;
});
)