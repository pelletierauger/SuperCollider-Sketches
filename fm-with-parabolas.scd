(
{
    var x1, x2, y1, y2, y3, ph, f = 1, sig,
    x1b, x2b, y1b, y2b, y3b, phb, sigb;
    x1 = Phaser.ar(f * 0.5, 0) - 0.5 * 2;
    y1 = x1 * x1 - 0.5 * 2;
    x2 = Phaser.ar(f * 0.25, 1) - 0.5 * 2;
    y2 = x2 * x2 - 0.5 * -2;
    y3 = y1 + (0.5 * (y2 - y1));
    ph = Phaser.ar(f * 0.5, 0).round -1 * 2 + 1;
    sig = y2 * y3 * ph - ph;

/*    x1b = (Phaser.ar(f * 0.5, 0) - 0.5 * 2) + sig;
    y1b = x1b * x1b - 0.5 * 2;
    x2b = (Phaser.ar(f * 0.25, 1) - 0.5 * 2);
    y2b = x2b * x2b - 0.5 * -2;
    y3b = y1b + (0.5 * (y2b - y1b));
    phb = Phaser.ar(f * 0.5, 0).round -1 * 2 + 1;
    sigb = y2b * y3b * phb - phb;
    sigb;
    x2b;*/
    [x1, x2, ph, x1 + (ph * -1)];
}.plot(2);
)

(
{
var f = 110 * -72.midiratio, squ, x1, x2, y1, y2, y3, op1, squb, x1b, x2b, y1b, y2b, y3b, op2, ind, fRatio;
    ind = Line.ar(0, 24000, 10);
    squ = Phaser.ar(f * 0.5, 0).round -1 * 2 + 1;
    x1 = Phaser.ar(f * 0.5, 0) - 0.5 * 2;
    x2 = x1 - squ;
    y1 = x1 * x1 - 0.5 * 2;
    y2 = x2 * x2 - 0.5 * -2;
    y3 = y1 + (0.5 * (y2 - y1)); // Tri wave obtained by lerp between 2 hyps.
    op1 = y2 * y3 * squ - squ;

    fRatio = 0.25;
    squb = Phaser.ar(f * 0.5 + (op1 * ind) * fRatio, 0).round -1 * 2 + 1;
    x1b = Phaser.ar(f * 0.5 + (op1 * ind) * fRatio, 0) - 0.5 * 2;
    x2b = x1b - squb;
    y1b = x1b * x1b - 0.5 * 2;
    y2b = x2b * x2b - 0.5 * -2;
    y3b = y1b + (0.5 * (y2b - y1b)); // Tri wave obtained by lerp between 2 hyps.
    op2 = y2b * y3b * squb - squb;
    LPF.ar(op2!2 * 0.1, 880 * 16) * Line.ar(1, 0, 10);
}.play;
)


(
{
var f = 2, squ, x1, x2, y1, y2, y3, op1, squb, x1b, x2b, y1b, y2b, y3b, op2, ind;
    ind = Line.ar(0, 4000, 10);
    squ = Phaser.ar(f * 0.5, 0).round -1 * 2 + 1;
    x1 = Phaser.ar(f * 0.5, 0) - 0.5 * 2;
    x2 = x1 - squ;
    y1 = x1 * x1 - 0.5 * 2;
    y2 = x2 * x2 - 0.5 * -2;
    y3 = y1 + (0.5 * (y2 - y1)); // Tri wave obtained by lerp between 2 hyps.
    op1 = y2 * y3 * squ - squ;

    squb = Phaser.ar(f * 0.5, 0).round -1 * 2 + 1;
    x1b = Phaser.ar(f * 0.5, 0) - 0.5 * 2 + op1;
    x2b = x1b - squb;
    y1b = x1b * x1b - 0.5 * 2;
    y2b = x2b * x2b - 0.5 * -2;
    y3b = y1b + (0.5 * (y2b - y1b)); // Tri wave obtained by lerp between 2 hyps.
    op2 = y2b * y3b * squb - squb;
    // op2!2 * 0.1;
    x2b;
}.plot(1);
)


(
{
var f = 2, squ, x1, x2, y1, y2, y3;
    squ = Phaser.ar(f * 0.5, 0).round -1 * 2 + 1;
    x1 = Phaser.ar(f * 0.5, 0) - 0.5 * 2;
    x2 = x1 - squ;
    y1 = x1 * x1 - 0.5 * 2;
    y2 = x2 * x2 - 0.5 * -2;
    y3 = y1 + (0.5 * (y2 - y1)); // Tri wave obtained by lerp between 2 hyps.
    y2 * y3 * squ - squ;
}.plot(1);
)