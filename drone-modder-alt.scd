(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~lushZ.set(\pulseGate, 0, \gate, 0, \fadeTime, 10.1);
    ~lushZ = {
        | pulseGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.125 * 0.5) * pulseGate;
        var sig = MiBraids.ar(
            42 - 12 + Demand.kr(t, 0, Dseq([0, -5], inf)),
            timbre: 0.89,
            color: 0.8 + 0,
            model: 43,
            resamp: 0,
            decim: 32,
            bits: 2,
            ws: 0
        ) * Line.ar(0, 1, 0.1);
        var sigH = VadimFilter.ar(sig, 5000, resonance: 0.25, type: 5) * In.kr(~kB2, 1);
        sig = VadimFilter.ar(sig, 100 + In.kr(~kB, 1), resonance: 0.25, type: 1);
        sig = sig * 4!2 + (sigH!2);
    }.play(fadeTime: 3);
});
)

~kB = Bus.control(s, 1);
~kB2 = Bus.control(s, 1);

{Out.kr(~kB2, EnvGen.kr(Env([0, 0.5, 0], [15, 125] * 0.1, [8, -8]), doneAction: 2))}.play;


{Out.kr(~kB, EnvGen.kr(Env([0, 1000, 0], [5, 15] * 0.1), doneAction: 2))}.play;

~lushZ.set(\press, 2000);
~lushZ.set(\press, 0);

~polly = {In.kr(~kB, 1).poll}.play;
~polly.free;


(
~droneModder = Task {
    {
        {
            var rise = [100, 500, 1000].choose;
            var dec = [15, 5, 1].choose;
            var env = EnvGen.kr(Env([0, rise, 0], [5, dec] * 0.1), doneAction: 2);
            Out.kr(~kB, env);
        }.play;
        [1, 2, 4].choose.wait;
    }.loop;
}.start(~nT, quant: [4]);
)
~droneModder.stop;