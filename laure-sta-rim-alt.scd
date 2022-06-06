(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
~rim.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~rim = {
    | trigGate = 1 |
    var trig = Impulse.ar(~nT.tempo * 1);
    var pat0 = [1, 0, 0, 0, 0, 1, 0, 0].rotate(-2);
    var pat1 = [0, 0, 1, 0, 0, 0, 1, 1].rotate(-2);
    var pat2 = [1];
    var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
    var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
    var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
        var dec = Demand.ar(trig, 0, Dseq((0.65!1) ++ (0.5!23) ++ (0.65!8), inf));
        var pit = Demand.ar(trig, 0, Dseq(-12!24 ++ (-24!8), inf));
    var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
    var sig = MiPlaits.ar(
        pitch: 30 + [0, 0, 0, 24] + 24 - [24, 12, 12, 12] + 0 + 12 + pit,
        engine: 10,
        harm: 0.95,
        timbre: 0.9,
        morph: 0,
        trigger: trig * [block0, block1, block1, block2] * trigGate,
        decay: 0.0 + [0.9, 0.6, 0.6, 0.9] * dec * 1.7,
            fm_mod: -0.5,
            timb_mod: 1,
           morph_mod: -0.5,
        lpg_colour: 0
    );
    var sig2 = [sig[1][1], sig[2][1]] * 1.5;
    sig = [sig[0][1] * 2 + (sig[3][1] * 0.5)]!2 + sig2;
        sig = VadimFilter.ar(sig, 2700, 0, 1) * 2;
    // sig = (sig * 0.75) + HPF.ar(sig, 200);
    // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
    sig = sig * 0.6 * 0.25;
}.play(fadeTime: 0.01).register;
});
)