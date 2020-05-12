(
var freq = 59.midicps * -17.midiratio * [1, 1.01];
{
    var modIndex = Line.ar(0, 200, 120);
    var modulator = SinOsc.ar(freq * 1.5);
    var carrier = SinOsc.ar(freq, modulator * modIndex % 2pi);
    carrier * 0.125;
}.play;
)

{PlayBuf.ar(1, b, rate: 1 * 0.midiratio * [1, 1.01], doneAction: 2) * 4.5}.play;

(
var freq = 59.midicps * -17.midiratio * [1, 1.01];
{
    var modIndex = Line.ar(0, 200, 120);
    var modulator = SinOsc.ar(freq * 1.5);
    var carrier = SinOsc.ar(freq, modulator * modIndex % 2pi);
    var buffer = PlayBuf.ar(1, b, rate: 1 * 0.midiratio * [1, 1.01], doneAction: 2) * 37;
    [carrier, buffer, ((carrier * -1) + buffer) * -0.5 * 1]
}.plot(10);
)



(
var coin = [0, 1].choose;
if (coin == 0, {
    var freq = 59.midicps * -17.midiratio * [1, 1.01];
{
    var modIndex = Line.ar(0, 200, 120);
    var modulator = SinOsc.ar(freq * 1.5);
    var carrier = SinOsc.ar(freq, modulator * modIndex % 2pi);
    carrier * 0.125;
}.play;
}, {
    {PlayBuf.ar(1, b, rate: 1 * 0.midiratio * [1, 1.01], doneAction: 2) * 5}.play;
});
["sigA", "sigB"][coin];
)



(
var freq = 59.midicps * 7.midiratio * [1, 1.01];
{
    var modIndex = Line.ar(0.5, 20, 120);
    var modulator = SinOsc.ar(freq * sqrt(2) * 4);
    var carrier = SinOsc.ar(freq, modulator * modIndex % 2pi);
    carrier * 0.125;
}.play;
)
