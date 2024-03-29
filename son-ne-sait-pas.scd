(
~pul3.free;
~pul3 = {
    var trig = Impulse.ar(1 * 8);
    /*        var dem = Demand.ar(trig, 0, Dseq(

    [1, 0, 1, 0]
    , inf));*/
    var dem = Demand.ar(trig, 0, Dseq(
        [1, 0, 0, 1, 0, 0, 1, 0] ++ [1, 0, 1, 0, 1, 0, 0, 0]
        , inf));
    var dec = Demand.ar(trig * dem, 0, Dseq([0.4] + 0.1, inf));
    var sig = MiPlaits.ar(42 - 36 + 24 + [0, 0.1],
        engine: 9,
        harm: 0.95,
        timbre: 1,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.25,
        trigger: trig * dem,
        decay: dec,
        lpg_colour: 0
    );
    // sig = HPF.ar(sig, 200);
    sig = [sig[0][1], sig[1][1]];
    sig = VadimFilter.ar(sig, 1000, resonance: 0, type: 5);
    sig = sig * 1.4 * SinOsc.kr(0.1).range(1, 2);
    // sig[1]!2;
}.play(fadeTime: 0.01);
)


(
~pul3.free;
~pul3 = {
    var trig = Impulse.kr(1 * 8);

    var dem = Demand.kr(trig, 0, Dseq(
        [1, 0, 0, 1, 0, 0, 1, 0] ++ [1, 0, 1, 0, 1, 0, 0, 0]
        , inf));
    var envD = Demand.kr(trig * dem, 0, Dseq([0.4, 1].stutter(3), inf));
    var fil = Demand.kr(trig * dem, 0, Dseq([2000, 7000].stutter(3), inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.005, envD], [-8, -8, 'lin']), trig * dem);
    var dec = Demand.kr(trig * dem, 0, Dseq([0.4] + 0.1, inf));
    var tim = Demand.kr(trig * dem, 0, Dseq([0.9, 0.9, 0.9, 0.6, 0.6, 0.6], inf));
    var sig = MiBraids.ar(42 - 36 + 24,
        timbre: tim,
        color: 1,
        model: 43,
        trig: trig * dem,
        resamp: 2,
        decim: 32,
        bits: 6,
        ws: 0
    ) * env;
    // sig = HPF.ar(sig, 200);
    // sig = [sig[0][1], sig[1][1]];
    var lsig = VadimFilter.ar(sig, fil, resonance: 0, type: 1);
    sig = VAKorg35.ar(lsig, freq: 100, res: 0.0, overdrive: 0.0) + (sig * 0.1);
    sig = sig * 1.4!2;
    // sig[1]!2;
}.play(fadeTime: 0.01);
)