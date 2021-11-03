
~nT = TempoClock.new(1.39).permanent_(true);
1.39 * 1.45
~nT.tempo
3.7790625


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~snare = {
    | trigGate = 1 |
    var trig = Impulse.ar(~nT.tempo * 1.3);
    var pat0 = [1, 0, 0, 1, 0, 0] ++ [1, 0, 0, 1, 1, 1];
    var pat1 = [0, 0, 1, 0, 0, 1] ++ [1, 0, 1, 0, 0, 0];
    var pat2 = [0, 1, 0, 1, 1, 1] ++ [0, 1, 0, 1, 0, 1];
    var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
    var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
    var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
        // var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
    var sig = MiPlaits.ar(
        pitch: 30 + [0, 0, 0, 24] + 24 - [24, 12, 12, 12] + 0,
        engine: 9,
        harm: 0.95,
        timbre: 1,
        morph: 0.45 - [0, 0.2, 0.2, 0],
        trigger: trig * [block0, block1, block1, block2] * trigGate,
        decay: [0.55, 0.8, 0.8, 0.7] * 0.75,
        lpg_colour: 0
    );
    var sig2 = [sig[1][1], sig[2][1]] * 1.5;
    sig = [sig[0][1] * 2 + (sig[3][1] * 0.25)]!2 + sig2;
        sig = sig + (Decimator.ar(sig, 1000, 12) * 0.2);
        sig = VadimFilter.ar(sig, 5000, 0.25, 1);
    // sig = (sig * 0.75) + HPF.ar(sig, 200);
    // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
    sig = sig * 3.6 * 0.5;
}.play(fadeTime: 0.01).register;
});
)