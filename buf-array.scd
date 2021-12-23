~path = PathName.new("/Users/guillaumepelletier/Desktop/La beauté de 2021/pizzi2-full.wav");

~path.pathOnly.openOS

b = Buffer.read(s, ~path.fullPath);

(
~posA = [
    489680, 541824, 620640, 637544, 699608, 776416, 848976, 923432, 989168,
    1061480, 1069664, 1128400, 1133384, 1193512, 1200064, 1257936, 1263248,
    1319576, 1379816
];
)

(
~posB = [1762098, 1811875, 1863862, 1915998, 1967458, 2016113, 2062940,
    2115140, 2161995, 2207726, 2252953, 2297490, 2345011, 2390801
];
)
~posA.size;
~posB.size;


~t = TempoClock.new(1.5).permanent_(true);
~t.tempo

(
~t.sched(~t.timeToNextBeat(quant: 4), {
    x.set(\gate, 0, \fadeTime, 0.1);
    x = {
        | trigGate = 0 |
        var trig = Impulse.kr(~t.tempo * 2);
        // var p = ~pos;
        // var p = [1762098, 1811875, 1863862, 1915998];
        var p = Demand.kr(trig, 0, Dseq((0..3) + 8, inf));
        var fil = Demand.kr(trig, 0, Dseq((0..3).reverse, inf));
        // var dem = Demand.kr(trig, 0, Dseq(~pos, inf));
        var sig = PlayBuf.ar(2, b, 0.5, trigger: trig, startPos: Select.kr(p, ~posB), loop: 1);
        sig = VadimFilter.ar(sig, 1000 + (fil * 1000), 0, 1) * 1;
        // p[dem].poll;
        sig;
    }.play;
});
)


(
~t.sched(~t.timeToNextBeat(quant: 4) + (~t.beatDur * 0.5), {
    y.set(\gate, 0, \fadeTime, 0.1);
    y = {
        | trigGate = 0 |
        var trig = Impulse.kr(~t.tempo * 1);
        // var p = ~pos;
        // var p = [1762098, 1811875, 1863862, 1915998];
        var p = Demand.kr(trig, 0, Dseq((0..3).stutter(4) + 4, inf));
        var fil = Demand.kr(trig, 0, Dseq((0..3).stutter(1).reverse, inf));
        // var dem = Demand.kr(trig, 0, Dseq(~pos, inf));
        var sig = PlayBuf.ar(2, b, 1, trigger: trig, startPos: Select.kr(p, ~posB), loop: 1);
        sig = LinSelectX.ar(Demand.kr(trig, 0, Dseq([0, 1], inf)), [sig, sig.reverse]);
        sig = VadimFilter.ar(sig, 1000 + (fil * 1000), 0, 1);
        // p[dem].poll;
        sig;
    }.play;
});
)



(
~t.sched(~t.timeToNextBeat(quant: 4) + (~t.beatDur * 0.5), {
    y.set(\gate, 0, \fadeTime, 0.1);
    y = {
        | trigGate = 0 |
        var trig = Impulse.kr(~t.tempo * 4);
        // var p = ~pos;
        // var p = [1762098, 1811875, 1863862, 1915998];
        var p = Demand.kr(trig, 0,
            Dseq((0..3).stutter(4), inf) + 4 * Dseq((1!3) ++ [0], inf) +  Dseq((0!3) ++ 9, inf)
        );
        var fil = Demand.kr(trig, 0, Dseq((0..7).stutter(4).reverse, inf));
        // var dem = Demand.kr(trig, 0, Dseq(~pos, inf));
        var sig = PlayBuf.ar(2, b, 1, trigger: trig, startPos: Select.kr(p, ~posA), loop: 1);
        // var sig = XPlayBuf.ar(2, b, 1, trig, Select.kr(p, ~posA), -1);
        sig = LinSelectX.ar(Demand.kr(trig, 0, Dseq([0, 1], inf)), [sig, sig.reverse]);
        sig = VadimFilter.ar(sig, 1000 + (fil * 1000), 0, 1);
        // p[dem].poll;
        sig;
    }.play;
});
)


(
z.free;
z = {
    var sig = MiBraids.ar(48 + 19 + -5, 0.95, SinOsc.kr(3).range(0.5, 1), 0) * 0.01!2;
    sig;
}.play;
)


// ------------------------------------------------------------------------------
// Une ligne de basse très grasse, saturée, et inquiétante.
// ------------------------------------------------------------------------------

(
~t.sched(~t.timeToNextBeat(quant: 4), {
u.set(\gate, 0, \fadeTime, 0.1);
u = {
    | trigGate = 1 |
    // var sig = WhiteNoise.ar();
    // sig = VA1Pole.ar(sig, freq: 12500, feedback: -0.1, type:1);
    // sig = VADiodeFilter.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 500.0), res: 0.5, overdrive: 0.9);
    var t = Impulse.kr(~t.tempo * 0.5) * trigGate;
    var bl = Demand.kr(t, 0, Dseq([1, 0, 0, 0, 1, 0, 0, 0, 1, 1], inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 2], [2, 'lin', 'lin']), t * bl).lag(0.1);
    var f = Demand.kr(t * bl, 0, Dseq([0, 1, -2, -5], inf));
    var sig = MiBraids.ar(48 - 5 - 12 + f, timbre: 0.0, color: env, model: 14);
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
    // sig = VadimFilter.ar(sig, (280 + (env * 500)).lag(1), resonance: 0, type: 1);
    // sig = VASEM12.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 15000.0), res:0.9, transition: LFSaw.kr(0.01).unipolar);
    // sig = VALadder.ar(sig, freq: SinOsc.kr(0.1).exprange(80.0, 1000.0), res:0.5, overdrive:0.5, type:0);

    sig * 0.125 * 0.75;
}.play;
});
)