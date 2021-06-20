(
n.set(\gate, 0, \fadeTime, 1);
n = {
    var freq = 61;
    // var trig = Impulse.kr(8 * 1, 0.1);
    var trig = Demand.kr(Impulse.kr(8 * 4, 0.1), 0, Dseq([1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0], inf));
    var dem = Demand.kr(trig, 0, Dseq(([1, 3, 1, 6] ++ [1, 3, 8, 10]).stutter(16), inf));
    var dem2 = Demand.kr(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
    var amp = EnvGen.kr(Env.new([0, 1, 0], [0.05, 0.025]), trig);
    var sig = MiPlaits.ar(freq + [0, 0.1] + dem + 2,
        engine: 2,
        harm: 0.65,
        timbre: 0.25,
        morph: 0.45,
        trigger: trig,
        decay: 0.25
    );
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    sig = [sig[0][0], sig[1][0]];
    LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo * 0.25;
}.play(fadeTime: 0.1);
m.set(\gate, 0, \fadeTime, 0.1);
m = {
    var freq = 61 - 12;
    // var trig = Impulse.kr(8, 0.1);
    var trig = Demand.kr(Impulse.kr(8 * 4, 0.1), 0, Dseq([1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0], inf));
    var dem = Demand.kr(trig, 0, Dseq(([1, 3, 1, 6] ++ [1, 3, 8, 10]).reverse.stutter(4), inf));
    var dem2 = Demand.kr(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
    var amp = EnvGen.kr(Env.new([0, 1, 0], [0.05, 0.025]), trig);
    var sig = MiPlaits.ar(freq + [0, 0.1] + dem + 2,
        engine: 2,
        harm: 0.65,
        timbre: 0.25,
        morph: 0.45,
        trigger: trig,
        decay: 0.25
    );
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    sig = [sig[0][0], sig[1][0]];
    LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo * 0.25;
}.play(fadeTime: 1);
)



(
n.set(\gate, 0, \fadeTime, 1);
n = {
    var freq = 61;
    // var trig = Impulse.kr(8 * 1, 0.1);
    var trig = Demand.kr(Impulse.kr(8 * 4, 0.1), 0, Dseq([1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0], inf));
    var dem = Demand.kr(trig, 0, Dseq(([1, 3, 1, 6] ++ [1, 3, 8, 10]).stutter(16), inf));
    var dem2 = Demand.kr(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
    var amp = EnvGen.kr(Env.new([0, 1, 0], [0.05, 0.025]), trig);
    var sig = MiPlaits.ar(freq + [0, 0.1] + dem + 2,
        engine: 2,
        harm: 0.65,
        timbre: 0.25,
        morph: 0.45,
        trigger: trig,
        decay: 0.25
    );
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    sig = [sig[0][0], sig[1][0]];
    LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo * 0.25;
}.play(fadeTime: 0.1);
m.set(\gate, 0, \fadeTime, 0.1);
m = {
    var freq = 61 - 12;
    // var trig = Impulse.kr(8, 0.1);
    var trig = Demand.kr(Impulse.kr(8 * 4, 0.1), 0, Dseq([1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0], inf));
    var dem = Demand.kr(trig, 0, Dseq(([1, 3, 1, 6] ++ [1, 3, 8, 10]).reverse.stutter(4), inf));
    var dem2 = Demand.kr(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
    var amp = EnvGen.kr(Env.new([0, 1, 0], [0.05, 0.025]), trig);
    var sig = MiPlaits.ar(freq + [0, 0.1] + dem + 2,
        engine: 2,
        harm: 0.65,
        timbre: 0.25,
        morph: 0.45,
        trigger: trig,
        decay: 0.25
    );
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    sig = [sig[0][0], sig[1][0]];
    LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo * 0.25;
}.play(fadeTime: 1);
)
