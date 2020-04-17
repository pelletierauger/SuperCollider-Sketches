s.record;
s.stopRecording;

(
var e = Env.new([0, 1, 0], [0.5, 6]);
var f = 220;
var amp = 0.2;
var dur = 7;
{
    var sig, env;
    env = EnvGen.kr(e, doneAction: 2);
    sig = SinOsc.ar(f * (1!2)) * amp * env;
}.play;
SystemClock.sched(dur, {
{
    var x1, x2, y1, y2, y3, ph, f = 220 * 0.midiratio, env;
    env = EnvGen.kr(e, doneAction: 2);
    x1 = Phaser.ar(f * 0.5!2, 0) - 0.5 * 2;
    y1 = x1 * x1 - 0.5 * 2;

    x2 = Phaser.ar(f * 0.25, 1) - 0.5 * 2;
    y2 = x2 * x2 - 0.5 * -2;

    y3 = y1 + (0.5 * (y2 - y1));

    ph = Phaser.ar(f * 0.5, 0).round -1 * 2 + 1;
    y2 * y3 * ph - ph * env * amp;
}.play;
});
SystemClock.sched(dur * 2, {
    s.stopRecording;
});
)