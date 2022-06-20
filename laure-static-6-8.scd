(
~nT.sched(~nT.timeToNextBeat(quant: 6), {
    ~drums.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~drums = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * 2) * trigGate;
        var kick = [1, 0, 0, 1, 0, 0] ++ [1, 0, 0, 1, 0, 0];
        var snare  = [0, 0, 1, 0, 1, 0] ++ [0, 1, 0, 0, 1, 0];
        var hats  = [1];
        var blocks = [kick, snare, snare, hats].collect({
            |item| Demand.ar(trig, 0, Dseq(item, inf));
        });
        var hh = Demand.ar(trig * blocks[3], 0, Dseq([0.9, 0.9, 0.9], inf));
        var sig = MiPlaits.ar(
            pitch: 30 + ([0, 1, 1, 3] * 12),
            engine: 9,
            harm: 0.95,
            timbre: 1,
            morph: 0.45 - [0, 0.4, 0.4, 0.5],
            trigger: trig * blocks,
            decay: [0.9, 1, 1, hh] * 0.685 * 1,
            lpg_colour: 0
        );
        var w = Demand.ar(trig * blocks[1], 0, Dwhite(0, 1, inf));
        var u = Demand.ar(trig * blocks[0], 0, Dwhite(0, 1, inf));
        var sig2 = [sig[1][1], sig[2][1]] * 0.75;
        var disto;
        u = DelayN.ar(u, 1, ~nT.beatDur * 1.5 * 2);
        sig = [sig[0][1] * 2 + (sig[3][1] * 0.25 * 1)]!2 + sig2;
        // sig = VadimFilter.ar(sig, 5500, 0, 1);.5
        sig = sig * 1 + MiRings.ar(sig, pit: 30 + 12, struct: w, damp: 0.6, pos: u, model: 1) * 0.5;
        disto = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;
        disto = AnalogVintageDistortion.ar(
            input: disto,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;
        sig = disto * 0 + sig;
        sig = sig * 1.6 * 0.5;
    }.play(fadeTime: 0.0).register;
});
)
