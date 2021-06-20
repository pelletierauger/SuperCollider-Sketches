(
~drum = {
    ~nT.sched(~nT.timeToNextBeat(quant: 4), {
        ~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
        ~snare = {
            | trigGate = 1 |
            var trig = Impulse.ar(~nT.tempo);
            var pat0 = [1, 0, 0, 0, 0, 1, 0, 0];
            var pat1 = [0, 0, 1, 0, 0, 0, 1, 1];
            var pat2 = [1];
            var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
            var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
            var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
            var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
            var sig = MiPlaits.ar(
                pitch: 30 + [0, 0, 0, 24] + 24 - [24, 12, 12, 12] + 0,
                engine: 9,
                harm: 0.95,
                timbre: 1,
                morph: 0.45 - [0, 0.2, 0, 0],
                trigger: trig * [block0, block1, block1, block2] * trigGate,
                decay: 0.0 + [0.9, 0.6, 0.6, 0.7] * rrand(0.25, 0.95),
                lpg_colour: 0
            );
            var sig2 = [sig[1][1], sig[2][1]] * 1.5;
            sig = [sig[0][1] * 2 + (sig[3][1] * 0.25)]!2 + sig2;
            // sig = (sig * 0.75) + HPF.ar(sig, 200);
            // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
            sig = sig * 3.6 * 0.5;
        }.play(fadeTime: 0.01).register;
        ~n = ~n + 1;
        ~n.postln;
        nil;
    });
};
)

rrand(0.25, 0.75)
~n = 0;
~n;

(
~drums = Task {
    {
        ~drum.();
        (~nT.beatDur * 15.75).wait;
    }.loop;
}.start();
)
~drums.stop;

~nT.beats;

(
[~snare, ~synthLine, ~rim, ~billes0, ~billes1, ~billes2, ~cymbal, ~billes].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});
~drums.stop;
)