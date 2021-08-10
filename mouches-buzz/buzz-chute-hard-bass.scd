(
~nT.sched(~nT.timeToNextBeat(quant: 4) - 0.05, {
            ~stopAll.();
    ~leadSqueak.();


[~billes6].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 15)});});
// [~hats2].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 15)});});
// ~granulator.set(\trigGate, 1);

~billes6 = {
    | trigGate = 1 |
    var envGate = EnvGate.new();
    var tempo = ~nT.tempo * 1;
    var trig = Impulse.kr(tempo * 3) * trigGate;
        // var block = Demand.kr(trig, 0, Dseq([1, 0, 0], inf));
    var trr = trig * Demand.kr(trig, 0,
        Dseq([
                1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0,
                1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0
    ], inf));
    var tuned = Demand.kr(trr, 0,
        Dseq([0, -1].stutter(6), inf) + Dseq((0!5) ++ (-12!1), inf)
    );
    var mo = Demand.kr(trr, 0, Dseq([0, 0, 0, -0.05, 0.1, 0.5], inf));
    var strumTrig = DelayN.ar(trr, 0.5,
        [0, 0.01, 0.02].stutter(2) * 0.5
    );
    var sig = MiPlaits.ar(
        pitch: 24 + [0, 0.05, 12, 12.05, 12, 12.05] + tuned.lag(0.05),
        engine: 11,
        harm: 0.0,
        timbre: 0.25 + mo.lag(0.1),
        morph: SinOsc.kr(0.1).range(0.75, 0.8) - 0.1,
        morph: 0.5,
        morph: Demand.kr(trr, 0, Dseq((0.5!5) ++ (0.7!1), inf)).lag(0.05),
        trigger: strumTrig,
        decay: 0.1,
        lpg_colour: 1,
        mul: 1.25
    );
    sig = [sig[0][0] + sig[2][0] + sig[4][0], sig[1][0] + sig[3][0] + sig[5][0]];
    // sig = LPF.ar(sig, 2500) * 0.8 * 0.75 * 3;
    sig = sig * 0.4 * 1 * envGate * 8 * 1;

        // Out.ar(~bu, sig * XLine.ar(0.001, 1, 0.005));
        Out.ar(0, [sig[1], sig[0]] * XLine.ar(0.001, 1, 0.005) * 1.5);
}.play.register;
});
)

[~lead, ~billes6].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 15)});});