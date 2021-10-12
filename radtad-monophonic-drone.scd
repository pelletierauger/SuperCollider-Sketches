~nT = TempoClock.new(1.39 * 1.25 * 1.075).permanent_(true);

(
~nT.sched(~nT.timeToNextBeat(quant: 4) - 0.25, {
    ~lush.set(\pulseGate, 0, \gate, 0, \fadeTime, 10.1);
    ~lush = {
        | pulseGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.125 * 0.5) * pulseGate;

        var env = EnvGen.kr(Env([0, 1, 0], [1, 5] * 4, [-8, -8, 'lin']), t);
        var v = Demand.kr(t, 0, Dseq([
            [-12, -5, 0, 4],
            [-12, -5, 0, 3],
            [-14, -2, 2, 5],
            [-14, -2, 1, 5]
        ], inf));
        var lfo = SinOsc.kr(0.25).range(0.1, 0.2) * 1.5;
        var sig = MiBraids.ar(
            48 + -12 + -6,
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
        sig = VadimFilter.ar(sig, 100 + (env * 2000 * lfo2), resonance: 0.25, type: 1) * 4;
        // sig = VAKorg35.ar(sig, freq: 1200, res: 0.0, overdrive: 0.0);

        sig = sig * env!2;
        // Splay.ar(sig.scramble);
    }.play(fadeTime: 0.1);
});
)