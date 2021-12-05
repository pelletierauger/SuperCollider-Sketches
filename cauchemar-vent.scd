(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
x.set(\trigGate, 0, \gate, 0, \fadeTime, 4.1);
x = {
    | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * [2, 4]) * trigGate;
 var d = Demand.kr(t[1], 0, Dseq([10, 9, 15, 14].stutter(16), inf));
 var dd = Demand.kr(t[1], 0, Dseq([0.2, 0.1].stutter(1), inf));
    // var bl = Demand.kr(t, 0, Dseq([1, 0, 0, 0, 1, 0, 0, 0, 1, 1], inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 0.2], [2, 'lin', 'lin']), t).lag(0.1);
    var f = Demand.kr(t, 0, Dseq([0, 1, -2, -5], inf));
    var ff = Demand.kr(t, 0, Dseq([2, 3, 4, 5], inf));
    var sig = MiBraids.ar(
        59 + [d, 0].stutter(2) + [0, 0.1].wrapExtend(4) - 24,
        timbre: 0.1 + (0.075 * env), color: 0.3, model: 14,
        resamp: 0, decim: 6, bits: ff, ws: 0
    );
    var freq = 80 + (500 - (env * 500));
    sig = [sig[0] + sig[2], sig[1] + sig[3]] * env;
        // sig = Decimator.ar(sig, 1000, 4);
        sig = VadimFilter.ar(sig, 100 + (2000 * env), 0, 1);
        sig = VAKorg35.ar(sig * 0.2, freq: freq + 2000, res: 0.4, overdrive: 0.95);
    sig * 0.25;
}.play
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~wind.set(\gate, 0, \fadeTime, 1);
~wind = {
    var sig = WhiteNoise.ar(0.525);
    var t = Impulse.kr(~nT.tempo);
    var d = Demand.kr(t, 0, Dseq([0, 3, 8 + 1, 7 + 1] + 59 - 12, inf));
    // var sig = SinOsc.ar(100);
    VADiodeFilter.ar(
        sig, freq: d.midicps.lag(0.5),
        res: 0.75, overdrive: 0.5
    ) * 0.125!2 * Line.kr(0, 1, 2);
}.play;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~wind.set(\gate, 0, \fadeTime, 1);
~wind = {
    var sig = WhiteNoise.ar(0.525);
    var t = Impulse.kr(~nT.tempo);
    var d = Demand.kr(t, 0, Dseq([0, 3, 8 + 1, 7 + 1] + 59 - 0, inf));
    // var sig = SinOsc.ar(100);
    sig = VADiodeFilter.ar(
        sig, freq: d.midicps.lag(0.5),
        res: 0.75, overdrive: 0.5
    ) * 0.25!2 * Line.kr(0, 0.6, 2);
        VadimFilter.ar(sig, 2000, 0, 1) * 0.5;
}.play;
});
)



(
{
    var sig = WhiteNoise.ar(0.525);
    var t = Impulse.kr(~nT.tempo);
    var d = Demand.kr(t, 0, Dseq([0, 3, 8, 7] + 59 - 24, inf));
    // var sig = SinOsc.ar(100);
    VADiodeFilter.ar(
        sig, freq: SinOsc.kr(0.1).exprange(80.0, 500.0),
        res: 0.75, overdrive:0.9) * 1!2;
}.play;
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~wind.set(\gate, 0, \fadeTime, 1);
~wind = {
    var sig = WhiteNoise.ar(0.525);
    var t = Impulse.kr(~nT.tempo);
    var d = Demand.kr(t, 0, Dseq([0, 3, 8, 7] + 59 - 12, inf));
    // var sig = SinOsc.ar(100);
    VALadder.ar(
        sig, freq: d.midicps.lag(0.5),
        res: 0.75, overdrive: 0.25, type: 0
    ) * 0.25!2 * Line.kr(0, 1, 2);
}.play;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
        [~basse].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});});

    ~basse = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * [2, 4]) * trigGate;
        var d = Demand.kr(trig, 0, Dseq([0, 3, 5, 8].stutter(1).reverse, inf));
        var sig = MiPlaits.ar(
            pitch: 59 + [d, d].stutter(2) - 12 + [0, 0.1].wrapExtend(4),
            engine: 11,
            harm: 0.125,
            timbre: 1,
            morph: 0.3,
            trigger: trig.stutter(2),
            decay: 1,
            lpg_colour: 0.5,
            fm_mod: 0.1,
            timb_mod: 0.75,
            morph_mod: 0.95
        );
        sig = [sig[0][0] + sig[2][0], sig[1][0] + sig[3][0]];
        sig = VadimFilter.ar(sig, 1000, 0, 1) * 0.6 * 0.5;
        // VAKorg35.ar(sig * 0.25, 1500, 0.5, 2);
    }.play.register;
});
)