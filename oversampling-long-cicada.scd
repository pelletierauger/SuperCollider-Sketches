g.free;
(
TempoClock.default.sched(0.5, {
g = {
    var f = 0.5;
    var fr = f.reciprocal;
    var dec = 0.0125 * 0.5 * 32;
    var trig = Impulse.ar(f);
    var trig2 = Impulse.ar(f * 0.25);
    var env = EnvGen.ar(Env.new([0, 1, 0.125, 0], [0.0625, dec, 1.75 - 0.0625 - dec]), gate: trig);
    PlayBuf.ar(1, c, rate: 1 * 0.midiratio * [1, 1.01], trigger: trig2, doneAction: 2) * 2 * env;
}.play;
        nil;
});
)