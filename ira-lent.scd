
// Le tempo très rapide, frénétique.

~nT = TempoClock.new(3.5).permanent_(true);
~nT.tempo;
~nT.tempo = 3.5;

s.record;
s.stopRecording;
Safety(s).disable;

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    // if(~drums23.isPlaying, {~drums23.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums2 = {
        | trigGate = 1 |var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
        var trig = Impulse.kr(~nT.tempo * 1) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 2) * trigGate;
        var a = Demand.kr(trig, 0, Dseq([0, 0, 0, 1].stutter(16), inf));
        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, 0, 1, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, 1, 0] ++ [0, 0, 0, 1, 0, 0, 1, 0];
        var pat2 = [1, 0, 1, 0].wrapExtend(4 * 3) ++ [1, 1, 1, 1];
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8], inf));
        var bitsTrig = trig * Demand.kr(trig, 0, Dseq([1, 0, 1, 0], inf));
        var bits = Demand.kr(bitsTrig, 0, Dxrand([1, 2, 3], inf));
        var aa = Demand.kr(trig2 * block2, 0, Dseq(0!1 ++ (0.1!1), inf));
        var sig = MiBraids.ar(
            pitch: 28 + ([1, 2, 2, 5] + 0 * 12) - 5,
            model: [34, 36, 36, 36],
            color: [0, 0, 0, aa] + 0,
            timbre: [0.2, 0.2, 0.2, aa],
            // morph: 0.45 - [0, 0.4, 0.4, 0.5],
            trig: [block0, block1, block1, block2],
            resamp: 2,
            decim: 2,
            bits: bits,
            ws: 0.5
            // decay: [0.9, 0.9, 0.9, dec] * 0.5,
            // timb_mod: -0.35,
            // morph_mod: 0.85,
            // lpg_colour: 0
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [-8, -8]), gate: [block0, block2]).sum!2;
        var hats = sig[3] * 0.25;
        var kick = sig[0] * 6;
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1], sig[2]] * 3 * snareFix;
        var mm, mmm;
        sig = kick + hats * 1!2 + snare;
        // sig = Decimator.ar(sig, 1100, 8) * 0.5;
        // sig = VadimFilter.ar(sig, 4000, 0, 1) * 0.25;
        sig = LPG.ar(
            input: sig,
            controlinput: (env.clip(0, 1) + (DelayN.kr(env.clip(0, 1), 2, ~nT.beatDur * 1.5) * trigGate) + Line.kr(1, 0, 0.3)).clip(0, 1),
            controloffset: 0,
            controlscale: 0.5,
            vca: 0.5,
            resonance: 1,
            lowpassmode: 0,
            linearity: 1
        ) * 1;
        // mmm = (PinkNoise.ar(0.1) * (Amplitude.ar(sig)) * 16);
        // mmm = VadimFilter.ar(mmm, 1500, 0, 3) * 1;
        // mmm = DelayN.ar(mmm, 2, ~nT.beatDur * 1.5);
        mm = Demand.kr(trig, 0, Dwhite(0, 0.7, inf)).lag(0.1);
        sig = (sig * (0.3 + mm)) + VadimFilter.ar(sig, 3000 * (mm + 0.7) + 100, 0, 5) * 1;
        // sig = sig + mmm;
        // sig = VadimFilter.ar(sig, 4000, 0, 1) + (VadimFilter.ar(sig, 7000, 0, 3) * 0.3) * 1;
        // sig = VadimFilter.ar(sig, 1000, 0, 5);
        // sig = sig * 0.5 + (MiRings.ar(
        // sig, pit: 23 + 12, struct: x, damp: 0.6, bright: 0.5, pos: y, model: 1) * 2) * 0.5;
        VadimFilter.ar(kick, 2000, 0, 5) * 0 + MiElements.ar(strike_in: sig, pit: 23, strength: 0.2, damp: 0.125, geom: 0.75, model: 0);
    }.play(fadeTime: 0.0).register;
});
)

{MiBraids.ar(60, model: 42) * 0.4!2}.play;


