~toMidi.("F#1"); // 50

(
~n = 0;
~drum = {
    // ~nT.sched(~nT.timeToNextBeat(quant: 8), {
    var vel = rrand(0.85, 0.95);
    ~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~snare = {
        | trigGate = 1, velExtra = 0 |
        var trig = Impulse.ar(~nT.tempo * 4);
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
            decay: 0.0 + [0.9, 0.6, 0.6, 0.7] * vel + velExtra,
            lpg_colour: 0
        );
        var mu = 1;
        var sig2 = [sig[1][1], sig[2][1]] * 1.5 * mu;
        sig = [sig[0][1] * 2 * mu + (sig[3][1] * 0.25)]!2 + sig2;
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        // sig = LPF.ar(sig, 3500);
        // Out.ar(~bbus, sig);
        sig = sig * 3.6 * 0.5 * 0.8 * 1;
    }.play(fadeTime: 0.01).register;
    (~n.asString ++ ", vel:" + vel).postln;
    ~n = ~n + 1;
    nil;
    // });
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
        8.wait;
    }.loop;
}.start(~nT, quant: [8]);
)
~drums.stop;

~nT.beats;


(
~clockVisualizer = Task {
    var start = ~nT.beats.round;
    var mes = 0;
    var vis = "| - - - ";
    {
        var cur = (~nT.beats - start + 1);
        var cur2 = (cur.asString ++ ". . . ").rotate(mes * 2);
        (vis.rotate(mes * 2) ++ "  " ++ cur2).postln;
        mes = mes + 1;
        if (mes == 4, {mes = 0});
        1.wait;
    }.loop;
}.start(~nT, quant: [8]);
)
~clockVisualizer.stop;

(
~snare.set(\velExtra, 1);
[~snare, ~synthLine, ~rim, ~billes0, ~billes1, ~billes2, ~cymbal, ~billes].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});
[~cor].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 15)});});
~drums.stop;
~guitareC.stop;
~guitareD.stop;
x.set(\gate, 0, \fadeTime, 0.1);
)