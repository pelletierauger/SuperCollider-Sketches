(
{
    var sig = SinOsc.ar(440!2) * 0.1;
    var sig2 = SinOsc.ar(440 * [1.001, 1.002]) * 0.05;
    var sig3 = 20.collect({|i| SinOsc.ar(440 + [0.5 * i, 0.9 * i], Rand(0, 4pi)) * 0.05}).sum;
    sig + sig2 + sig3;
}.play;
)

FreqScope.new(400, 200, 0, server: s);
