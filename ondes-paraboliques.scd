(
var e = Env.new([0, 1, 0], [0.5, 3]);
var f = 220;
var amp = 0.2;
var dur = 3.75;
{
    var x, y, env;
    env = EnvGen.kr(e, doneAction: 2);
    x = Phaser.ar(f * 0.5!2, 0) - 0.5 * 2;
    y = x * x - 0.5 * 2;
    y = y * amp * env;
}.play;
)

s.record;
s.stopRecording;
(
{
    var x, y, z, f = 220 * 2;
    x = Phaser.ar(f * 0.5!2, 0) - 0.5 * 2;
    z = Phaser.ar(f * 0.25, 0).round -1 * 2 + 1;
    y = x * x * z - z * 0.1;
}.play;
)

(
{
    var x, y, z, f = 1;
    x = Phaser.ar(f * 0.5, 0) - 0.5 * 2;
    z = Phaser.ar(f * 0.25, 0).round -1 * 2 + 1;
    y = x * x * z - z;
}.plot(2);
)
(
{
    var x, y, z, f = 1;
    x = Phaser.ar(f * 0.5, 0) - 0.5 * 2;
    z = Phaser.ar(f * 0.25, 0).round -1 * 2 + 1;
    y = x * x * x * x * z - z;
}.plot(2);
)
(
{
    var x, y, z, f = 1;
    x = Phaser.ar(f * 0.5, 0) - 0.5 * 2;
    z = Phaser.ar(f * 0.25, 0).round -1 * 2 + 1;
    y = x * x * x * x * x * x * z - z;
}.plot(2);
)
(
{
    var x, y, z, f = 1;
    x = Phaser.ar(f * 0.5, 0) - 0.5 * 2;
    z = Phaser.ar(f * 0.25, 0).round -1 * 2 + 1;
    y = pow(x, 4) * z - z;
}.plot(2);
)
(
{
    var x, y1, y2, l = 0.5, z, f = 220 * 14.midiratio;
    l = SinOsc.kr(0.5) * 0.5 + 0.5;
    x = Phaser.ar(f * 0.5!2, 0) - 0.5 * 2;
    z = Phaser.ar(f * 0.25, 0).round -1 * 2 + 1;
    y1 = x * x * z - z * 0.1;
    y2 = x * x * x * x * z - z * 0.1;
    y1 + (l * (y2 - y1));
}.play;
)
(
{
    SinOsc.ar(220 * 1 * [1, 1]) * 0.1;
}.play;
)

(
{
    var x, y, z, l = 0, f = 220 * 4.midiratio;
    // l = SinOsc.kr(0.125) * 0.5 + 0.5;
    x = Phaser.ar(f * 0.5!2, 0) - 0.5 * 2;
    z = Phaser.ar(f * 0.25, 0).round -1 * 2 + 1;
    y = x * x * x * x * x * x * z - z;
    y + (l * ((z * -1) - y)) * 0.1;
}.play;
)