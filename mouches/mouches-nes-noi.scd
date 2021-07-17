(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0), {

    x.set(\gate, 0, \fadeTime, 0.1);
    x = {
        var t = Impulse.kr(~nT.tempo * 0.5);
        var t2 = Impulse.kr(20);
        var dem = Demand.kr(t, 0, Dseq([1, 7, 15, 7].stutter(1), inf));
        var sig = Nes2Noise.ar(
            trig: t2,
            loopenv: 0,
            envdecay: 0,
            vol: 3.5,
            short: 0,
            freq: dem,
            vbl: 0
        );
        sig = LPF.ar(sig, 2000);
        sig!2 * 0.1275 * 8 * 2;
    }.play(fadeTime: 0.25);
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0), {

    x.set(\gate, 0, \fadeTime, 0.1);
    x = {
        | trigGate = 1 |
        var tempo = ~nT.tempo * 2;
        var basePulse = Impulse.ar(tempo) * trigGate;
        var swing = [0.8, 1.2];
        var swungTempo = Demand.ar(basePulse, 0, Dseq(swing * tempo, inf));
        var trig = Impulse.ar(swungTempo) * trigGate;
        // var t = Impulse.kr(~nT.tempo * 0.5);
        // var t2 = Impulse.kr(20);
        var env = EnvGen.ar(Env([0, 1, 0], [0.01, 0.1], [2, 'lin', 'lin']), trig);

        var dem = Demand.ar(trig, 0, Dseq([4 + 8, 5 + 8].stutter(4), inf));
        var sig = Nes2Noise.ar(
            trig: trig,
            loopenv: 1,
            envdecay: 0,
            vol: 4,
            short: 0,
            freq: dem,
            vbl: 0
        );
        // var sig = WhiteNoise.ar() * 0.1 * env;
        sig = LPF.ar(sig, 100 + (env.pow(5).lag(0.2) * 9000));
        sig!2 * 0.1275 * 8 * 2;
    }.play(fadeTime: 0.01);
});
)