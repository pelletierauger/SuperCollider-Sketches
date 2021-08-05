~nT = TempoClock.new(1.39 * 1.25 * 1.075).permanent_(true);

(
// ~nT.sched(~nT.timeToNextBeat(quant: 4), {
~drum = {
    if(~rim.isPlaying, {~rim.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
    ~rim = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var tempo = ~nT.tempo * 2;
        var basePulse = Impulse.ar(tempo) * trigGate;
        var swing = [2, 4] / 3;
        var swungTempo = Demand.ar(basePulse, 0, Dseq(swing * tempo, inf));
        var trig = Impulse.ar(swungTempo) * trigGate;
        var pat0 = [1, 0, 0, 0, 0, 1, 0, 0];
        var pat1 = [0, 0, 1, 0, 0, 0, 1, 1];
        var pat2 = [1, 1, 1, 1, 0, 0, 1, 0];
        var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
        var dec = Demand.ar(trig, 0, Dseq(0.75!24 ++ (0.75!8), inf));
        // var pit = Demand.ar(trig, 0, Dseq(-12!16 ++ (0!16), inf));
        var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var pit = max(0, ~pit) * -12;
        var sig = MiPlaits.ar(
            pitch: [ 48, 60, 60, 84 ] - 12 + pit + 12,
            engine: 9,
            harm: 0.9,
            timbre: [0.5, 1, 1, 0.5].rotate(0),
            morph: 0.25 - [0, 0.2, 0, 0],
            trigger: trig * [block0, block1, block1, block2],
            decay: 0.3 + [0.9, 0.6, 0.6, 0.7] * 0.75,
            lpg_colour: 0
        );
        var envBl = EnvGen.kr(Env([0, 0, 1], [0.5, 0.01]));
        var sig2 = [sig[1][1], sig[2][1]] * 0.05 * envBl;
        sig = [sig[0][1] * 2 + (sig[3][1] * 0.25)]!2 + sig2;
        // sig = LPF.ar(sig, 4000);
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 3.6 * 1.5 * envGate;
        Out.ar(0, sig);
    }.play(fadeTime: 0.01).register;
};
)


(
~pit = 1;
~drums = Task {
    {
        ~drum.();
        8.wait;
        ~pit = ~pit * -1;
    }.loop;
}.start(~nT, quant: [4]);
)
~drums.stop;
~pit

(
~drums.stop;
    if(~rim.isPlaying, {~rim.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});

)


(
    if(~rim.isPlaying, {~rim.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
~drums.stop;
    if(~rimz.isPlaying, {~rimz.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
    [~lead].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 15)});});
    [~billes6].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});});

)