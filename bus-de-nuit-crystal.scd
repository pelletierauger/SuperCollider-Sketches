(
~nT.sched(~nT.timeToNextBeat(quant: 4) * 1, {
    ~roues.set(\pulseGate, 0, \gate, 0, \fadeTime, 0.1);
    ~roues = {
        | pulseGate = 1 |
        var t = Impulse.kr(~nT.tempo * 2) * pulseGate;

        var env = EnvGen.kr(
            Env([0, 1, 0], [0.01, ~nT.tempo / 4 - 0.01] * 2, [8, -8, 'lin']
        ), t);
        var y = Demand.kr(t, 0, Dseq([7, 5, 9, 5].stutter(8), inf));
        var y2 = Demand.kr(t, 0, Dseq([7, 5, 10, 5].stutter(8), inf));
        var z = Demand.kr(t, 0, Dseq([3, 2].stutter(8), inf));
        var v = Demand.kr(t, 0, Dseq([
            [-12, 0, z, y],
            ([-5, 0, z, y2] - 5)
        ].stutter(64), inf));
        var lfo = SinOsc.kr(0.25).range(0.1, 0.2) * 1.5;
        var sig = MiBraids.ar(
            48 + 12 + 12 + v.wrapExtend(8) + [0, 0.1].stutter(4) + -6,
            timbre: 0.89,
            color: 0.1,
            model: 17,
            resamp: 2,
            decim: 2,
            bits: 6,
            ws: 0
        );
        // var cen = sig[(8..11)].sum * 0.75;
        var lfo2 = SinOsc.kr(0.25 * 0.25).range(0, 1);
        var step = Demand.kr(t, 0, Dseq(((0..63)/64 * 1).reverse, inf));
        sig = [sig[(0..3)].sum, sig[(4..7)].sum] * 0.25;
        //sig = sig[0]!2;
        // sig = VASEM12.ar(sig, freq: SinOsc.kr(0.1).exprange(280.0, 500.0) + 4000, res: 0, transition: 0);
        // sig = VA1Pole.ar(sig, freq: 100, feedback: -0.1, type: 0);
        sig = sig * Line.kr(0, 1, 0.1) * env;
        sig = VadimFilter.ar(sig, 100 + (env * 1000 * step), resonance: 0.25, type: 5) * 1;
        sig = VadimFilter.ar(sig, 7000, resonance: 0.25, type: 1) * 2 + (sig * 0.2);
        // sig = VAKorg35.ar(sig, freq: 1200, res: 0.0, overdrive: 0.0);

        sig = sig;
        // Splay.ar(sig.scramble);
    }.play(fadeTime: 0.01);
});
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~lushZ.set(\pulseGate, 0, \gate, 0, \fadeTime, 10.1);
    ~lushZ = {
        | pulseGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.125 * 0.5) * pulseGate;
        var env = EnvGen.kr(Env([0, 1, 0], [1, 5] * 4, [-8, -8, 'lin']), t);
        var lfo = SinOsc.kr(0.25).range(0.1, 0.2) * 1.5;
        var sig = MiBraids.ar(
            48 + -12 + -6 + Demand.kr(t, 0, Dseq([0, -5], inf)),
            timbre: 0.89,
            color: 0.8 + lfo,
            model: 43,
            resamp: 0,
            decim: 32,
            bits: 2,
            ws: 0
        );
        // var cen = sig[(8..11)].sum * 0.75;
        var lfo2 = SinOsc.kr(0.25).range(0, 1);
        // sig = cen!2 + [sig[(0..3)].sum, sig[(4..7)].sum] * 0.25;
        //sig = sig[0]!2;
        // sig = VASEM12.ar(sig, freq: SinOsc.kr(0.1).exprange(280.0, 500.0) + 4000, res: 0, transition: 0);
        // sig = VA1Pole.ar(sig, freq: 100, feedback: -0.1, type: 0);
        sig = sig * Line.ar(0, 1, 0.1);
        sig = VadimFilter.ar(sig, 100 + (env * 200 * lfo2), resonance: 0.25, type: 1) * 4;
        // sig = VAKorg35.ar(sig, freq: 1200, res: 0.0, overdrive: 0.0);

        sig = sig * env!2;
        // Splay.ar(sig.scramble);
    }.play(fadeTime: 0.1);
});
)
