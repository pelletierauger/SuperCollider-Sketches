
// Building a square wave
// by successively adding new sine waves.
(
    var n = 40;
    var f = Pseries(1, 2, n).asStream.nextN(n);
    var a = 1 / f;
    var aEnv0 = Pseries(0, 5, n).asStream.nextN(n);
    var aEnv = Array.newClear(n);
    aEnv0.do({|item, i| aEnv.put(i, [item, 1]);});
{
    var sigs = f.collect({|item, i|
        SinOsc.ar(220 * f[i], 0, a[i]) *
        Env.new([0, 0, 1], aEnv[i]).kr * 0.1;
    });
    Mix(sigs);
}.play;
)



// Building a sawtooth wave
// by successively adding new sine waves.
(
    var n = 40;
    var f = Pseries(4, 2, n).asStream.nextN(n) - 2;
    var a = 1 / f;
    var aEnv0 = Pseries(0, 5, n).asStream.nextN(n);
    var aEnv = Array.newClear(n);
    aEnv0.do({|item, i| aEnv.put(i, [item, 1]);});
{
    var sigs = f.collect({|item, i|
        SinOsc.ar(110 * f[i], 0, a[i]) *
        Env.new([0, 0, 1], aEnv[i]).kr * 0.1;
    });
    Mix(sigs);
}.play;
)

(
var n = 40;
1!1 ++ Pseries(2, 2, n).asStream.nextN(n);
)

// That doesn’t work because all the synths get created
// at slightly different times.
(
var n = 40;
var f = Pseries(1, 2, n).asStream.nextN(n);
var a = 1 / f;
var aEnv0 = Pseries(10, 10, n).asStream.nextN(n);
var aEnv = Array.newClear(n);
aEnv0.do({|item, i| aEnv.put(i, [item, 2]);});
f.do({
    |item, i|
    var envLevels = aEnv[i];
    envLevels = [1, 1];
    envLevels.postln;
    {
        var e = Env.new([0, 0, 1], envLevels).kr;
        SinOsc.ar(220 * f[i], 0, a[i]) * e * 0.1;
    }.play;
});

)