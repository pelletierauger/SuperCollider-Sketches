(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur * 0), {
    ~pulTre.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~pulTre = {
        | trigGate = 1 |
        var pulse = Impulse.kr(~nT.tempo * 0.25 * 8) * trigGate;
        var trig = pulse * Demand.kr(pulse, 0, Dseq(
            [1, 0, 0, 1, 0, 0, 1, 0], inf)
        );
        var envD = Demand.kr(trig, 0,
            Dseq((3!2) * 0.1 ++ [1], inf)
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.005, envD], [-2, -8, 'lin']), trig);

        var fil = Demand.kr(trig, 0,
            Dseq(2000!2 ++ [2000], inf)
        );
        var note = Demand.kr(trig, 0,
            Dseq([0, 0, 2, 1].stutter(6 * 2), inf)
        );
        var tim = Demand.kr(trig, 0,
            Dseq(0.7!2 ++ [0.6], inf)
        );
        var frr = Demand.kr(trig, 0, Dseq(Dstutter(1, Dseries(0, 200, 12)), inf));
        var sig = MiBraids.ar(42 + 24 + 24,
            timbre: tim,
            color: 1,
            model: 21,
            trig: trig,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        ) * env;
        // sig = [sig[0][1], sig[1][1]];
        var lsig = VadimFilter.ar(sig, 1000, resonance: 0, type: 5);
        lsig = VAKorg35.ar(lsig, freq: 1200, res: 0.0, overdrive: 0.0);
        // lsig = VAKorg35.ar(lsig, freq: 200 + frr, res: 0.0, overdrive: 0.0);
        sig = lsig * 1 * 2 * 1!2;
        // [sig[0] + (sig[1 * 0.75]), sig[1] + (sig[0] * 0.75)];
        // sig[1]!2;
    }.play(fadeTime: 0.01);
});
)

~pulTre.set(\model, 14)