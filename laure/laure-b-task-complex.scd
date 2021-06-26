(
~n = 0;
~drum = {
    ~nT.sched(~nT.timeToNextBeat(quant: 4), {
        var vel = rrand(0.85, 0.95);
        ~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
        ~snare = {
            | trigGate = 1 |
            var trig = Impulse.ar(~nT.tempo * 2);
            var j = [0, 1].choose;
            var wh = 1!1 ++ (1!15);
            //         |            |           |           |
            var pat0 = [1, 0, 0, 0, 0, 0, j, 0, 0, 0, 1, 1, 0, 0, 0, 0] * wh;
            //         |            |           |           |
            var pat1 = [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0] * wh;
            var pat2 = [1, 0];
            var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
            var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
            var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
            var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
            var sig = MiPlaits.ar(
                pitch: 30 + [0, 0, 0, 24] + 24 - [24, 12, 12, 12] + 0,
                engine: 9,
                harm: [0.95, 0.5, 0.5, 0.95].rotate(0),
                timbre: 1,
                morph: 0.45 - [0, 0.2, 0, 0],
                trigger: trig * [block0, block1, block1, block2] * trigGate,
                decay: 0.0 + [0.9, 0.6, 0.6, 0.7] * vel,
                lpg_colour: 0
            );
            var mu = 1;
            var sig2 = [sig[1][1], sig[2][1]] * 1.5 * mu;
            sig = [sig[0][1] * 2 * mu + (sig[3][1] * 0.25)]!2 + sig2;
            // sig = (sig * 0.75) + HPF.ar(sig, 200);
            // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
            sig = sig * 3.6 * 0.5 * 0.8;
        }.play(fadeTime: 0.01).register;
        (~n.asString ++ ", vel:" + vel).postln;
        ~n = ~n + 1;
        nil;
    });
    ("timeToNextBeat: " ++ ~nT.timeToNextBeat.asString).postln;
};
)

rrand(0.25, 0.75);
~n;
(~n.asString ++ "vel")

(
~drums = Task {
    {
        ~drum.();
        (~nT.beatDur * 16).wait;
    }.loop;
}.start();
)
~drums.stop;

~nT.beats;

(
[~snare, ~synthLine, ~rim, ~billes0, ~billes1, ~billes2, ~cor, ~cymbal, ~billes].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});
~drums.stop;
~guitareC.stop;
~guitareD.stop;
)