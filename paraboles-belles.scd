(
// onde parabolique originale
{
    var x, f = 220;
    x = Phaser.ar(f * 0.5!2, 0) - 0.5 * 2;
    x = x * x - 0.5 * 2;
    x * 0.1;
}.play;
)

// onde parabolique originale
(
{
    var x, y, f = 1;
    x = Phaser.ar(f * 0.5, 0) - 0.5 * 2;
    y = x * x - 0.5 * 2;
}.plot(2);
)

// onde parabolique originale inversée
(
{
    var x, y, f = 1;
    x = Phaser.ar(f * 0.25, 1) - 0.5 * 2;
    y = x * x - 0.5 * -2;
}.plot(2);
)

// onde triangle par interpolation de deux ondes paraboliques
(
{
    var x1, x2, y1, y2, f = 1;
    x1 = Phaser.ar(f * 0.5, 0) - 0.5 * 2;
    y1 = x1 * x1 - 0.5 * 2;

    x2 = Phaser.ar(f * 0.25, 1) - 0.5 * 2;
    y2 = x2 * x2 - 0.5 * -2;

    y1 + (0.5 * (y2 - y1));

}.plot(2);
)

// onde bizarre et merveilleuse
(
{
    var x1, x2, y1, y2, y3, ph, f = 1;
    x1 = Phaser.ar(f * 0.5, 0) - 0.5 * 2;
    y1 = x1 * x1 - 0.5 * 2;

    x2 = Phaser.ar(f * 0.25, 1) - 0.5 * 2;
    y2 = x2 * x2 - 0.5 * -2;

    y3 = y1 + (0.5 * (y2 - y1));

    ph = Phaser.ar(f * 0.5, 0).round -1 * 2 + 1;
    y2 * y3 * ph - ph;

}.plot(2);
)

(
{
    var x1, x2, y1, y2, y3, ph, f = 220 * 0.midiratio;
    x1 = Phaser.ar(f * 0.5!2, 0) - 0.5 * 2;
    y1 = x1 * x1 - 0.5 * 2;

    x2 = Phaser.ar(f * 0.25, 1) - 0.5 * 2;
    y2 = x2 * x2 - 0.5 * -2;

    y3 = y1 + (0.5 * (y2 - y1));

    ph = Phaser.ar(f * 0.5, 0).round -1 * 2 + 1;
    y2 * y3 * ph - ph * 0.1;

}.play;
)


(
{
    var x1, x2, y1, y2, y3, ph, l, f = 220 * -12.midiratio;
        l = SinOsc.kr(10) * 0.5 + 0.5;
    x1 = Phaser.ar(f * 0.5!2, 0) - 0.5 * 2;
    y1 = x1 * x1 - 0.5 * 2;

    x2 = Phaser.ar(f * 0.25, 1) - 0.5 * 2;
    y2 = x2 * x2 - 0.5 * -2;

    y3 = y1 + (l * (y2 - y1));

    ph = Phaser.ar(f * 0.5, 0).round -1 * 2 + 1;
    y2 * y3 * ph - ph * 0.1;

}.play;
)

(
{
    var x1, x2, y1, y2, y3, ph, l, f = 220 * 24.midiratio;
        l = SinOsc.kr(10) * 0.5 + 0.5;
    x1 = Phaser.ar(f * 0.5!2, 0) - 0.5 * 2;
    y1 = x1 * x1 - 0.5 * 2;

    x2 = Phaser.ar(f * 0.25, 1) - 0.5 * 2;
    y2 = x2 * x2 - 0.5 * -2;

    y3 = y1 + (0 * (y2 - y1));

    ph = Phaser.ar(f * 0.5, 0).round -1 * 2 + 1;
    y2 * y3 * ph - ph * 0.1;

}.play;
)