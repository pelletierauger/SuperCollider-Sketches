// The big difference if the amplitude of
// the sine waves is not linearly diminished.
(
    var n = 40;
    var f = Pseries(1, 2, n).asStream.nextN(n);
    var a = 1!n;
    var aEnv0 = Pseries(0, 5, n).asStream.nextN(n);
    var aEnv = Array.newClear(n);
aEnv0.do({|item, i| aEnv.put(i, [item, 1]);});
{
    var sigs = f.collect({|item, i|
        SinOsc.ar(220 * f[i], 0, a[i]) *
        Env.new([0, 0, 1], aEnv[i]).kr * 0.1
    });
    Mix(sigs);
}.play;
)
