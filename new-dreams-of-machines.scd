y.set(\gate, 0, \fadeTime, 30);

(
y.free;
y = {
    var f = 22 + 12 + 7 - 12 + 5 + 12 - 1 - 12 - 12 + 12;
    var lfo = SinOsc.kr(0.1).range(0.1, 0.12);
    var trig = Impulse.ar(4);
    var dem = Demand.ar(trig, 0, Dseq(Pseries(0, 0.025, 16).asStream.nextN(16), inf));
    var lfo2 = SinOsc.kr(0.1, pi / 2).range(0.6, 0.6) - 0.025;
    var dem2 = Demand.ar(trig, 0, Dseq([0, -5, -2, -7].stutter(16), inf));
    var alg = 6;
    var sig1 = MiPlaits.ar(f + dem2, alg, harm: lfo, morph: lfo2, trigger: trig, usetrigger: 1, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1 + dem2, alg, harm: lfo, morph: lfo2, trigger: trig, usetrigger: 1, mul: 0.2);
    var sig = [sig1[0], sig2[0]] * 2;
    LPF.ar(sig, SinOsc.kr(0.1).range(800, 8000)) * 2;
    // sig;
}.play;
)
