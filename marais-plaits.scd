(
x = {
    var f = 29 + 12 + 12;
    var lfo = SinOsc.kr(0.1).range(0.15, 0.2);
    var alg = 12, harm = 0.05, morph = 0.95;
    var sig1 = MiPlaits2.ar(f, alg, harm: harm, morph: morph, mul: 0.2);
    var sig2 = MiPlaits2.ar(f + 0.1, alg, harm: harm, morph: morph, mul: 0.2);
    [sig1[0], sig2[0]] * 2 * Line.kr(0, 1, 3);
}.play;
)

(
x = {
    var f = 29 + 12 + 7;
    var trig = Impulse.kr(4);
    var lfo = SinOsc.kr(0.1).range(0.15, 0.2);
    var alg = 2, harm = 0.05, morph = 0.995, decay = 0.1;
    var sig1 = MiPlaits2.ar(f, alg, harm: harm, morph: morph, trigger: trig, decay: decay, mul: 0.2);
    var sig2 = MiPlaits2.ar(f + 0.1, alg, harm: harm, morph: morph, trigger: trig, decay: decay, mul: 0.2);
    [sig1[0], sig2[0]] * 2 * Line.kr(0, 1, 3);
}.play;
)


(
{
    var f = 220 * 1;
    var x1 = Phaser.ar(f * 0.5 * [1, 1.001], 0) * 2pi;
    var x2 = Phaser.ar(f * 1!2, 0) * 2pi;
    sin(x1 + (tan(x2) * 0.0005)) * 0.1;
}.play;
)

(
{
    SinOsc.ar(220!2) * 0.1;
}.play;
)

(
{
    var f = 110;
    var x1 = Phaser.ar(f * 0.5 * [1, 1.05], 0) * 2pi;
    var x2 = Phaser.ar(f * 2!2, 0) * 2pi;
    sin(x1 + (sin(sin(x2 * 1) * Line.kr(1, 64, 10)) * 0.1)) * 0.4;
}.play;
)