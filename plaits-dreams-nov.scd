(
// x.free;
x = {
    var f = 30 + 24 + -12;
    var lfo = SinOsc.kr(0.1).range(0.1, 0.12);
    var trig = Impulse.ar(1);
    var n = 16;
    var dem = Demand.ar(trig, 0, Dseq(Pseries(0, 1/n, n).asStream.nextN(n).mirror2, inf));
    var dem2 = Demand.ar(trig, 0, Dseq([0, 1].stutter(4), inf));
    var alg = 5;
    var dec = 0.1;
    var sig1 = MiPlaits.ar(f + dem2, alg, harm: lfo, morph: dem, trigger: trig, decay: dec, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1 + dem2, alg, harm: lfo, morph: dem, trigger: trig, decay: dec, mul: 0.2);
    var sig = [sig1[0], sig2[0]] * 1.5;
    sig;
    // LPF.ar(sig, 200 + (10000 * dem)) * 2;
}.play;
)
(
y.free;
y = {
    var f = 30 + 12 + 0;
    var lfo = SinOsc.kr(0.1).range(0.1, 0.12);
    var trig = Impulse.ar(2);
    var n = 32;
    var dem = Demand.ar(trig, 0, Dseq(Pseries(0, 1/n, n).asStream.nextN(n).mirror2, inf));
    var dem2 = Demand.ar(trig, 0, Dseq(0, inf));
    var alg = 5;
    var dec = 0.4;
    var sig1 = MiPlaits.ar(f + dem2, alg, harm: lfo, morph: dem * 0.5, trigger: trig, decay: dec, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1 + dem2, alg, harm: lfo, morph: dem * 0.5, trigger: trig, decay: dec, mul: 0.2);
    var sig = [sig1[0], sig2[0]] * 1.5;
    LPF.ar(sig, 200 + (10000 * dem)) * 2;
}.play;
)