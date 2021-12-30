(
SynthDef(\chorus, {
    | trigGate = 0, f = 1 |
    var trig = Impulse.kr(~t.tempo * 1);
    // var p = ~pos;
    // var p = [1762098, 1811875, 1863862, 1915998];
    var p = Demand.kr(trig, 0,
        Dseq(([1]).stutter(4), inf) + 4 * Dseq((1!3) ++ [0], inf) +  Dseq((0!3) ++ 9, inf)
    );
    var fil = Demand.kr(trig, 0, Dseq((4..7).stutter(4).reverse, inf));
    var r = 0.01;
    var e = EnvGen.kr(Env([0, 1, 0.5, 0], [r, ~t.beatDur - (r * 2), r]), trig).lag(0.01);
    // var dem = Demand.kr(trig, 0, Dseq(~pos, inf));
    var sig = PlayBuf.ar(2, b, 0.25, trigger: trig, startPos: Select.kr(p, ~posB), loop: 1);
    // var sig = XPlayBuf.ar(2, b, 1, trig, Select.kr(p, ~posA), -1);
    sig = LinSelectX.ar(Demand.kr(trig, 0, Dseq([0, 1], inf)), [sig, sig.reverse]) * e;
    sig = VadimFilter.ar(sig, 1000 + (fil * 1000), 0, 1);
    /*                sig = AnalogPhaser.ar(
    sig,
    SinOsc.ar(0.022 * [1, 1.1]),
    skew: SinOsc.kr(5.59 * [1, 1.1]),
    feedback: SinOsc.kr(0.005 * [1, 1.1], 1pi).range(0.8,0.85),
    modulation: SinOsc.kr(2.0192 * [1, 1.1], 2pi).unipolar,
    // modulation: 0.25,
    stages: 50
    );*/
    sig = VSTPlugin.ar(sig, 2,
        // params: [0, 10, 1, 11, 1, 12, 1, 15, 1],
        // params: [0, SinOsc.kr(1).range(0, 1) * 40],
        // info: 'CHOWTapeModel.vst3'
        bypass: 0,
/*        params: [
            // Mix: 1,
            // PreDelay: 0,
            3, f,
            // BassMult: 0,
            // EarlyDiffusion: 0

        ],*/
        // id: \verby,
        info: 'ValhallaVintageVerb.vst3'
    );
    // p[dem].poll;
    Out.ar(0, sig);
}).add;
// });
)
~fx.set(3, 100.04)
~fx.set(9, 0.05)

~fx.set(10, 0.5)
~fx.set(11, 6) // ModRate
~fx.set(12, 0) // ModDepth
~fx.set(15, 1) // ColorMode
~fx.set(16, 2) // ReverbMode

~fx = VSTPluginController(Synth(\chorus)).open; // will open 'GChorus'