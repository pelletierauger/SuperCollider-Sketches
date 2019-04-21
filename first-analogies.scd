(
var list = [0, 4, 7];
var aa = rrand(0, 4);
// var group1 = Array.fill(3, {list[rrand(0, 3)}];

Pbind(
    \instrument, \simplest,
    \dur, 0.5,
    \freq, 220 * Pseq(list, 1),
    \rel, 0.05,
    \amp, Pseq([Pgeom(2, 0.6, 4)], inf),
    // \amp, 2,
    \out, 0
).play(t, quant: 1);
)

(
{
var list = [0, 4, 7];
    // Array.fill(3, {list.choose});
}.();
)

[0, 4, 7].choose

(
~analogy = {
var list = [0, 4, 7, 11, 12, 16, 19];
var group1 = Array.fill(3, {list.choose;});
var stut = rrand(1, 4);
var group2 = group1.stutter(stut);
    group2.postln;
    Pbind(
    \instrument, \simplest,
    \dur, 0.25,
    \freq, 220 * Pseq(group2.midiratio, 1),
    \rel, 0.05,
    \amp, Pseq([Pgeom(2, 0.6, stut)], inf),
    \out, 0
).play(t);
group2.size * 0.25;
};
)

{[0, 4, 7].choose}.();
[0, 3, 7].size

t = TempoClock.new;
t.tempo_(50/60);


(
t.sched(1, {
    ~analogyCluster = Task.new({
{
var waitValue = ~analogy.();
waitValue.postln;
waitValue.wait;
}.loop;}, t).start;
});

)
~analogyCluster.stop;


(
~analogy = {
var list = [0.075, 0.076, 0.08, 0.085];
var group1 = Array.fill(3, {list.choose;});
var stut = rrand(1, 4);
var group2 = group1.stutter(stut);
    group2 = group2 ++ group2;
    group2.postln;
    Pbind(
    \instrument, \vox,
    \dur, 0.25,
    \spos, Pseq(group2, 1),
        // \rel, 0.05,
    \rel, 0.5,
    \atk, 0.07,
    \amp, Pseq([Pgeom(2, 0.9, stut)], inf),
        \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
group2.size * 0.25;
};
)

(
~a = [1, 2, 3];
~a = ~a ++ ~a;
)


(
~voxA2.stop;
~voxA2 = Pbind(
    \instrument, \vox,
    \dur, 0.25,
    \spos, Pseq([0.2005, 0.215].stutter(4), inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \rel, 0.5,
    \atk, 0.07,
    \rate, 0.midiratio,
    \amp, 3,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t, quant: 1);
)