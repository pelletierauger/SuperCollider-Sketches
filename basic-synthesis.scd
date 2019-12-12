(
{
    var op6 = SinOscFB.ar(880 * 11, 0);
    Mix(SinOsc.ar(880 * [1, 3, 5, 7, 9]) * [0.99, 0.87, 0.79, 0.75, 0.72]) + op6 * 0.1;
}.play;
)

(
{
    var op6 = SinOscFB.ar(880 * 11, 0.71);
    Mix(SinOsc.ar(880 * [1]) * [0.99]) * 0.1;
}.play;
)



FreqScope.new(800, 600, 0, server: s);
FreqScope.new(400, 200, 0, server: s);

{Env.circle([0, 1, 0], [1, 1, 0], [8, -8, 8]).kr}.plot(4)



// Generating a square wave by adding sine waves.
(
var n = 40;
var f = Pseries(1,2,n).asStream.nextN(n);
var a = 1 / f;
{Mix(SinOsc.ar(220 * f, 0, a)) * 0.1}.play;
)


// Generating a sawtooth wave by adding sine waves.
(
var n = 40;
var f = Pseries(4,2,n).asStream.nextN(n) - 2;
var a = 1 / f;
{Mix(SinOsc.ar(220 * f, 0, a)) * 0.1}.play;
)


// Generating ??
(
var n = 40;
var f = Pseries(1,2.005,n).asStream.nextN(n);
var a = 1 / f;
{Mix(SinOsc.ar(220 * f, 0, a)) * 0.1}.play;
)

(
{
    var l = Line.kr(0, 1, 10);
    SinOsc.ar(220) + (SinOsc.ar(220 * 3) * l) * 0.1;
}.play;
)

(
    var n = 40;
    var f = Pseries(1, 2, n).asStream.nextN(n);
    var a = 1 / f;
    var aEnv0 = Pseries(10, 10, n).asStream.nextN(n);
    var aEnv = Array.newClear(n);
    aEnv0.do({|item, i| aEnv.put(i, [item, 1]);});
    {
        var e = Env.new([0, 0, 1], aEnv).kr;

        Mix(SinOsc.ar(220 * f, 0, a) * e) * 0.1
    }.play;
)

(
var n = 40;
var a = Pseries(10, 10, n).asStream.nextN(n);
var aa = Array.newClear(n);
a.do({|item, i| aa.put(i, [item, 1]);});
aa;

)

(

)

(
    var n = 40;
    var f = Pseries(1, 2, n).asStream.nextN(n);
    var a = 1 / f;
    var aEnv0 = Pseries(10, 10, n).asStream.nextN(n);
    var aEnv = Array.newClear(n);
    aEnv0.do({|item, i| aEnv.put(i, [item, 1]);});
aEnv;
)

(
var aa = Array.newClear(10);
aa.put(2, 4);
aa;
)

s.scope(1, 0);

Pseries(4,2,10).asStream.nextN(10) - 2 / 2