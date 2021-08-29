~nT.tempo
~nT.tempo = 1.39 * 1.25 * 1.075;
~nT.tempo = ~nT.tempo * 0.75;
~nT.tempo = ~nT.tempo * 1.25;


(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur * 0.5), {

    [~hats2].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 15)});});

    ~hats2 = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var tempo = ~nT.tempo * 0.5;
        // var basePulse = Impulse.ar(tempo) * trigGate;
        // var swing = [2, 4] / 3;
        // var swungTempo = Demand.ar(basePulse, 0, Dseq(swing * tempo, inf));
        var trig = Impulse.ar(tempo * 8) * trigGate;
        // var block = Demand.ar(trig, 0, Dseq([1, 1, 1], inf));
        var b0 =          [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0];
        var b1 = (0!8) ++ [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0];
        var block = Demand.ar(trig, 0, Dseq(b0, inf));
        var block1 = Demand.ar(trig, 0, Dseq(b1, inf));
        // var trig2 = Impulse.ar(swungTempo * 0.125 * 0.25 * 1) * trigGate;
        var dem = Demand.ar(trig * block, 0,
            Dseq((0!3) ++ (0!1) ++ (-2!4) ++ (-5!3) ++ (-4!1) ++ (-5!3) ++ (-5!1), inf)
        + Dseq([0, 0].stutter(16), inf)
        );
        var dem2 = Demand.ar(trig * block, 0,
            Dseq([0.01, 1, 1, 1].stutter(4), inf));
        var sig = MiPlaits.ar(
            pitch: 62 + 12 + 12 - 5 + [0, 0.05],
            engine: 15,
            harm: 0.25,
            timbre: Demand.ar(trig * block, 0, Dseq([0.5, 0.2, 0.5], inf)),
            morph: SinOsc.kr(0.1).range(0.75, 0.8) - 0.1,
            morph: 0.05 *
            Demand.ar(trig * block, 0, Dseq([4, 1, 2, 1], inf))
            + Demand.ar(trig * block, 0, Dseq(0!42 ++ (0!6), inf))
            + (block1 * 0.5),
            trigger: trig * block * Demand.ar(trig, 0, Dseq(1!13 ++ (1!11), inf)),
            decay: 0.1,
            lpg_colour: 1,
            mul: 1.25
        );
        sig = [sig[0][0], sig[1][0]];
        // sig = LPF.ar(sig, 2500) * 0.8 * 0.75 * 3 * 0.0625;
        sig = sig * 0.25 * 0.5 * envGate;

        // Out.ar(~bu, sig * XLine.ar(0.001, 1, 0.005) * 0.5);
        Out.ar(0, [sig[1], sig[0]] * XLine.ar(0.001, 1, 0.005) * 1);
    }.play(fadeTime: 0).register;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
            var pat0 = [1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0].rotate(8).scramble;
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0].rotate(8).scramble;
        var pat2 = [1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0].rotate(8).scramble;
[pat0, pat1, pat2].postln;


    pat0 = [ 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0 ];
    pat1 = [ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0 ];
    pat2 = [ 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0 ];



    if(~rimw.isPlaying, {~rimw.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
    ~rimw = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var tempo = ~nT.tempo * 4;
        var basePulse = Impulse.ar(tempo) * trigGate;
        var swing = [1, 1];
        var swungTempo = Demand.ar(basePulse, 0, Dseq(swing * tempo, inf));
        var trig = Impulse.ar(swungTempo) * trigGate;
        var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
        var tuned = Demand.ar(trig, 0, Dseq([0, -1].stutter(16)));
        var dec = Demand.ar(trig, 0, Dseq(0.75!24 ++ (0.75!8), inf));
        var pit = Demand.ar(trig, 0, Dseq(-24!16 ++ (-24!16) - 12, inf));
        var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var sig = MiPlaits.ar(
            pitch: [ 48, 60, 60, 84 ] - 12 + pit + 12 + tuned,
            engine: 9,
            harm: 0.7,
            timbre: [1, 1, 1, 1].rotate(2),
            timbre: 0.4,
            morph: 0.5 - [0, 0.2, 0, 0],
            trigger: trig * [block0, block1, block1, block2],
            decay: 0.2 + [0.9, 0.6, 0.6, 0.7] * dec * 0.5,
            lpg_colour: 0
        );
        var envBl = EnvGen.kr(Env([0, 0, 1], [0.5, 0.01]));
        var sig2 = [sig[1][1], sig[2][1]] * 1.5 * 16 * envBl;
        sig2 = [sig[0][1] * 2 + (sig[3][1] * 2)]!2 * 8 + sig2;
        // sig = LPF.ar(sig, 4000);
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig2 = sig2 * 3.6 * 0.5 * 0.125 * 0.25 * XLine.ar(0.001, 1, 0.005);
        Out.ar(0, sig2);
        // Out.ar(~bu, [sig[1][1], sig[2][1]] * 1.5 * 16 * envBl * 0.125);
    }.play(fadeTime: 0.01).register;
});
)


[ [ 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0 ],
    [ 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0 ]
]

(
// ~nT.sched(~nT.timeToNextBeat(quant: 4), {
    [~hats2, ~rim, ~lead, ~billes6, ~billes67].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 15)});});
    if(~rimw.isPlaying, {~rimw.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
    if(~crushedNoiseDry.isPlaying, {~crushedNoiseDry.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
// });
)