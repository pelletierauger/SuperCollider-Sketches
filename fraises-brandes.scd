(
~t.sched(~t.timeToNextBeat(quant: 4) + (~t.beatDur * 0.5), {
    a.set(\gate, 0, \fadeTime, 0.1);
    a = {
        | trigGate = 0 |
        var trig = Impulse.kr(~t.tempo * 4);
        // var p = ~pos;
        // var p = [1762098, 1811875, 1863862, 1915998];
        var p = Demand.kr(trig, 0, Dseq((0..3).stutter(4) + 4, inf));
        var fil = Demand.kr(trig, 0, Dseq((0..3).stutter(1).reverse, inf));
        // var dem = Demand.kr(trig, 0, Dseq(~pos, inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 0.1]), trig);
        var sig = PlayBuf.ar(2, b, 1, trigger: trig, startPos: Select.kr(p, ~posB), loop: 1);
        sig = LinSelectX.ar(Demand.kr(trig, 0, Dseq([0, 1], inf)), [sig, sig.reverse]);
        sig = VadimFilter.ar(sig, 1000 + (fil * 1000), 0, 5) * e;
        sig = VadimFilter.ar(sig, 8000, 0, 1);
        // p[dem].poll;
        sig * 4;
    }.play;
});
)


(
~t.sched(~t.timeToNextBeat(quant: 4) + (~t.beatDur * 0.5), {
    c.set(\gate, 0, \fadeTime, 0.1);
    c = {
        | trigGate = 0 |
        var trig = Impulse.kr(~t.tempo * 4);
        // var p = ~pos;
        // var p = [1762098, 1811875, 1863862, 1915998];
        var p = Demand.kr(trig, 0, Dseq((0..3).stutter(8) + 4, inf));
        var fil = Demand.kr(trig, 0, Dseq((0..3).stutter(1).reverse, inf));
        // var dem = Demand.kr(trig, 0, Dseq(~pos, inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 0.05]), trig);
        var sig = PlayBuf.ar(2, b, 1, trigger: trig, startPos: Select.kr(p, ~posB), loop: 1);
        sig = LinSelectX.ar(Demand.kr(trig, 0, Dseq([0, 1], inf)), [sig, sig.reverse]);
        sig = VadimFilter.ar(sig, 1000 + (fil * 1000), 0, 5) * e;
        sig = VadimFilter.ar(sig, 8000, 0, 1);
        sig = sig + MiRings.ar(sig, 48, model: 1);
        // p[dem].poll;
        sig * 2 * 1;
    }.play;
});
)


(
~t.sched(~t.timeToNextBeat(quant: 4) + (~t.beatDur * 0.5), {
    a.set(\gate, 0, \fadeTime, 0.1);
    a = {
        | trigGate = 0 |
        var t = Impulse.kr(~t.tempo * 4);
        var trig = t * Demand.kr(t, 0, Dseq([1, 1, 0, 0].stutter(16), inf));
        // var p = ~pos;
        // var p = [1762098, 1811875, 1863862, 1915998];
        var p = Demand.kr(trig, 0, Dseq((0..3).stutter(8) + 4, inf));
        var fil = Demand.kr(trig, 0, Dseq((0..3).stutter(2).reverse, inf));
        // var dem = Demand.kr(trig, 0, Dseq(~pos, inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 0.05]), trig);
        var sig = PlayBuf.ar(2, b, 1, trigger: trig, startPos: Select.kr(p, ~posB), loop: 1);
        sig = LinSelectX.ar(Demand.kr(trig, 0, Dseq([0, 1], inf)), [sig, sig.reverse]);
        sig = VadimFilter.ar(sig, 1000 + (fil * 1000), 0, 5) * e;
        sig = VadimFilter.ar(sig, 8000, 0, 1);
        sig = sig * 0.05 + MiRings.ar(
            sig,
            pit: 60 - 3, struct: 0.4, bright: 0.15, model: 1);
        // p[dem].poll;
        sig * 4 * 8 * 4;
    }.play;
});
)

(
~t.sched(~t.timeToNextBeat(quant: 4), {
    u.set(\gate, 0, \fadeTime, 0.1);
    u = {
        | trigGate = 1 |
        // var sig = WhiteNoise.ar();
        // sig = VA1Pole.ar(sig, freq: 12500, feedback: -0.1, type:1);
        // sig = VADiodeFilter.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 500.0), res: 0.5, overdrive: 0.9);
        var t = Impulse.kr(~t.tempo * 0.5) * trigGate;
        var bl = Demand.kr(t, 0, Dseq([1, 0, 0, 0, 1, 0, 0, 0], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.025, 6], [2, 'lin', 'lin']), t * bl).lag(0.1);
        var f = Demand.kr(t * bl, 0, Dseq([0, -2, -5, -7], inf));
        var sig = MiBraids.ar(48 - 5 - 0 + f, timbre: 0.05, color: env, model: 39);
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
        sig = VadimFilter.ar(sig, 6000, 0, 1);
        // sig = VadimFilter.ar(sig, (280 + (env * 500)).lag(1), resonance: 0, type: 1);
        // sig = VASEM12.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 15000.0), res:0.9, transition: LFSaw.kr(0.01).unipolar);
        // sig = VALadder.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 1000.0), res:0.5, overdrive:0.5, type:0);

        sig * 0.25 * 0.25 * Line.kr(0, 1, 0.1);
    }.play;
});
)