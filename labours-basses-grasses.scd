// ------------------------------------------------------------------------------
// Une ligne de basse très grasse, saturée, et inquiétante.
// ------------------------------------------------------------------------------
~toNote.(48 - 5)
(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    | trigGate = 1 |
    // var sig = WhiteNoise.ar();
    // sig = VA1Pole.ar(sig, freq: 12500, feedback: -0.1, type:1);
    // sig = VADiodeFilter.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 500.0), res: 0.5, overdrive: 0.9);
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t0 = tr[1] * dd;
    var t = t0 * Demand.kr(t0, 0, Dseq([1, 0], inf));

    var bl = Demand.kr(t, 0, Dseq([1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0], inf));
    var env = EnvGen.kr(Env([0, 1, 0], [1, 4], [2, 'lin', 'lin']), t * bl).lag(0.1);
    var f = Demand.kr(t * bl, 0, Dseq([0, 7, 8, 0, 8, 7], inf));
    var sig = MiBraids.ar(~toMidi.("D1") + f, timbre: 0.0, color: 0, model: 14);
    var freq = 80 + (100 + (env * 500));
    // SinOsc.kr(0.1).exprange(80.0, 1000.0)
    sig = VAKorg35.ar(sig, freq: freq, res: 0.1, overdrive: 0.05);
/*    sig = AnalogPhaser.ar(
        sig,
        SinOsc.ar(0.022 * [1, 1.1]),
        skew: SinOsc.kr(5.59 * [1, 1.1]),
        feedback: SinOsc.kr(0.005 * [1, 1.1], 1pi).range(0.8,0.85),
        modulation: SinOsc.kr(2.0192 * [1, 1.1], 2pi).unipolar,
        // modulation: 0.25,
        stages: 50
    );*/
    // sig = MiVerb.ar(sig);
    // sig = ~v.(sig, 1500);
    // sig = VadimFilter.ar(sig, (280 + (env * 500)).lag(1), resonance: 0, type: 1);
    // sig = VASEM12.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 15000.0), res:0.9, transition: LFSaw.kr(0.01).unipolar);
    // sig = VALadder.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 1000.0), res:0.5, overdrive:0.5, type:0);
    sig = sig ! 2 * env;
    sig = sig + ~v.(CombC.ar(sig, 1, ~nT.beatDur/16*[1,1.001], ~nT.beatDur*4)*1,1500);
    // sig = sig + ~v.(CombC.ar(sig, 1, ~nT.beatDur/8, ~nT.beatDur*4)*0.5,1500);
    sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/128*4), lev1: 0.5, lev2: 0.5,
        algo: 3, timb: 0.125, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 0.5;
    sig = [sig[0][0], sig[1][0]];
    // sig = MiVerb.ar(sig);
    sig * 0.125 * 2 * dd.lag(0.05);
}.play;
)
s.mute
s.unmute

// ------------------------------------------------------------------------------
// Une ligne de basse sourde, très douce mais menaçante, et très grasse.
// ------------------------------------------------------------------------------

(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    | trigGate = 1 |
    // var sig = WhiteNoise.ar();
    // sig = VA1Pole.ar(sig, freq: 12500, feedback: -0.1, type:1);
    // sig = VADiodeFilter.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 500.0), res: 0.5, overdrive: 0.9);
    var t = Impulse.kr(0.25 * 4) * trigGate;
    var bl = Demand.kr(t, 0, Dseq([1, 0, 0, 0, 1, 0, 0, 0, 1, 1], inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 15], [2, 'lin', 'lin']), t * bl).lag(0.1);
    var f = Demand.kr(t * bl, 0, Dseq([0, 1, -2, -5], inf));
    var sig = MiBraids.ar(48 - 5 - 12 + f, timbre: 0.0, color: env, model: 17);
    var freq = 80 + (500 - (env * 500));
    // SinOsc.kr(0.1).exprange(80.0, 1000.0)
    sig = VAKorg35.ar(sig, freq: freq, res: 0.1, overdrive: 0.05);
/*    sig = AnalogPhaser.ar(
        sig,
        SinOsc.ar(0.022 * [1, 1.1]),
        skew: SinOsc.kr(5.59 * [1, 1.1]),
        feedback: SinOsc.kr(0.005 * [1, 1.1], 1pi).range(0.8,0.85),
        modulation: SinOsc.kr(2.0192 * [1, 1.1], 2pi).unipolar,
        // modulation: 0.25,
        stages: 50
    );*/
    // sig = VadimFilter.ar(sig, (280 + (env * 500)).lag(1), resonance: 0, type: 1);
    // sig = VASEM12.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 15000.0), res:0.9, transition: LFSaw.kr(0.01).unipolar);
    // sig = VALadder.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 1000.0), res:0.5, overdrive:0.5, type:0);

    sig!2 * 0.25;
}.play
)

// ------------------------------------------------------------------------------
// Une ligne de basse très carrée, et douce.
// ------------------------------------------------------------------------------

(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    | trigGate = 1 |
    // var sig = WhiteNoise.ar();
    // sig = VA1Pole.ar(sig, freq: 12500, feedback: -0.1, type:1);
    // sig = VADiodeFilter.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 500.0), res: 0.5, overdrive: 0.9);
    var t = Impulse.kr(0.25 * 4) * trigGate;
    var bl = Demand.kr(t, 0, Dseq([1, 0, 0, 0, 1, 0, 0, 0, 1, 1], inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 15], [2, 'lin', 'lin']), t * bl).lag(0.1);
    var f = Demand.kr(t * bl, 0, Dseq([0, 1, -2, -5], inf));
    var sig = MiBraids.ar(48 - 5 - 0 + f, timbre: 0.0, color: env, model: 3);
    var freq = 80 + (500 - (env * 500));
    // SinOsc.kr(0.1).exprange(80.0, 1000.0)
    sig = VAKorg35.ar(sig, freq: freq, res: 0.8, overdrive: 0.95);
/*    sig = AnalogPhaser.ar(
        sig,
        SinOsc.ar(0.022 * [1, 1.1]),
        skew: SinOsc.kr(5.59 * [1, 1.1]),
        feedback: SinOsc.kr(0.005 * [1, 1.1], 1pi).range(0.8,0.85),
        modulation: SinOsc.kr(2.0192 * [1, 1.1], 2pi).unipolar,
        // modulation: 0.25,
        stages: 50
    );*/
    // sig = VadimFilter.ar(sig, (280 + (env * 500)).lag(1), resonance: 0, type: 1);
    // sig = VASEM12.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 15000.0), res:0.9, transition: LFSaw.kr(0.01).unipolar);
    // sig = VALadder.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 1000.0), res:0.5, overdrive:0.5, type:0);

    sig!2 * 0.25;
}.play
)