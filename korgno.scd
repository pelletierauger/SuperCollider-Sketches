(
Ndef(\onepole, {
    var sig = WhiteNoise.ar();
    //     sig = VA1Pole.ar(sig, freq: 12500, feedback: -0.1, type:1);
    sig!2;
}).play
)

(
Ndef(\diode, {
    var sig = WhiteNoise.ar(0.525);
    // var sig = SinOsc.ar(100);
    VADiodeFilter.ar(sig, freq: SinOsc.kr(1).exprange(80.0,5000.0), res:0.9, overdrive:0.9)
}).play
)

(
{
    var sig = WhiteNoise.ar(0.525!2);
    // var sig = MiBraids.ar(60 + [0, 0.2], timbre: 0.85, color: 0.25, model: 43);
    var t0 = Impulse.kr(1);
    var d0 = Demand.kr(t0, 0, Dseq([2, 4].stutter(4) / 4, inf));
    var t = Impulse.kr(1);
    var d = Demand.kr(t, 0, Dseq([2, 1], inf) * 0.25);
    var d2 = Demand.kr(t, 0, Dseq([0, 1], inf) * 0.25).lag(0.1);
    var env = EnvGen.kr(Env.perc(0.001, 1 / d, 1, -8), gate: t);
    sig = VAKorg35.ar(sig, freq: 80 + (d * 200 * env.pow(3)), res: 0.1, overdrive: d2);
    // var sig = SinOsc.ar(100);
    //     sig = VAKorg35.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0,5000.0), res:0.1, overdrive:0.0);
    // sig =     VASEM12.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0,15000.0), res:0.9, transition: LFSaw.kr(0.01).unipolar);

    // sig.size.poll;
    sig * env * 0.1;
}.play
)

Env.perc(0.001, 1, 1, -4).test.plot;

(
{
    var sig = WhiteNoise.ar(0.525)!2;
    // sig.size.poll;
    // var sig = SinOsc.ar(100);
    VASEM12.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0,15000.0), res:0.9, transition: LFSaw.kr(0.01).unipolar);
}.play
)

(
Ndef(\ladderj, {
    var sig = WhiteNoise.ar(0.525);
    // var sig = SinOsc.ar(100);
    VALadder.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0,5000.0), res:0.5, overdrive:0.5, type:0)
}).play