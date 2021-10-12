(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur * 0), {
    ~pulOff.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~pulOff = {
        | trigGate = 1 |
        var pulse = Impulse.kr(~nT.tempo * 1 * 8) * trigGate;
        var trig = pulse * Demand.kr(pulse, 0, Dseq(
            [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0].wrapExtend(12) ++
            [1, 1, 1, 1].wrapExtend(4), inf)
        );
        var col = Demand.kr(trig, 0, Dseq(
            [0.7, 0.5], inf)
        );
        var envD = Demand.kr(trig, 0,
            Dseq(((3!1) * 2 ++ [2]).reverse * 0.01, inf)
        );
        var ddd = Demand.kr(trig, 0, Dseq((78.5!(6) ++ (108.5!(4))) + 200, inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.005, 0.01 * ddd], [8, -8, 'lin']), trig);

        var fil = Demand.kr(trig, 0,
            Dseq(2000!1 ++ [2000], inf)
        );
        var note = Demand.kr(trig, 0,
            Dseq([0, 0, 2, 1].stutter(6 * 2), inf)
        );
        var tim = Demand.kr(trig, 0,
            Dseq(0.65!1 ++ [0.65], inf)
        );
        var frr = Demand.kr(trig, 0, Dseq(Dstutter(1, Dseries(0, 200, 12)), inf));
        var sig = MiBraids.ar(42 + (12 * 1) - 5 + [0, 1][0],
            timbre: tim,
            color: col + [0.1, 0.15][0],
            model: 41,
            trig: trig,
            resamp: 2,
            decim: 32,
            bits: 6,
            ws: 0
        ) * env.pow(5);
        // sig = [sig[0][1], sig[1][1]];
        var lsig = VadimFilter.ar(sig, 2000, resonance: 0.2, type: 5);
        // lsig = VAKorg35.ar(sig, freq: 2300, res: 0.0, overdrive: 0.0);
        lsig = VadimFilter.ar(lsig, 6000, resonance: 0.2, type: 1);
        // lsig = VAKorg35.ar(sig, freq: 5300, res: 0.0, overdrive: 0.0);
        // lsig = VAKorg35.ar(lsig, freq: 200 + frr, res: 0.0, overdrive: 0.0);
        lsig = Decimator.ar(lsig, rate: 1000, bits: 12) * 0.5;
        lsig = VadimFilter.ar(lsig, 1000, resonance: 0.2, type: 1);
        sig = lsig * 1 * 4 * 20.5!2;
        // [sig[0] + (sig[1 * 0.75]), sig[1] + (sig[0] * 0.75)];
        // sig[1]!2;
    }.play(fadeTime: 0.01);
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur * 0), {
    ~pulOff2.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~pulOff2 = {
        | trigGate = 1 |
        var pulse = Impulse.kr(~nT.tempo * 1 * 8) * trigGate;
        var trig = pulse * Demand.kr(pulse, 0, Dseq(
            [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0].wrapExtend(12) ++
            [1, 1, 1, 1].wrapExtend(4), inf)
        );
        var col = Demand.kr(trig, 0, Dseq(
            [0.7, 0.5], inf)
        );
        var envD = Demand.kr(trig, 0,
            Dseq(((3!1) * 2 ++ [2]).reverse * 0.01, inf)
        );
        var ddd = Demand.kr(trig, 0, Dseq((78.5!(6) ++ (108.5!(4))), inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.005, 0.01 * ddd], [8, -8, 'lin']), trig);

        var fil = Demand.kr(trig, 0,
            Dseq(2000!1 ++ [2000], inf)
        );
        var note = Demand.kr(trig, 0,
            Dseq([0, 0, 2, 1].stutter(6 * 2), inf)
        );
        var tim = Demand.kr(trig, 0,
            Dseq(0.65!1 ++ [0.65], inf)
        );
        var frr = Demand.kr(trig, 0, Dseq(Dstutter(1, Dseries(0, 200, 12)), inf));
        var sig = MiBraids.ar(42 + (12 * 1) - 5 + [0, 1],
            timbre: tim,
            color: col - [0.1, 0.15],
            model: 41,
            trig: trig,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 0
        ) * env.pow(5);
        // sig = [sig[0][1], sig[1][1]];
        var lsig = VadimFilter.ar(sig, 2000, resonance: 0.2, type: 5);
        // lsig = VAKorg35.ar(sig, freq: 2300, res: 0.0, overdrive: 0.0);
        lsig = VadimFilter.ar(lsig, 6000, resonance: 0.2, type: 1);
        // lsig = VAKorg35.ar(sig, freq: 5300, res: 0.0, overdrive: 0.0);
        // lsig = VAKorg35.ar(lsig, freq: 200 + frr, res: 0.0, overdrive: 0.0);
        sig = lsig * 1 * 2 * 1.5;
        // [sig[0] + (sig[1 * 0.75]), sig[1] + (sig[0] * 0.75)];
        // sig[1]!2;
    }.play(fadeTime: 0.01);
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur * 0), {
    ~pulOff3.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~pulOff3 = {
        | trigGate = 1 |
        var pulse = Impulse.kr(~nT.tempo * 1 * 8) * trigGate;
        var trig = pulse * Demand.kr(pulse, 0, Dseq(
            [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0].wrapExtend(16 * 3) ++
            [1, 1, 1, 1].wrapExtend(16), inf)
        );
        var col = Demand.kr(trig, 0, Dseq(
            [0.7, 0.5], inf)
        );
        var envD = Demand.kr(trig, 0,
            Dseq(((3!1) * 2 ++ [2]).reverse * 0.01, inf)
        );
        var ddd = Demand.kr(trig, 0, Dseq((78.5!(16 * 3 / 2) ++ (108.5!(16))), inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.005, 0.01 * ddd], [8, -8, 'lin']), trig);

        var fil = Demand.kr(trig, 0,
            Dseq(2000!1 ++ [2000], inf)
        );
        var note = Demand.kr(trig, 0,
            Dseq([0, 0, 2, 1].stutter(6 * 2), inf)
        );
        var tim = Demand.kr(trig, 0,
            Dseq(0.65!1 ++ [0.65], inf)
        );
        var frr = Demand.kr(trig, 0, Dseq(Dstutter(1, Dseries(0, 200, 12)), inf));
        var sig = MiBraids.ar(42 + (12 * 1) - 5 + [0, 0.5],
            timbre: tim,
            color: col,
            model: 41,
            trig: trig,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 0
        ) * env.pow(5);
        // sig = [sig[0][1], sig[1][1]];
        var lsig = VadimFilter.ar(sig, 2000, resonance: 0.2, type: 5);
        // lsig = VAKorg35.ar(sig, freq: 2300, res: 0.0, overdrive: 0.0);
        lsig = VadimFilter.ar(lsig, 6000, resonance: 0.2, type: 1);
        // lsig = VAKorg35.ar(sig, freq: 5300, res: 0.0, overdrive: 0.0);
        // lsig = VAKorg35.ar(lsig, freq: 200 + frr, res: 0.0, overdrive: 0.0);
        sig = lsig * 1 * 1 * 2.5;
        // [sig[0] + (sig[1 * 0.75]), sig[1] + (sig[0] * 0.75)];
        // sig[1]!2;
    }.play(fadeTime: 0.01);
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur * 0), {
    ~pulOff.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~pulOff = {
        | trigGate = 1 |
        var pulse = Impulse.kr(~nT.tempo * 0.5 * 8) * trigGate;
        var trig = pulse * Demand.kr(pulse, 0, Dseq(
            [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1], inf)
        );
        var zamp = pulse * Demand.kr(pulse, 0, Dseq(
            [1, 0.5], inf)
        );
        var envD = Demand.kr(trig, 0,
            Dseq(((3!1) * 2 ++ [2]).reverse * 0.01, inf)
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.005, 0.01 * 1.5], [8, -8, 'lin']), trig);

        var fil = Demand.kr(trig, 0,
            Dseq(2000!1 ++ [2000], inf)
        );
        var note = Demand.kr(trig, 0,
            Dseq([0, 0, 2, 1].stutter(6 * 2), inf)
        );
        var tim = Demand.kr(trig, 0,
            Dseq(0.65!1 ++ [0.65], inf)
        );
        var frr = Demand.kr(trig, 0, Dseq(Dstutter(1, Dseries(0, 200, 12)), inf));
        var sig = MiBraids.ar(42 + (12 * 5) - 5 + [0, 0.1],
            timbre: tim,
            color: 1,
            model: 4,
            trig: trig,
            resamp: 2,
            decim: 32,
            bits: 6,
            ws: 0
        ) * env.pow(5);
        // sig = [sig[0][1], sig[1][1]];
        var lsig = VadimFilter.ar(sig, 5000, resonance: 0, type: 5);
        lsig = VAKorg35.ar(sig, freq: 2300, res: 0.0, overdrive: 0.0);
        lsig = VadimFilter.ar(lsig, 2000, resonance: 0, type: 5);
        // lsig = VAKorg35.ar(lsig, freq: 200 + frr, res: 0.0, overdrive: 0.0);
        sig = lsig * 1 * 4 * 0.5;
        // [sig[0] + (sig[1 * 0.75]), sig[1] + (sig[0] * 0.75)];
        // sig[1]!2;
    }.play(fadeTime: 0.01);
});
)