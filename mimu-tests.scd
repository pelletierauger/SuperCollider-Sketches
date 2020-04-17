MiMu

(
x = {
    var sig = MiMu.ar( SinOsc.ar(220 * (16 + 0).midiratio * [1, 1.01]), SinOsc.ar(0.025 * [1, 1.01]).range(1, 2));
    LPF.ar(sig, 2000) * 0.25;
    // sig;
}.play;
)
x.free

v.free;
(
v = {
    var sig = MiMu.ar( SinOsc.ar(220 * (0 + 0).midiratio * [1, 1.01]), 2);
    LPF.ar(sig, 2000) * 0.25;
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
z.free;