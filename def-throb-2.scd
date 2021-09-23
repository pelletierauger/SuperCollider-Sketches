(
{
~defThrob.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~defThrob = {
    | trigGate = 1 |
    //     var shape = LFTri.ar(0.11).range(0,1);
    // var shape = Line.ar(1, 0.5, 4, doneAction: 0);
    // var env = Line.ar(1, 0, 3, doneAction: 0);
    var t0 = Impulse.kr(1.5 * 2) * trigGate;
    var tt = Demand.kr(t0, 0, Dseq([1, 0, 0, 1, 1, 1, 0, 1], inf));
    var t = t0 * tt;
    var d = Demand.kr(t, 0, Dseq([0.5, 0.45].stutter(2).wrapExtend(5), inf));
    var f = Demand.kr(t, 0,
        Dseq([0, 3, -2, -5, -7].stutter(1).midiratio, inf)
        * Dseq([0, 5].stutter(10).midiratio, inf)
    ).lag(0.1);
    var env = EnvGen.kr(Env([0, 1, 0], [0.01, 3], [-8, -8]), gate: t, doneAction: 2);
    var shape = EnvGen.kr(Env([1, 1, d], [0.01, 4], [-8, -4]), gate: t, doneAction: 0);
    var slope = Demand.kr(t, 0, Dseq([0.5, 0.75].stutter(2).wrapExtend(5), inf));
    var smooth = 0.5;
    var shift = 0.2;
    var sig = MiTides.ar(55 * -5.midiratio * f, shape, slope, smooth, shift, output_mode: 2) * env;
    sig = sig[0];
    sig = VAKorg35.ar(sig, freq: 200, res: 0.1, overdrive: 0.05);
/*        sig = AnalogPhaser.ar(
        sig,
        SinOsc.ar(0.022 * [1, 1.1]),
        skew: SinOsc.kr(5.59 * [1, 1.1]),
        feedback: SinOsc.kr(0.005 * [1, 1.1], 1pi).range(0.8,0.85),
        modulation: SinOsc.kr(2.0192 * [1, 1.1], 2pi).unipolar,
        // modulation: 0.25,
        stages: 50
    );*/
    sig!2 * 2;
}.play;
    2.wait;
    ~k.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~k = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var t = Impulse.kr(1.5 * 0.5) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10], inf));
        var sig = MiBraids.ar(
            pitch: 24 + 12 + Demand.kr(t, 0, Dseq([0, -1].stutter(4), inf)),
            timbre: 0.9,
            color: 0.3,
            model: 34,
            trig: t,
            resamp: [0, 2],
            decim: 32,
            bits: Demand.kr(t, 0, Dseq([2, 4, 6, 4], inf)),
            ws: 1
        );
        sig = (sig[0] + (sig[1] * 0.2 * sig[0]))!2;
        // sig = HPF.ar(sig, 2400);
            sig = VadimFilter.ar(sig, 2400, resonance: 0, type: 5);

        sig * 2 * 8;
    }.play;
}.fork;
)