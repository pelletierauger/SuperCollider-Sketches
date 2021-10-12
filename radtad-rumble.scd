(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur * 0), {
    ~pul3.set(\dec, 17, \trigGate, 0, \gate, 0, \fadeTime, 5);
    ~pul3 = {
        | trigGate = 1, dec = 0 |
        var pulse = Impulse.kr(~nT.tempo * 0.5 * 8) * trigGate;
        var trig = pulse * Demand.kr(pulse, 0, Dseq(
            [1, 0, 1, 0, 1, 0, 0, 0].rotate(-4), inf)
        );
        var envD = Demand.kr(trig, 0,
            Dseq([1, 1].stutter(3).rotate(-2) * 2, inf)
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.005, envD + dec], [-8, -8, 'lin']), trig);

        var fil = Demand.kr(trig, 0,
            Dseq([2000, 7000].stutter(3).rotate(-2), inf)
        );
        var tim = Demand.kr(trig, 0,
            Dseq([0.7, 0.6].stutter(3).rotate(-2), inf)
        );
        var sig = MiBraids.ar(42 - 12,
            timbre: tim,
            color: 0.75,
            model: 44,
            trig: trig,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        ) * env;
        // sig = [sig[0][1], sig[1][1]];
        var lsig = VadimFilter.ar(sig, fil, resonance: 0, type: 1);
        // lsig = VadimFilter.ar(sig, 200, resonance: 0, type: 5);
        sig = VAKorg35.ar(sig, freq: 200 + (dec.lag(1) * 50), res: 0.0, overdrive: 0.0) + (sig * 0);
        sig = sig * 8!2 * Line.kr(0, 1, 0.1);
        // sig[1]!2;
    }.play(fadeTime: 0.01);
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~k.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~k = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var pulse = Impulse.kr(~nT.tempo * 0.5 * 4) * trigGate;
        var t = pulse * Demand.kr(pulse, 0, Dseq(
            [0, 0, 1, 0, 0, 1, 0, 1] ++
            [1, 0, 0, 0, 0, 1, 0, 1]
            , inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10], inf));
        var sig = MiBraids.ar(
            pitch: 42 - 0 + Demand.kr(t, 0, Dseq([0, -1].stutter(4), inf)),
            timbre: 0.9,
            color: 0.3,
            model: 34,
            trig: t,
            resamp: [0, 2],
            decim: 32,
            bits: Demand.kr(t, 0, Dseq([2, 4, 6, 4], inf)),
            ws: 1
        );
        sig = (sig[0] + (sig[1] * 0.2 * sig[0]))!2;
        // sig = LPF.ar(sig, 4400);
        sig = VadimFilter.ar(sig, 400 + 2000, resonance: 0, type: 1);
        sig * 2 * 4;
    }.play;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 2), {
    ~pul3.set(\dec, 17, \trigGate, 0, \gate, 0, \fadeTime, 5);
    ~pul3 = {
        | trigGate = 1, dec = 0 |
        var pulse = Impulse.kr(~nT.tempo * 4) * trigGate;
        var trig = pulse * Demand.kr(pulse, 0, Dseq(
            [1, 0, 1, 0, 1, 0, 0, 0].rotate(0), inf)
        );
        var envD = Demand.kr(trig, 0,
            Dseq([1, 1].stutter(3).rotate(0) * 2, inf)
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.005, envD + dec], [-8, -8, 'lin']), trig);

        var fil = Demand.kr(trig, 0,
            Dseq([2000, 7000].stutter(3).rotate(0), inf)
        );
        var tim = Demand.kr(trig, 0,
            Dseq([0.7, 0.6].stutter(3).rotate(0), inf)
        );
        var sig = MiBraids.ar(42 - 12,
            timbre: tim,
            color: 0.75,
            model: 44,
            trig: trig,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        ) * env;
        // sig = [sig[0][1], sig[1][1]];
        var lsig = VadimFilter.ar(sig, fil, resonance: 0, type: 1);
        // lsig = VadimFilter.ar(sig, 200, resonance: 0, type: 5);
        sig = VAKorg35.ar(sig, freq: 200 + (dec.lag(1) * 50), res: 0.0, overdrive: 0.0) + (sig * 0);
        sig = sig * 2!2 * Line.kr(0, 1, 0.1);
        // sig[1]!2;
    }.play(fadeTime: 0.01);
});
)
