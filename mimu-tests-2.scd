(
v = {
    var x1, x2, y1, y2, y3, ph, f = 220 * 0.5, sig, lfo;
    x1 = Phaser.ar(f * 0.5 * [1, 1.0001], 0) - 0.5 * 2;
    y1 = x1 * x1 - 0.5 * 2;
    x2 = Phaser.ar(f * 0.25 * [1, 1.0001], 1) - 0.5 * 2;
    y2 = x2 * x2 - 0.5 * -2;
    y3 = y1 + (0.5 * (y2 - y1));
    ph = Phaser.ar(f * 0.5 * [1, 1.0001].reverse, 0).round -1 * 2 + 1;
    sig = y2 * y3 * ph - ph;
    sig = MiMu.ar(sig, SinOsc.ar(0.025 * [1, 1.01]).range(1, 2));
    lfo = SinOsc.kr(1).range(800, 1000);
    LPF.ar(sig, lfo) * 0.25;
    // sig;
}.play;
w = {
    var x1, x2, y1, y2, y3, ph, f = 220 * 1, sig, lfo;
    x1 = Phaser.ar(f * 0.5 * [1, 1.0002], 0) - 0.5 * 2;
    y1 = x1 * x1 - 0.5 * 2;
    x2 = Phaser.ar(f * 0.25 * [1, 1.0002], 1) - 0.5 * 2;
    y2 = x2 * x2 - 0.5 * -2;
    y3 = y1 + (0.5 * (y2 - y1));
    ph = Phaser.ar(f * 0.5 * [1, 1.0002].reverse, 0).round -1 * 2 + 1;
    sig = y2 * y3 * ph - ph;
    sig = MiMu.ar(sig, SinOsc.ar(0.025 * [1, 1.01]).range(1, 2));
    lfo = SinOsc.kr(1).range(800, 1000);
    LPF.ar(sig, lfo) * 0.25;
    // sig;
}.play;
/*w = {
    var sig = MiMu.ar( SinOsc.ar(220 * (-12 + 0).midiratio * [1, 1.01].reverse), 0.1);
    LPF.ar(sig, 2000) * 1;
    // sig;
}.play;*/
x = {
    var sig = MiMu.ar( SinOsc.ar(220 * (4 + 0).midiratio * [1, 1.01]), SinOsc.ar(0.025 * [1, 1.01]).range(1, 2));
    LPF.ar(sig, 2000) * 0.25;
    // sig;
}.play;
y = {
    var sig = MiMu.ar( SinOsc.ar(220 * (14 + 0).midiratio * [1, 1.01].reverse), SinOsc.ar(0.025 * [1, 1.01]).range(1, 2));
    LPF.ar(sig, 4000) * 0.125;
    // sig;
}.play;
z = {
    var sig = MiMu.ar( SinOsc.ar(220 * (16 + 0).midiratio * [1, 1.01]), SinOsc.ar(0.025 * [1, 1.01]).range(1, 2));
    LPF.ar(sig, 2000) * 0.125;
    // sig;
}.play;
)