~nT = TempoClock.new(3).permanent_(true);
~nT.tempo;
~nT.tempo = 3;

// ------------------------------------------------------------------
// Une lourde hémiole fait son chemin au creux de la nuit
// ------------------------------------------------------------------


(
~nT.sched(~nT.timeToNextBeat(quant: 3), {
    ~k.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~k = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var t0 = Impulse.kr(~nT.tempo * 1) * trigGate;
        var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 0, 1, 0, 0], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10], inf));
        var sig = MiBraids.ar(
            pitch: 24 + 12 + Demand.kr(t, 0, Dseq([0, -1].stutter(4), inf)),
            timbre: 0.9,
            color: 0.3,
            model: 34,
            trig: t,
            resamp: [0, 2],
            decim: 32,
            bits: Demand.kr(t, 0, Dseq([2, 4, 6], inf)),
            ws: 1
        );
        sig = (sig[0] + (sig[1] * 0.2 * sig[0]))!2;
        sig = LPF.ar(sig, 4400);
        sig * 2 * 2;
    }.play;
});

~nT.sched(~nT.timeToNextBeat(quant: 3), {
    ~k2.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~k2 = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var t0 = Impulse.kr(~nT.tempo * 1) * trigGate;
        var t = t0 * Demand.kr(t0, 0, Dseq([0, 0, 1, 0, 1, 0], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10], inf));
        var sig = MiBraids.ar(
            pitch: 24 + 12 + Demand.kr(t, 0, Dseq([0, -1].stutter(4), inf)),
            timbre: 0.9,
            color: 0.3,
            model: 34,
            trig: t,
            resamp: [0, 2],
            decim: 32,
            bits: Demand.kr(t, 0, Dseq([2, 4, 6], inf)),
            ws: 1
        );
        sig = (sig[0] + (sig[1] * 0.2 * sig[0]))!2;
        sig = VadimFilter.ar(sig, 4400, 0, 5) * 1;
        sig * 2 * 2;
    }.play;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums2 = {
        | trigGate = 1 |var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
        var trig = Impulse.kr(~nT.tempo * 1) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 4) * trigGate;
        var a = Demand.kr(trig, 0, Dseq([0, 0, 0, 1].stutter(16), inf));
        var pat0 = [1, 0, 0, 1, 0, 0, 1, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0];
        // var pat2 = [1, 0, 1, 0].wrapExtend((6 * 3) - 6) ++ [1, 1, 1, 1];
        var pat2 = [1, 0, 0, 0].wrapExtend((4 * 3)) ++ [1, 0, 1, 1];
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8], inf));
        var bitsTrig = trig * Demand.kr(trig, 0, Dseq([1, 0, 0, 1, 0, 0], inf));
        // var bits = Demand.kr(bitsTrig, 0, Dxrand([1, 2, 3, 4, 5, 6], inf));
        var bits = Demand.kr(bitsTrig, 0, Dxrand([1, 2, 3, 4, 5, 6], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.1], [-8, -8]), gate: [block1, block2]).sum!2;
        var sig = MiBraids.ar(
            pitch: 12 + ([1, 2, 2, 3] + 1 * 12) + [0, 0, 0.2, 0],
            model: [34, 36, 36, 36],
            color: 0.2!2 ++ (0.2!1),
            timbre: [0.5, 0.1, 0.1, 0.1],
            // morph: 0.45 - [0, 0.4, 0.4, 0.5],
            trig: [block0, block1, block1, block2],
            resamp: 2,
            decim: 1,
            bits: bits,
            ws: [0.25, 0.25, 0.26, 0.25] * env * 4
            // decay: [0.9, 0.9, 0.9, dec] * 0.5,
            // timb_mod: -0.35,
            // morph_mod: 0.85,
            // lpg_colour: 0
        );
        var hat = (sig[3] * 0.125);
        var kickhat = sig[0] * 2 + hat;
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1], sig[2]] * 2 * snareFix;
        var mm, mmm;
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 1100, 8) * 0.5;
        // sig = VadimFilter.ar(sig, 4000, 0, 1) * 0.25;
        sig = LPG.ar(
            input: sig,
            controlinput: (env.clip(0, 1) + (DelayN.kr(env.clip(0, 1), 2, ~nT.beatDur * 1.5) * 1) + Line.kr(1, 0, 0.3)).clip(0, 1) * trigGate.lag(0.05),
            controloffset: 0,
            controlscale: 0.5,
            vca: 0.5,
            resonance: 1,
            lowpassmode: 0,
            linearity: 1
        ) * 0.5;
        // mmm = (PinkNoise.ar(0.1) * (Amplitude.ar(sig)) * 16);
        // mmm = VadimFilter.ar(mmm, 1500, 0, 3) * 1;
        // mmm = DelayN.ar(mmm, 2, ~nT.beatDur * 1.5);
        mm = Demand.kr(trig, 0, Dwhite(0, 0.7, inf)).lag(0.1);
        sig = (sig * (0.3 + mm)) + VadimFilter.ar(sig, 3000 * (mm + 0.7) + 100, 0, 5) * 1;
        // sig = VadimFilter.ar(sig, 2000, 0, 1) * 1;
        // sig = sig + mmm;
        // sig = VadimFilter.ar(sig, 4000, 0, 1) + (VadimFilter.ar(sig, 7000, 0, 3) * 0.3) * 1;
        // sig = VadimFilter.ar(sig, 1000, 0, 5);
        // sig = sig * 0.5 + (MiRings.ar(
        // sig, pit: 30 + 12, struct: x, damp: 0.6, bright: 0.5, pos: y, model: 1) * 2) * 0.5;
        sig = MiElements.ar(strike_in: sig, pit: 23, strength: 0.5, damp: 0.125, geom: 0.6, model: 0) * 5;
        // sig = sig * 0 + (JPverb.ar(sig, t60: 0.5, damp: 0.6, high: 0) * 0.5);
    }.play(fadeTime: 0.0).register;
});
)

