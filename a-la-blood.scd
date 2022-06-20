
(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~rim.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~rim = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * 2);
        var pat0 = [1, 0, 0, 1, 0, 0, 1, 0];
        var pat1 = [1, 0, 0, 0, 1, 1, 0, 0];
        var pat2 = [1];
        var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
        var dec = Demand.ar(trig, 0, Dseq((0.65!1) ++ (0.5!23) ++ (0.65!8), inf));
        var pit = Demand.ar(trig, 0, Dseq(-12!24 ++ (-24!8), inf));
        var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var sig = MiPlaits.ar(
            pitch: 30 + [0, 0, 0, 24] + 24 - [24, 12, 12, 12] + 0  + [-12, -12, -12, pit],
            engine: [13, 14, 14, 15],
            harm: 1,
            timbre: 0.5,
            morph: 0.165 - [0, 0.2, 0, 0] + 0.4,
            trigger: trig * [block0, block1, block1, block2] * trigGate,
            decay: 0.0 + [0.9, 0.6, 0.6, 0.1] * dec * 1,
            // timb_mod: 0.5,
            lpg_colour: 0
        );
        var sig2 = [sig[1][1], sig[2][1]] * 1.5;
        sig = [sig[0][1] * 2 + (sig[3][1] * 0.5)]!2 + sig2;
        sig = VadimFilter.ar(sig, 5700, 0, 1) * 2;
        // sig = VadimFilter.ar(sig, 5700, 0, 5) * 2;
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 0.6 * 1;
    }.play(fadeTime: 0.01).register;
});
)




(
{        var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
    var sig = MiPlaits.ar(45, engine: 0, harm: x, timbre: 1 - y, morph: y)[1];
    sig = VadimFilter.ar(sig, 2000, 0, 1) * 0.1!2;}.play;
)


(
{        var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
    var lfo = SinOsc.kr(1);
    var sig = MiPlaits.ar(30 + [0, 0.01 * lfo], engine: 0, harm: x, timbre: 1 - y, morph: y);
    sig = [sig[0][1], sig[1][1]];
    sig = VadimFilter.ar(sig, 12000, 0, 1) * 0.1;}.play;
)


// Lourd drone bas
(
{        var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
    var lfo = SinOsc.kr(0.1);
    var sig = MiPlaits.ar(30 + [0, 0.01 * lfo], engine: 0, harm: x, timbre: 1 - y, morph: y);
    sig = [sig[0][1], sig[1][1]];
    sig = VadimFilter.ar(sig, 2000 * lfo.unipolar + 100, 0.25, 1) * 0.4;}.play;
)

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
x.free;
    x = {        var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
    var t = Impulse.kr(~nT.tempo * 1);
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 2], [2, -8]), t);
    var d = 30 + Demand.kr(t, 0, Dseq([0, 2, 3, 5, 6, 7].reverse, inf)) + 24;
    var lfo = SinOsc.kr(1);
    var sig = MiPlaits.ar(
        d + [0, 0.01 * lfo],
        engine: 0, harm: x, timbre: 1 - x, morph: y, decay: 0.4, trigger: t);
    sig = [sig[0][1], sig[1][1]];
        // sig = sig + (DelayC.ar(VadimFilter.ar(sig, 500, 0, 1), 1, ~nT.beatDur * 0.5));
    sig = VadimFilter.ar(sig, 2000, 0, 1) * 0.5;}.play;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
x.free;
    x = {        var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
    var t = Impulse.kr(~nT.tempo * 1);
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 2], [2, -8]), t);
    var d = 30 + Demand.kr(t, 0, Dseq([0, 2, 3, 5, 6, 7].reverse, inf)) + 24;
    var lfo = SinOsc.kr(1);
    var sig = MiPlaits.ar(
        d + [0, 0.01 * lfo],
        engine: 0, harm: x, timbre: 1 - x, morph: y, decay: 0.4, trigger: t);
    sig = [sig[0][1], sig[1][1]];
        // sig = sig + (DelayC.ar(VadimFilter.ar(sig, 500, 0, 1), 1, ~nT.beatDur * 0.5));
    sig = VadimFilter.ar(sig, 2000, 0, 1) * 0.5;
        MiClouds.ar(
        inputArray: sig,
        pit: 0,
        pos: 0,
        size: 0,
        dens: 0.01,
        tex: 0.25,
        drywet: 0.75,
        in_gain: 1,
        spread: 0,
        rvb: 0.8,
        fb: 0,
        freeze: 0,
        mode: 1,
        lofi: 0
    )
    }.play;
});
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
            pitch: 30 + ([0, 2, 2, 6] * 12),
            engine: 10,
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
        sig = sig * 1 + MiRings.ar(
            sig, pit: 30 + 12, struct: w, damp: 0.6, bright: 0.5, pos: u, model: 1) * 0.5;
        // sig = disto * 0 + sig;
        sig = sig * 1.6 * 0.125;
    }.play(fadeTime: 0.0).register;
});
)




(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
x.free;
    x = {        var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
    var t = Impulse.kr(~nT.tempo * 1);
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 2], [2, -8]), t);
    var d = 30 + Demand.kr(t, 0, Dseq([0, 2, 3, 5, 6, 7].reverse, inf)) + 24;
    var lfo = SinOsc.kr(1);
    var sig = MiPlaits.ar(
        d + [0, 0.01 * lfo],
        engine: 0, harm: x, timbre: 1 - x, morph: y, decay: 0.4, trigger: t);
    sig = [sig[0][1], sig[1][1]];
        // sig = sig + (DelayC.ar(VadimFilter.ar(sig, 200, 0, 1), 1, ~nT.beatDur * 0.5) * 8);
        sig = sig + ((VadimFilter.ar(sig, 500, 0, 1)) * 4);
    sig = VadimFilter.ar(sig, 2000, 0, 1) * 0.5;}.play;
});
)

