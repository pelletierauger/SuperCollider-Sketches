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
        var f = Demand.kr(t * bl, 0, Dseq([0, -1, -3, -1], inf));
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

        sig * 1 * env.lag(0.1) * Line.kr(0, 1, 0.1);
    }.play;
});
)



~toMidi.("G3") + [0, -2, -5, -5]
~toMidi.("Bb3") + [0, -1, -3, -5]

(
~t.sched(~t.timeToNextBeat(quant: 4), {
    v.set(\gate, 0, \fadeTime, 0.1);
    v = {
        | trigGate = 1 |
        // var sig = WhiteNoise.ar();
        // sig = VA1Pole.ar(sig, freq: 12500, feedback: -0.1, type:1);
        // sig = VADiodeFilter.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 500.0), res: 0.5, overdrive: 0.9);
        var envGate = EnvGate.new();
        var t = Impulse.kr(~t.tempo * 0.5) * trigGate;
        var bl = Demand.kr(t, 0, Dseq([1, 0, 0, 0, 1, 0, 0, 0], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [1, 4], [2, 'lin', 'lin']), t * bl).lag(0.1);
        var f = Demand.kr(t * bl, 0, Dseq([0, -2, -5, -5], inf));
        var sig = MiBraids.ar(~toMidi.("G5") + f, timbre: 0.25, color: 0.25, model: 14);
        var freq = 80 + (500 - (env * 500));
        // SinOsc.kr(0.1).exprange(80.0, 1000.0)
        // sig = VAKorg35.ar(sig, freq: freq, res: 0.1, overdrive: 0.05);

        sig = VadimFilter.ar(sig, 1000, 0, 5);
        sig = MiRings.ar(sig, pit: ~toMidi.("G2") + f, damp: 0.2, model: 2) * 4;
        sig = AnalogPhaser.ar(
            sig,
            SinOsc.ar(0.022 * [1, 1.1]),
            skew: SinOsc.kr(5.59 * [1, 1.1]),
            feedback: SinOsc.kr(0.005 * [1, 1.1], 1pi).range(0.8,0.85),
            modulation: SinOsc.kr(2.0192 * [1, 1.1], 2pi).unipolar,
            // modulation: 0.25,
            stages: 50
        );        // sig = VadimFilter.ar(sig, (280 + (env * 500)).lag(1), resonance: 0, type: 1);
        // sig = VASEM12.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 15000.0), res:0.9, transition: LFSaw.kr(0.01).unipolar);
        // sig = VALadder.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 1000.0), res:0.5, overdrive:0.5, type:0);

        sig = sig * 0.1 * env.lag(0.1) * Line.kr(0, 1, 0.1);
        Out.ar(0, sig);
    }.play;

// });

        u.set(\gate, 0, \fadeTime, 0.1);
    u = {
        | trigGate = 1 |
        // var sig = WhiteNoise.ar();
        // sig = VA1Pole.ar(sig, freq: 12500, feedback: -0.1, type:1);
        // sig = VADiodeFilter.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 500.0), res: 0.5, overdrive: 0.9);
        var envGate = EnvGate.new();
        var t = Impulse.kr(~t.tempo * 0.5) * trigGate;
        var bl = Demand.kr(t, 0, Dseq([1, 0, 0, 0, 1, 0, 0, 0], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [1, 4], [2, 'lin', 'lin']), t * bl).lag(0.1);
        var f = Demand.kr(t * bl, 0, Dseq([0, -1, -3, -5], inf));
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

        sig = sig * 1 * env.lag(0.1) * Line.kr(0, 1, 0.1);
        Out.ar(0, sig);
    }.play;
});
)