(
~k.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~k2.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
)




(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums2 = {
        | trigGate = 1 |var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
        var trig = Impulse.kr(~nT.tempo * 1) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 4) * trigGate;
        var a = Demand.kr(trig, 0, Dseq([0, 0, 0, 1].stutter(16), inf));
        var pat0 = [1, 0, 0, 1, 0, 0, 1, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0] ++ [0, 0, 0, 1, 0, 0, 0, 0];
        // var pat2 = [1, 0, 1, 0].wrapExtend((6 * 3) - 6) ++ [1, 1, 1, 1];
        var pat2 = [1, 0, 0, 0].wrapExtend((4 * 3)) ++ [1, 0, 1, 1];
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8], inf));
        var bitsTrig = trig * Demand.kr(trig, 0, Dseq([1, 0, 0, 1, 0, 0], inf));
        // var bits = Demand.kr(bitsTrig, 0, Dxrand([1, 2, 3, 4, 5, 6], inf));
        var bits = Demand.kr(bitsTrig, 0, Dxrand([1, 2, 3, 4, 5, 6], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.1], [-8, -8]), gate: [block1, block2]).sum!2;
        var sig = MiBraids.ar(
            pitch: 12 + ([1, 2, 2, 3] + 0 * 12) + [0, 0, 0.2, 0],
            model: [34, 36, 36, 36],
            color: 0.2!2 ++ (0.2!1) + 0.2,
            timbre: [0.5, 0.5, 0.5, 0.1] * 0,
            // morph: 0.45 - [0, 0.4, 0.4, 0.5],
            trig: [block0, block1, block1, block2],
            resamp: 2,
            decim: 1,
            bits: 3,
            ws: [0.25, 0.25, 0.26, 0.25] * env * 4
            // decay: [0.9, 0.9, 0.9, dec] * 0.5,
            // timb_mod: -0.35,
            // morph_mod: 0.85,
            // lpg_colour: 0
        );
        var hat = (sig[3] * 0.125);
        var kickhat = sig[0] * 2 + hat;
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1], sig[2]] * 2 * snareFix;
        var mm, mmm;
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 1100, 8) * 0.5;
        // sig = VadimFilter.ar(sig, 4000, 0, 1) * 0.25;
        sig = LPG.ar(
            input: sig,
            controlinput: (env.clip(0, 1) + (DelayN.kr(env.clip(0, 1), 2, ~nT.beatDur * 3) * 10) + Line.kr(1, 0, 0.3)).clip(0, 1) * trigGate.lag(0.05),
            controloffset: 0,
            controlscale: 0.5,
            vca: 0.5,
            resonance: 1,
            lowpassmode: 0,
            linearity: 1
        ) * 0.5;
        // mmm = (PinkNoise.ar(0.1) * (Amplitude.ar(sig)) * 16);
        // mmm = VadimFilter.ar(mmm, 1500, 0, 3) * 1;
        // mmm = DelayN.ar(mmm, 2, ~nT.beatDur * 1.5);
        mm = Demand.kr(trig, 0, Dwhite(0, 0.7, inf)).lag(0.1);
        sig = (sig * (0.3 + mm)) + VadimFilter.ar(sig, 3000 * (mm + 0.7) + 100, 0, 5) * 1;
        // sig = VadimFilter.ar(sig, 2000, 0, 1) * 1;
        // sig = sig + mmm;
        // sig = VadimFilter.ar(sig, 4000, 0, 1) + (VadimFilter.ar(sig, 7000, 0, 3) * 0.3) * 1;
        // sig = VadimFilter.ar(sig, 1000, 0, 5);
        // sig = sig * 0.5 + (MiRings.ar(
        // sig, pit: 30 + 12, struct: x, damp: 0.6, bright: 0.5, pos: y, model: 1) * 2) * 0.5;
        sig = sig + MiElements.ar(strike_in: sig, pit: 23, strength: 0.5, damp: 0.5, geom: 0.2, model: 0) * 5;
        // sig = sig * 0 + (JPverb.ar(sig, t60: 0.5, damp: 0.6, high: 0) * 0.5);
    }.play(fadeTime: 0.0).register;
});
)