s.record;
s.stopRecording;

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    // if(~drums23.isPlaying, {~drums23.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums2 = {
        | trigGate = 1 |var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
        var trig = Impulse.kr(~nT.tempo * 0.5) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 1) * trigGate;
        var a = Demand.kr(trig, 0, Dseq([0, 0, 0, 1].stutter(16), inf));
        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, 0, 1, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, 1, 0] ++ [0, 0, 0, 1, 0, 0, 1, 0];
        var pat2 = [1, 0, 1, 0].wrapExtend(4 * 3) ++ [1, 1, 1, 1];
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8], inf));
        var bitsTrig = trig * Demand.kr(trig, 0, Dseq([1, 0, 1, 0], inf));
        var bits = Demand.kr(bitsTrig, 0, Dxrand([1, 2, 3], inf));
        var aa = Demand.kr(trig2 * block2, 0, Dseq(0!1 ++ (0.1!1), inf));
        var sig = MiBraids.ar(
            pitch: 28 + ([1, 2, 2, 5] + -1 * 12) - 5,
            model: [34, 36, 36, 36],
            color: [0, 0, 0, aa] + 0,
            timbre: [0.2, 0.2, 0.2, aa] + 0.4,
            // morph: 0.45 - [0, 0.4, 0.4, 0.5],
            trig: [block0, block1, block1, block2],
            resamp: 2,
            decim: 2,
            bits: bits,
            ws: 0
            // decay: [0.9, 0.9, 0.9, dec] * 0.5,
            // timb_mod: -0.35,
            // morph_mod: 0.85,
            // lpg_colour: 0
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [-8, -8]), gate: [block0, block2]).sum!2;
        var hats = sig[3] * 0.25;
        var kick = sig[0] * 6;
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1], sig[2]] * 3 * snareFix;
        var mm, mmm;
        sig = kick + hats * 1!2 + snare;
        // sig = Decimator.ar(sig, 1100, 8) * 0.5;
        // sig = VadimFilter.ar(sig, 4000, 0, 1) * 0.25;
        sig = LPG.ar(
            input: sig,
            controlinput: (env.clip(0, 1) + (DelayN.kr(env.clip(0, 1), 2, ~nT.beatDur * 1.5) * trigGate * 10) + Line.kr(1, 0, 0.3)).clip(0, 1),
            controloffset: 0,
            controlscale: 0.5,
            vca: 0.5,
            resonance: 1,
            lowpassmode: 0,
            linearity: 1
        ) * 1;
        // mmm = (PinkNoise.ar(0.1) * (Amplitude.ar(sig)) * 16);
        // mmm = VadimFilter.ar(mmm, 1500, 0, 3) * 1;
        // mmm = DelayN.ar(mmm, 2, ~nT.beatDur * 1.5);
        mm = Demand.kr(trig, 0, Dwhite(0, 0.7, inf)).lag(0.1);
        sig = (sig * (0.3 + mm)) + VadimFilter.ar(sig, 3000 * (mm + 0.7) + 100, 0, 5) * 1;
        // sig = sig + mmm;
        // sig = VadimFilter.ar(sig, 4000, 0, 1) + (VadimFilter.ar(sig, 7000, 0, 3) * 0.3) * 1;
        // sig = VadimFilter.ar(sig, 1000, 0, 5);
        // sig = sig * 0.5 + (MiRings.ar(
        // sig, pit: 23 + 12, struct: x, damp: 0.6, bright: 0.5, pos: y, model: 1) * 2) * 0.5;
        sig = sig * EnvGen.kr(Env([0, 0, 1], [0.01, 0.001]));
        sig = VadimFilter.ar(kick, 2000, 0, 5) * 0 + MiElements.ar(strike_in: sig, pit: 23, strength: 0.5, damp: 0.125, geom: 0.5, model: 0);
        sig = sig * EnvGen.kr(Env([0, 0, 1], [0.01, 0.001]));
        sig = VadimFilter.ar(sig, 1000, 0, 5) * 4 * 4;
        sig = VadimFilter.ar(sig, 4000, 0, 1) + (kick * 0.4);
        // sig = sig * 0 + (JPverb.ar(sig[0], t60: 0.5, damp: 0.6, high: 0) * 2);
    }.play(fadeTime: 0.0).register;
});
)

{MiBraids.ar(60, model: 42) * 0.4!2}.play;
{MiBraids.ar(60, model: 42) * 0.4!2}.play;
u.free; u = {MiBraids.ar(23 + 48 + 0 + [0, 0.1], model: 42) * 0.4 }.play;
v.free; v = {MiRings.ar(MiBraids.ar(23 + 12 + [0, 0.1], timbre: 1, color:1, model: 45), pit: 59 - 12, struct: 0.3, model: 4) * 0.8 }.play;
v.free; v = {MiRings.ar(MiBraids.ar(23 + 12 + [0, 0.1], timbre: 1, color:1, model: 45, resamp:2, decim:2, bits:3, ws:0), pit: 59 - 12, damp:1, bright: 0.2, struct: 0.3, model: 4) * 2.2 }.play;
