(
t = TempoClock.new;
t.tempo_(50 * 4/60);
)

~solo1 = Buffer.read(s, "/Users/guillaumepelletier/Music/SuperCollider\ Recordings/en-mer-guitare-1.wav");

~solo1.numFrames;
(
SynthDef(\solo1, {
    arg buf = ~solo1, rate = 1, spos = 0, pan = 0, amp = 1, rel = 2, atk = 0.1, out = 0;
    var sig, env, lfo;
//     env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    // env = EnvGen.ar(Env.new([0.0, 1.0, 0.00001], [atk, rel], [\linear, \exponential],1), gate, doneAction: 2);
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, ~solo1, rate * BufRateScale.ir(buf), startPos: spos * 21780480, doneAction: 2);
    sig = sig * env;
    sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)


(
~wobblyCluster = {
var pos = [
    0.026112163066864,
    0.062166202068329,
    0.74659781455994,
    0.78977344036102,
    0.062755215167999,
    0.74401377439499,
    0.43313534259796,
    0.43743299245834,
    0.73360691070557,
    0.22772061824799,
    0.21568940877914,
    0.45996032953262,
    0.36069284677505,
    0.76989204883575,
    0.68512533903122
].choose;
var num = 64;
pos.postln;
Pbind(
    \instrument, \solo1,
    \dur, 0.25,
    \spos, Pseq([pos], num * 2)
//     + Pseq(Pseries(0, 0.00001, 64).asStream.nextN(64), inf),
    + Pseq(Pseries(0, 0.00001/2, num).asStream.nextN(num).mirror2, inf),
    \rel, Pseq([0.25], inf),
    \atk, 0.0001,
//     \amp, 24 * Pseq(Pgeom(1, 0.95, 64).asStream.nextN(64), inf)
    \amp, 24 * Pseq(Pseries(0, 1/63, num).asStream.nextN(num).mirror2, num * 2)
    * Pseq([1, 0.5], inf) * 1,
    \rate, [1],
    \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(t);
15.5;
}
)

(
~wobblyClusters = Task {
{
var waitValue = ~wobblyCluster.();
waitValue.wait;
}.loop;}.start(t);
)
~wobblyClusters.stop;







(
~guitCluster1 = {
var oldList, durs, pos, rels, pulse, calcPos, offsets;
durs = 0.5!8;
pos = [rrand(0, 0.95), rrand(0.01, 0.05)];
// pos = [ 0.89190335273743, 0.028457579612732 - 0.006 ];
// pos = ~listOfPositions.choose;
rels = Array.fill(8, {0.5});
calcPos = Array.fill(8, {|i| pos[0] + (pos[1] * i)});
// offsets = Pseries(0, 0.0002, 8).asStream.nextN(8).stutter(8);
Pbind(
    \instrument, \solo1,
    \dur, Pseq(durs, 16),
    \spos, Pseq(calcPos, inf),
    \atk, 0.01, 
    \rel, Pseq(rels, 16), 
    \amp, 12 * 
    Pseq(Pseries(0, 1/(64), 64).asStream.nextN(64).mirror2, inf),
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
pos.postln;
durs.sum * 8;
// position;
// pos;
};
)
(
~listOfPositions = [
[ 0.4081679046154, 0.022549905776978 ],

];
)
(
// ~soloList = Array.fill(4, {rrand(0.0, 0.9)});
~guitClusters1 = Task {
{
var waitValue = ~guitCluster1.();
waitValue.wait;
}.loop;}.start(t);
)
~guitClusters1.stop;
~foamClusters.stop;

