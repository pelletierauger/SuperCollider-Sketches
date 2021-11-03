(
v.set(\gate, 0, \fadeTime, 0.1);
v = {
    var trig, amp, sig, dem, dem2, dem3, dem4;
    trig = Impulse.kr(1 * 2);
    dem = Demand.kr(trig, 0 , Dseq([0.25, 0.05, 0.05, 0.05], inf));
    dem2 = Demand.kr(trig, 0 , Dseq(Pseries(0, 0.15, 4).asStream.nextN(4), inf));
    dem3 = Demand.kr(trig, 0, Dseq([2, 22].stutter(4), inf));
    dem4 = Demand.kr(trig, 0, Dseq([0, 2].stutter(8), inf));
    amp = EnvGen.kr(Env.new([0, 0.25, 0], [0.0125, 2]), trig);
    sig = MiPlaits.ar(25 + 12 - 2,
        engine: 13,
        harm: 0.5,
        timbre: 0.9,
        morph: 0.4,
        trigger: trig,
        decay: 0.2,
        lpg_colour: 0,
        mul: 2) * 0.25;
    sig = sig[0];
    sig = MiBraids.ar(
        pitch: 35 + 12, timbre: 0.24 + (dem2),
        color: 0.2 + (dem * 0.2), model: 34, trig: trig,
        resamp: 0, decim: dem3, bit: 6, ws: 0
    );
    sig = VAKorg35.ar(sig, freq: 200, res: 0, overdrive: 0.05) * 0.5;
    sig!2 * 2.2;
}.play(fadeTime: 0);

)