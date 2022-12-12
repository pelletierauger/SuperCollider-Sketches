(
x.free;
x = {        | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var d = Demand.kr(t, 0, Dseq([12, 12, 5, 3].stutter(32), inf));
    var f = 31 - 7 + d;
    // var lfo = SinOsc.kr(0.1).range(0.1, 0.25);
    var lfo = 0.9;
    var alg = 5;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig = [sig1[0], sig2[0]] * 1;
    // sig = VadimFilter.ar(sig, 1000, 0, 5) * 2;
    sig;
    // VadimFilter.ar(sig, 2000 * SinOsc.kr(~nT.tempo * 8).unipolar + 2500, 0, 1);
}.play;
)

(
x = {
    var f = 31 + 36 + -5;
    // var lfo = SinOsc.kr(0.1).range(0.25, 0.5);
    var lfo = 0.75;
    var alg = 0;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, timbre: 0.125, morph: 0.4, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, timbre: 0.125, morph: 0.4, mul: 0.2);
    var sig3 = [sig1[0], sig2[0]];
    var throb = SinOsc.kr(0.1).range(1930, 4200);
    MoogFF.ar(sig3, throb, 0.83 * 4);
}.play;
)
x.free;
MoogFF

(
x = {
    MoogFF.ar(
        Pulse.ar([40,121], [0.3,0.7]),
        SinOsc.kr(LFNoise0.kr(0.42).range(0.001, 2.2)).range(30, 4200),
        0.83 * 4)}.play(s);
)
x.free;



(
x = {
    var f = 31 + 36 + -5;
    // var lfo = SinOsc.kr(0.1).range(0.25, 0.5);
    var lfo = 0.75;
    var alg = 0;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, timbre: 0.125, morph: 0.4, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, timbre: 0.125, morph: 0.4, mul: 0.2);
    var sig3 = [sig1[0], sig2[0]];
    var throb = SinOsc.kr(0.1).range(1930, 4200);
    MoogFF.ar(sig3, throb, 0.83 * 4);
}.play;
TempoClock.default.sched(3, {
x = {
    var f = 31 + 36 + 0;
    // var lfo = SinOsc.kr(0.1).range(0.25, 0.5);
    var lfo = 0.75;
    var alg = 0;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, timbre: 0.125, morph: 0.4, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, timbre: 0.125, morph: 0.4, mul: 0.2);
    var sig3 = [sig1[0], sig2[0]];
    var throb = SinOsc.kr(0.1).range(1930, 4200);
    MoogFF.ar(sig3, throb, 0.83 * 4);
}.play;
});
TempoClock.default.sched(5, {
x = {
    var f = 31 + 36 + 2;
    // var lfo = SinOsc.kr(0.1).range(0.25, 0.5);
    var lfo = 0.75;
    var alg = 0;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, timbre: 0.125, morph: 0.4, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, timbre: 0.125, morph: 0.4, mul: 0.2);
    var sig3 = [sig1[0], sig2[0]];
    var throb = SinOsc.kr(0.1).range(1930, 4200);
    MoogFF.ar(sig3, throb, 0.83 * 4);
}.play;
});
)


