(
o.set(\gate, 0, \fadeTime, 1);
o = {
    var freq = 61 + 10;
    var trig = Impulse.kr(0.5, 0.1);
    var dem = Demand.kr(trig, 0, Dseq(([-4, -2]).stutter(2), inf));
    var dem2 = Demand.kr(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
    var sig = MiPlaits.ar(freq + [0, 0.1] + dem,
        engine: 2,
        harm: 0.65,
        timbre: 0.5,
        morph: 0.45,
        trigger: trig,
        decay: 0.5
    );
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    sig = [sig[0][0], sig[1][0]];
    LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo * 0.1;
}.play;
)


(
o.set(\gate, 0, \fadeTime, 1);
o = {
    var freq = 61 + 10 - 12;
    var trig = Impulse.kr(0.5, 0.1);
    var dem = Demand.kr(trig, 0, Dseq(([-4, -2]).stutter(2), inf));
    var dem2 = Demand.kr(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
    var sig = MiPlaits.ar(freq + [0, 0.1] + dem,
        engine: 2,
        harm: 0.65,
        timbre: 0.5,
        morph: 0.45,
        trigger: trig,
        decay: 0.9
    );
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    sig = [sig[0][0], sig[1][0]];
    LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo * 0.1;
}.play;
)