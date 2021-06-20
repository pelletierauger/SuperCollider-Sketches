x.free;
(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    var f = 33;
    var lfo = SinOsc.kr(0.1).range(0.1, 0.2);
    var alg = 5;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, morph: 0, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    [sig1[0], sig2[0]] * 2 * Line.kr(0, 1, 1);
}.play;
)
(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    var f = 33;
    var lfo = SinOsc.kr(0.1).range(0.1, 0.2);
    var sig = MiPlaits.ar(
        pitch: f + [0, 0.1],
        engine: 5,
        harm: lfo,
        morph: 0
    );
    [sig[0][0], sig[1][0]] * 0.4;
}.play(fadeTime: 1);
)
(
x = {
    var f = 31 + 36 + -5 - 12;
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
    var f = 31 + 36 + 0 - 12;
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
    var f = 31 + 36 + 2 - 12;
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
