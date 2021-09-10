

(
{
    var env = EnvGen.kr(Env([0, 1, 0], [0.1, 0.1]), doneAction: 2);
    var sig = LFSaw.ar(60.midicps) * 0.1 * env!2;
    sig = VadimFilter.ar(sig, 50 + (env * 2000));
    sig;
}.play;
)

(
{
    s.record;
    0.1.wait;
{
        // var env = EnvGen.kr(Env([0, 1, 0], [0.1, 0.1]), doneAction: 2);
            var env = EnvGen.kr(Env([0, 1, 0.25, 0], [0.15, 0.2, 1 - 0.2] * 4, [2, 'lin', 'lin']), doneAction: 2);

    var sig = MiBraids.ar(60, timbre: 0.5 + (env * 0.5), color: env * 0.2, model: 6) * 0.1 * env!2;
    sig = VadimFilter.ar(sig, freq: 100 + (env * 4000), type: 1);
    sig;
}.play;
    4.6.wait;
    0.1.wait;
    s.stopRecording;
}.fork;
)


[0.15, 0.2, 1 - 0.2].sum * 4