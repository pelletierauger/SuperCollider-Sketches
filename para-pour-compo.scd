(
{
    var x1, x2, y1, y2, y3, ph, f = 220 * 0.midiratio;
    x1 = Phaser.ar(f * 0.5 * [1, 1.01], 0) - 0.5 * 2;
    y1 = x1 * x1 - 0.5 * 2;

    x2 = Phaser.ar(f * 0.25 * [1, 1.01], 1) - 0.5 * 2;
    y2 = x2 * x2 - 0.5 * -2;

    y3 = y1 + (0.5 * (y2 - y1));

    ph = Phaser.ar(f * 0.5 * [1, 1.01], 0).round -1 * 2 + 1;
    y2 * y3 * ph - ph * 0.1;

}.play;
)

(
// onde parabolique originale
{
    var x, f = 220 * 7.midiratio;
    x = Phaser.ar(f * 0.5 * [1, 1.01], 0) - 0.5 * 2;
    x = x * x - 0.5 * 2;
    x * 0.05;
}.play;
)
