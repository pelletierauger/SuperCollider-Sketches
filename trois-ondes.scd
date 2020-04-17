s.record;
s.stopRecording;

(
var e = Env.new([0, 1, 0], [0.5, 3]);
var f = 220;
var amp = 0.2;
var dur = 3.75;
{
    var sig, env;
    env = EnvGen.kr(e, doneAction: 2);
    sig = SinOsc.ar(f * (1!2)) * amp * env;
}.play;
SystemClock.sched(dur, {
    {
        var x, y, env;
        env = EnvGen.kr(e, doneAction: 2);
        x = Phaser.ar(f * 0.5!2, 0) - 0.5 * 2;
        y = x * x - 0.5 * 2;
        y = y * amp * env;
    }.play;
});
SystemClock.sched(dur * 2, {
    {
        var sig, env;
        env = EnvGen.kr(e, doneAction: 2);
        sig = LFTri.ar(f * (1!2)) * amp * env;
    }.play;
});
SystemClock.sched(dur * 3, {
s.stopRecording;
});
)