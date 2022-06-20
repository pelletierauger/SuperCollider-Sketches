
~nT = TempoClock.new(1.39 * 1.5).permanent_(true);

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~drums.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~drums = {
        | trigGate = 1 |var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
        var trig = Impulse.ar(~nT.tempo * 2) * trigGate;
        var kick  = [1, 0, 0, 0, 0, 0, 0, 0] ++ [1, 0, 0, 0, 0, 1, 0, 0];
        var snare = [0, 0, 0, 0, 1, 0, 0, 0] ++ [0, 0, 0, 0, 1, 0, 0, 0];
        var hats  = [1];
        var blocks = [kick, snare, snare, hats].collect({
            |item| Demand.ar(trig, 0, Dseq(item, inf));
        });
        var hh = Demand.ar(trig * blocks[3], 0, Dseq(
            0.9 + (([0, 1].wrapExtend(16)) * [0, 0, 0, 1].stutter(4) * 0.3), inf));
        var sig = MiPlaits.ar(
            pitch: 30 + ([0, 2, 2, 6] * 12),
            engine: 9,
            harm: 0.95,
            timbre: 1,
            morph: 0.45 - [0, 0.4, 0.4, 0.5],
            trigger: trig * blocks,
            decay: [0.9, 1, 1, hh] * 0.685 * 1,
            // morph_mod: -1,
            lpg_colour: 0
        );
        var w = Demand.ar(trig * blocks[1], 0, Dwhite(0, 1, inf));
        var u = Demand.ar(trig * blocks[0], 0, Dwhite(0, 1, inf));
        var sig2 = [sig[1][1], sig[2][1]] * 0.75;
        var disto;
        u = DelayN.ar(u, 1, ~nT.beatDur * 1.5 * 2);
        sig = [sig[0][1] * 2 + (sig[3][1] * 0.25)]!2 + sig2;
        // sig = VadimFilter.ar(sig, 5500, 0, 1);
/*        sig = sig * 1 + (MiRings.ar(
            sig, pit: 30 + 12, struct: x, damp: 0.6, bright: 0.5, pos: y, model: 1) * 2) * 0.5;*/
        disto = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;
/*        disto = AnalogVintageDistortion.ar(
            input: disto,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;*/
        sig = disto * 0.2 + sig;
        sig = sig * 1.6 * 0.125;
    }.play(fadeTime: 0.0).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~rim.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~rim = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * 2);
        var pat0 = [0, 0, 0, 1, 0, 0, 1, 0];
        var pat1 = [1, 0, 0, 0, 1, 1, 0, 0];
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
            harm: 0.15,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0, 0],
            trigger: trig * [block0, block1, block1, block2] * trigGate,
            decay: 0.0 + [0.9, 0.6, 0.6, 0.9] * dec * 1.7,
            // timb_mod: 0.5,
            lpg_colour: 0
        );
        var sig2 = [sig[1][1], sig[2][1]] * 1.5;
        sig = [sig[0][1] * 2 + (sig[3][1] * 0.5)]!2 + sig2;
        sig = VadimFilter.ar(sig, 5700, 0, 1) * 2;
        // sig = VadimFilter.ar(sig, 5700, 0, 5) * 2;
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 0.6 * 0.25;
    }.play(fadeTime: 0.01).register;
});
)


(
~rim.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~drums.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
)

(
var blocks = [10, 20, 30].collect({|item|
    item * 3;
});
blocks;
)





(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~drums.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~drums = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * 2) * trigGate;
        var kick  = [1, 0, 0, 0, 0, 0, 0, 0] ++ [1, 0, 0, 0, 0, 1, 0, 0];
        var snare = [0, 0, 0, 0, 1, 0, 0, 0] ++ [0, 0, 0, 0, 1, 0, 0, 0];
        var hats  = [1];
        var blocks = [kick, snare, snare, hats].collect({
            |item| Demand.ar(trig, 0, Dseq(item, inf));
        });
        var hh = Demand.ar(trig * blocks[3], 0, Dseq(
            0.9 + (([0, 1].wrapExtend(16)) * [0, 0, 0, 1].stutter(4) * 0.3), inf));
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
        sig = [sig[0][1] * 2 + (sig[3][1] * 0.25)]!2 + sig2;
        // sig = VadimFilter.ar(sig, 5500, 0, 1);
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
        sig = sig * 1.6 * 0.125;
    }.play(fadeTime: 0.0).register;
});
)