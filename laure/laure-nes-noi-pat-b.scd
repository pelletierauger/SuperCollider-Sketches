~bbus = Bus.audio(s, 2);

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {

    w.set(\gate, 0, \fadeTime, 0.1);
    w = {
        var in = In.ar(~bbus, 2);
        var pulse = Impulse.kr(~nT.tempo * 0.25);
        var dem = Demand.kr(pulse, 0, Dseq([15, 10].stutter(1), inf));
        var sig = Nes2Noise.ar(
            trig: pulse,
            loopenv: 1,
            envdecay: 1,
            vol: 5,
            short: 1,
            freq: dem,
            vbl: 2
        );
        /*        sig = sig!2 * 4;
        sig = MiVerb.ar(
        inputArray: sig,
        time: 0.9,
        drywet: 0.5,
        damp: 0.5,
        freeze: 0,
        diff: 0.8
        ) * 8;*/
        (sig * 0.5) + ((LPF.ar(sig, 5000)) * 2 * in);
        // sig!2 * 4 * in;
        // sig = HPF.ar(sig, 500);
        // LPF.ar(sig, 1000) * 1.6!2 * 16;
    }.play;
});
)