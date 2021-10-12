(
~nT.sched(~nT.timeToNextBeat(quant: 4) - 0.5, {
    ~lush.set(\gate, 0, \fadeTime, 0.1);
    ~lush = {
        var t = Impulse.kr(~nT.tempo * 0.125 * 0.5);

        var env = EnvGen.kr(Env([0, 1, 0], [1, 5] * 4, [-8, -8, 'lin']), t);
        var v = Demand.kr(t, 0, Dseq([
            [-12, -5, 0, 4],
            [-12, -5, 0, 3],
            [-14, -2, 2, 5],
            [-14, -2, 1, 5]
        ], inf));
        var lfo = SinOsc.kr(0.25).range(0.1, 0.2) * 1.5;
        var sig = MiBraids.ar(
            48 + v.wrapExtend(12) + [0, 0.1, 0.05].stutter(4) + 6,
            timbre: env * 0.125,
            color: 0.5 + lfo,
            model: 2,
            resamp: 0,
            decim: 32,
            bits: 2,
            ws: 0
        );
        var cen = sig[(8..11)].sum * 0.75;
        var lfo2 = SinOsc.kr(0.25).range(0, 1);
        sig = cen!2 + [sig[(0..3)].sum, sig[(4..7)].sum] * 0.25;
        // sig = VASEM12.ar(sig, freq: SinOsc.kr(0.1).exprange(280.0, 500.0) + 4000, res: 0, transition: 0);
        // sig = VA1Pole.ar(sig, freq: 100, feedback: -0.1, type: 0);
        sig = VadimFilter.ar(sig, 500 + (env * 5000 * lfo2), resonance: 0.25, type: 1) * 4;
        sig = sig * env;
        // Splay.ar(sig.scramble);
    }.play;
});
)

(0..1) + [0, 1].stutter(8)
(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur * 1), {
    ~pul5.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~pul5 = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 0.5 * 8) * trigGate;

        var dem = Demand.kr(trig, 0, Dseq(
            [1, 0, 1, 0, 1, 0, 1, 0] ++ [1, 0, 1, 0, 1, 0, 1, 0]
            , inf));
        var envD = Demand.kr(trig * dem, 0, Dseq([0.4, 1].stutter(4) * 2, inf));
        var fil = Demand.kr(trig * dem, 0, Dseq([2000, 7000].stutter(4), inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.005, envD], [-8, -8, 'lin']), trig * dem);
        var dec = Demand.kr(trig * dem, 0, Dseq([0.4] + 0.1, inf));
        var tim = Demand.kr(trig * dem, 0, Dseq([0.7, 0.65].stutter(4), inf));
        var sig = MiBraids.ar(42 - 36 + 24 + 12 - 0,
            timbre: tim,
            color: 1,
            model: 43,
            trig: trig * dem,
            resamp: 2,
            decim: 32,
            bits: 6,
            ws: 0
        ) * env;
        // sig = HPF.ar(sig, 200);
        // sig = [sig[0][1], sig[1][1]];
        var lsig = VadimFilter.ar(sig, fil - 1000, resonance: 0, type: 5);
        sig = VAKorg35.ar(lsig, freq: 300, res: 0.0, overdrive: 0.0) + (sig * 0.125);
        sig = sig * 0.8!2;
        // sig[1]!2;
    }.play(fadeTime: 0.01);
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur * 0), {
    ~pul3.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~pul3 = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 0.5 * 8) * trigGate;

        var dem = Demand.kr(trig, 0, Dseq(
            [1, 0, 1, 0, 1, 0, 0, 0] ++ [1, 0, 1, 0, 1, 0, 0, 0]
            , inf));
        var envD = Demand.kr(trig * dem, 0, Dseq([0.4, 1].stutter(3) * 2, inf));
        var fil = Demand.kr(trig * dem, 0, Dseq([2000, 7000].stutter(3), inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.005, envD], [-8, -8, 'lin']), trig * dem);
        var dec = Demand.kr(trig * dem, 0, Dseq([0.4] + 0.1, inf));
        var tim = Demand.kr(trig * dem, 0, Dseq([0.7, 0.7, 0.7, 0.6, 0.6, 0.6], inf));
        var sig = MiBraids.ar(42 - 36 + 24 + 12,
            timbre: tim,
            color: 1,
            model: 43,
            trig: trig * dem,
            resamp: 2,
            decim: 32,
            bits: 6,
            ws: 0
        ) * env;
        // sig = HPF.ar(sig, 200);
        // sig = [sig[0][1], sig[1][1]];
        var lsig = VadimFilter.ar(sig, fil, resonance: 0, type: 1);
        sig = VAKorg35.ar(lsig, freq: 200, res: 0.0, overdrive: 0.0) + (sig * 0);
        sig = sig * 2!2;
        // sig[1]!2;
    }.play(fadeTime: 0.01);
});
)
