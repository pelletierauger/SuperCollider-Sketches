(
~t.sched(~t.timeToNextBeat(quant: 4), {
    v.set(\gate, 0, \fadeTime, 0.1);
    v = {
        | trigGate = 1 |
        // var sig = WhiteNoise.ar();
        // sig = VA1Pole.ar(sig, freq: 12500, feedback: -0.1, type:1);
        // sig = VADiodeFilter.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 500.0), res: 0.5, overdrive: 0.9);
        var t = Impulse.kr(~t.tempo * 0.5) * trigGate;
        var bl = Demand.kr(t, 0, Dseq([1, 0, 0, 0, 1, 0, 0, 0], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [1, 4], [2, 'lin', 'lin']), t * bl).lag(0.1);
        var f = Demand.kr(t * bl, 0, Dseq([0, -1, -3, -3], inf));
        var sig = MiBraids.ar(~toMidi.("Bb3") + f, timbre: 0, color: 0, model: 14);
        var freq = 80 + (500 - (env * 500));
        // SinOsc.kr(0.1).exprange(80.0, 1000.0)
        // sig = VAKorg35.ar(sig, freq: freq, res: 0.1, overdrive: 0.05);
        sig = AnalogPhaser.ar(
            sig,
            SinOsc.ar(0.022 * [1, 1.1]),
            skew: SinOsc.kr(5.59 * [1, 1.1]),
            feedback: SinOsc.kr(0.005 * [1, 1.1], 1pi).range(0.8,0.85),
            modulation: SinOsc.kr(2.0192 * [1, 1.1], 2pi).unipolar,
            // modulation: 0.25,
            stages: 50
        );
        sig = VadimFilter.ar(sig, 1000, 0, 1);
        // sig = VadimFilter.ar(sig, (280 + (env * 500)).lag(1), resonance: 0, type: 1);
        // sig = VASEM12.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 15000.0), res:0.9, transition: LFSaw.kr(0.01).unipolar);
        // sig = VALadder.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 1000.0), res:0.5, overdrive:0.5, type:0);

        sig * 0.5 * env.lag(0.1) * Line.kr(0, 1, 0.1);
    }.play;
});
~t.sched(~t.timeToNextBeat(quant: 4), {
    u.set(\gate, 0, \fadeTime, 0.1);
    u = {
        | trigGate = 1 |
        // var sig = WhiteNoise.ar();
        // sig = VA1Pole.ar(sig, freq: 12500, feedback: -0.1, type:1);
        // sig = VADiodeFilter.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 500.0), res: 0.5, overdrive: 0.9);
        var t = Impulse.kr(~t.tempo * 0.5) * trigGate;
        var bl = Demand.kr(t, 0, Dseq([1, 0, 0, 0, 1, 0, 0, 0], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.025, 2], [2, 'lin', 'lin']), t * bl).lag(0.1);
        var f = Demand.kr(t * bl, 0, Dseq([0, -2, -5, -7], inf));
        var sig = MiBraids.ar(48 - 5 - 0 + f, timbre: 0, color: env, model: 14);
        var freq = 80 + (500 - (env * 500));
        // SinOsc.kr(0.1).exprange(80.0, 1000.0)
        sig = VAKorg35.ar(sig, freq: freq, res: 0.1, overdrive: 0.05);
        sig = AnalogPhaser.ar(
            sig,
            SinOsc.ar(0.022 * [1, 1.1]),
            skew: SinOsc.kr(5.59 * [1, 1.1]),
            feedback: SinOsc.kr(0.005 * [1, 1.1], 1pi).range(0.8,0.85),
            modulation: SinOsc.kr(2.0192 * [1, 1.1], 2pi).unipolar,
            // modulation: 0.25,
            stages: 50
        );
        sig = VadimFilter.ar(sig, 3000, 0, 1);
        // sig = VadimFilter.ar(sig, (280 + (env * 500)).lag(1), resonance: 0, type: 1);
        // sig = VASEM12.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 15000.0), res:0.9, transition: LFSaw.kr(0.01).unipolar);
        // sig = VALadder.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 1000.0), res:0.5, overdrive:0.5, type:0);

        sig * 0.25 * 0.25 * Line.kr(0, 1, 0.1);
    }.play;
});
)



(
~t.sched(~t.timeToNextBeat(quant: 4) - 0.05, {
    w.set(\gate, 0, \fadeTime, 0.1);
    w = {
        | trigGate = 1 |
        // var sig = WhiteNoise.ar();
        // sig = VA1Pole.ar(sig, freq: 12500, feedback: -0.1, type:1);
        // sig = VADiodeFilter.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 500.0), res: 0.5, overdrive: 0.9);
        var t = Impulse.kr(~t.tempo * 8) * trigGate;
        var bl = Demand.kr(t, 0, Dseq([1, 0, 0, 0, 1, 0, 0, 0], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 3], [2, -4, 'lin']), t * bl).lag(0.1);
        var f = Demand.kr(t * bl, 0, Dseq(
            [0, -1, -3, -5, 0, -1, -3, -5], inf));
        var sig = MiBraids.ar(~toMidi.("Bb3") + f, timbre: 0.25, color: 0, model: 14);
        var freq = 80 + (500 - (env * 500));
        var lfo = SinOsc.kr(6).range(0.5, 1);
        sig = VadimFilter.ar(sig, 100 + (3000 * env.lag(0.01)), 0, 1);
        // sig = VadimFilter.ar(sig, (280 + (env * 500)).lag(1), resonance: 0, type: 1);
        // sig = VASEM12.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 15000.0), res:0.9, transition: LFSaw.kr(0.01).unipolar);
        // sig = VALadder.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 1000.0), res:0.5, overdrive:0.5, type:0);

        sig * 2.pow(-4)!2 * env.lag(0.001) * Line.kr(0, 1, 0.1);
    }.play;
});
)