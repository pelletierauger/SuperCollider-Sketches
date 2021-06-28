(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

    if(~cor.isPlaying, {~cor.set(\trigGate, 0, \gate, 0, \fadeTime, 15)});
    ~cor = {
        | trigGate = 1 |
        var ds;
        var t = Impulse.kr(~nT.tempo / 8) * trigGate;
        var bl = Demand.kr(t, 0, Dseq([1, 1, 1, 0], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.5, 16], [2, -8, 'lin']), t * bl);

        var note0 = Demand.kr(t * bl, 0, Dseq([0, -2, -4], inf));
        var note1 = Demand.kr(t * bl, 0, Dseq([3, 3, 3], inf));
        var sig = MiBraids.ar(
            pitch: 50 + 12 + ([note0, note1] ++ ([note0, note1] - 12)),
            timbre: [0.9, 0.7].stutter(2),
            color: 0.1,
            model: 14,
            resamp: 0,
            decim: 10,
            bits: 0,
            ws: 1
        ) * env * [1, 0.25].stutter(2);
        sig = [sig[0] + sig[2], sig[1] + sig[3]];
        sig = LPF.ar(sig, 1400 + (SinOsc.kr(1).unipolar * 1400));
        // sig = sig * SinOsc.kr(6).range(0.25, 1);
        sig = (LPF.ar(MiVerb.ar(sig, 0.2, 1) * 8, 500));
        /*   ds = Decimator.ar(sig, 10000, 2) * 1;
        ds = LPF.ar(sig, 1400 + (SinOsc.kr(0.1).unipolar * 1400));
        sig = sig + (ds * 4);*/
        sig * 0.25 * 2;
    }.play(fadeTime: 0.25).register;
});
)