(
var freq = 55;
{
    var x = Phaser.ar(freq * 0.5) * 2pi;
    var modIndex = Line.ar(0, 1200, 120);
    var modulator = sin(x);
    var carrier = sin(x + (modulator * modIndex));
    carrier * 0.1!2;
}.play();
)

(
var freq = 55;
{
    var modIndex = Line.ar(0, 1200, 120);
    var modulator = SinOsc.ar(freq);
    var carrier = SinOsc.ar(freq, modulator * modIndex % 2pi);
    carrier * 0.1!2;
}.play;
)


(
var freq = 1;
{
    var x = Phaser.ar(freq * 0.5) - 0.5 * 2pi;
    var modIndex = Line.ar(0, 1200, 120);
    var modulator = sin(x);
    var carrier = sin(x + (modulator * modIndex));
    carrier * 0.1;
}.plot(1);
)

(
var freq = 1;
{

    var x = Phaser.ar(freq * 0.5) * 2pi;
    var modIndex0 = Line.ar(0, 1200, 120);
    var modulator0 = sin(x);
    var carrier0 = sin(x + (modulator0 * modIndex0));
    // carrier * 0.1;
    var modIndex1 = Line.ar(0, 1200, 120);
    var modulator1 = SinOsc.ar(freq);
    var carrier1 = SinOsc.ar(freq, modulator1 * modIndex1);
    [carrier0, carrier1];
}.plot(1);
)


(
var freq = 55;
{
    var modMax = 1200;
    var modIndex = Line.ar(0, modMax, 1);

    // The 1st signal
    var x = Phaser.ar(freq * 0.5) * 2pi;
    var modulator0 = sin(x);
    var carrier0 = sin(x + (modulator0 * modIndex));

    // The 2nd signal
    var modulator1 = SinOsc.ar(freq);
    var carrier1 = SinOsc.ar(freq, modulator1 * modIndex % 2pi);

    // Plotting the 1st and 2nd signal, and then their difference
    [carrier0, carrier1, ((carrier0 * -1) + carrier1) * -0.5 * 1];
}.plot(1);
)


(
var freq = 55;
{
    var modMax = 300;
    var modIndex = Line.ar(0, modMax, 120);

    // The 1st signal
    var x = Phaser.ar(freq * 0.5) * 2pi;
    var modulator0 = sin(x);
    var carrier0 = sin(x + (modulator0 * modIndex));

    // The 2nd signal
    var modulator1 = SinOsc.ar(freq);
    var carrier1 = SinOsc.ar(freq, modulator1 * modIndex);

    // Plotting the 1st and 2nd signal, and then their difference
    ((carrier0 * -1) + carrier1) * 0.5 * 0.1!2;
}.play;
)