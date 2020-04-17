(
{
var s, z, y;
    // 10 voices of a random sine percussion sound :
s = Mix.ar(Array.fill(10, { Resonz.ar(Dust.ar(0.2, 50), 200 + 1000.0.rand, 0.003)}) );
    // reverb predelay time :
z = DelayN.ar(s, 0.048);
    // 7 length modulated comb delays in parallel :
y = Mix.ar(Array.fill(7,{ CombL.ar(z, 0.1, LFNoise1.kr(0.1.rand, 0.04, 0.05), 15) }));
    // two parallel chains of 4 allpass delays (8 total) :
4.do({ y = AllpassN.ar(y, 0.050, [0.050.rand, 0.050.rand], 1) });
    // add original sound to reverb and play it :
s+(0.2*y)
}.scope
)


{SinOsc.ar(220 * [1, 1]) * 0.1}.play;
(
{
    var x = FSinOsc.ar(220 * 2.midiratio * [1, 1.01]) * 0.1;
    var l = SinOsc.ar(0.5).range(-0.95, -0.5);
    x * x.linlin(-1, 1, l, 1) * 12;
}.play;
)