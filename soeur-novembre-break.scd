(
~t.sched(~t.timeToNextBeat(quant: 4), {

    // x.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
// ~x2.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    // if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
    // [~billes0, ~billes1].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});
    // ~synthLine.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~x2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~x2 = {
        | trigGate = 1 |
        var t = Impulse.kr(~t.tempo * 4) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 3.85], [2, -8, 'lin']), t);
        var d = Demand.kr(t, 0, Dseq([4, 5, 6, 5].stutter(4), inf));
        var sig = MiBraids.ar(
            pitch: 45 + 24,
            timbre: 0.65 + [0.0, 0.1],
            color: 0.5,
            model: 34,
            trig: t,
            resamp: 2,
            decim: 22 + [0, 4],
            bits: d,
            ws: 0
        ) * 1 * env;
        VadimFilter.ar(sig, SinOsc.kr(0.1).range(1000, 6000), 0.25, 5);
    }.play(fadeTime: 0);
        x.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~t.tempo * 1) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0.15, 0.15, 0.15, 0.5].rotate(1), inf));
        var sig = MiBraids.ar(
            pitch: 45,
            timbre: 0.65,
            color: d,
            model: 34,
            trig: t
        ) * 2!2;
        VadimFilter.ar(sig, 200, 0.25, 1);
    }.play(fadeTime: 0);
});
)