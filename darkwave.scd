s.record;
s.stopRecording;
~recFolder.openOS;
~nT.tempo
~nT = TempoClock.new(2).permanent_(true);
~nT = TempoClock.new(1.39).permanent_(true);
t = TempoClock.new(2).permanent_(true);
(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    if(~bass.isPlaying, {~bass.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~bass = {
        | trigGate = 1 |
        var lfo = SinOsc.kr(0.1).range(0.1, 0.12);
        var trig = Impulse.ar(~nT.tempo * 4) * trigGate;
        var h = Line.kr(0.25, 0, 2);
        var dem = Demand.ar(trig, 0, Dseq(Pseries(0, 0.05, 8).asStream.nextN(8), inf)).lag(2) + h;
        var dem3 = Demand.ar(trig, 0, Dseq([0, -4].stutter(16), inf));
        var f = 28 - 7 - 5 + dem3;
        var dem2 = Demand.ar(trig, 0, Dseq(0, inf));
        var alg = 5;
        var sig = MiPlaits.ar(f + [0, 0.1],
            engine: 6,
            harm: lfo,
            timbre: 0.5 + (dem * -0.5),
            morph: dem * 0.5,
            // morph: 0.8,
            trigger: trig,
            decay: 0.3,
            morph_mod: -1,
            // fm_mod: -0.5,
            lpg_colour: 0
        ) * 0.2;
        var sig2 = ([sig[0][1], sig[1][1]] * 0.5);
        sig = [sig[0][0], sig[1][0]] * 1.5;
        sig = sig * EnvGen.kr(Env([0, 0, 1], [0.01, 0.001]));
        sig = VAKorg35.ar(sig, freq: 1000, res: 0.1, overdrive: 0.5);
        sig = MiVerb.ar(sig, drywet: 1) * 0.6 + sig;
        sig = VadimFilter.ar(sig, 200 + (5000 * dem), 0, 1);
        sig = sig * EnvGen.kr(Env([0, 0, 1], [0.01, 0.001]));
    }.play(fadeTime: 0).register;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    // if(~drums23.isPlaying, {~drums23.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums2 = {
        | trigGate = 1 |var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
        var trig = Impulse.kr(~nT.tempo * 4) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 2) * trigGate;
        var a = Demand.kr(trig, 0, Dseq([0, 0, 0, 1].stutter(16), inf));
        //          |     ;     |     ;         |     ;     |     ;
        // var pat0 = [1, 0, 0, 1, 0, 0, 0, 0];
        var pat0 = [1, 0, 0, 0, 1, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0];
        var pat2 = [1, 1, 1, 1];
        var block0 = trig2 * Demand.kr(trig2, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8], inf));
        var bitsTrig = trig * Demand.kr(trig, 0, Dseq([1, 0, 1, 0], inf));
        var bits = Demand.kr(bitsTrig, 0, Drand([0, 0, 0, 0, 1, 1, 2, 2, 2, 3], inf));
        var aa = Demand.kr(trig2 * block2, 0, Dseq(0!1 ++ (0.1!1), inf));
        var sig = MiBraids.ar(
            pitch: 28 + ([1, 2, 2, 5] + 1 * 12) - 5,
            model: [34, 36, 36, 36],
            color: [0, 0, 0, 0] + 0.5,
            timbre: [0.2, 0.2, 0.2, 0.5] + 0.8,
            // morph: 0.45 - [0, 0.4, 0.4, 0.5],
            trig: [block0, block1, block1, block2],
            resamp: 2,
            decim: 32,
            bits: bits + 2,
            ws: 0.25
            // decay: [0.9, 0.9, 0.9, dec] * 0.5,
            // timb_mod: -0.35,
            // morph_mod: 0.85,
            // lpg_colour: 0
        );
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [-8, -8]), gate: [block0, block1]).sum!2;
        var hats = sig[3] * 0.5;
        var kick = sig[0] * 6;
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1], sig[2]] * 3 * snareFix;
        var mm, mmm;
        sig = kick + hats * 1!2 + snare;
        // sig = Decimator.ar(sig, 1100, 8) * 0.5;
        // sig = VadimFilter.ar(sig, 4000, 0, 1) * 0.25;
 /*       sig = LPG.ar(
            input: sig,
            controlinput: (env.clip(0, 1) + (DelayN.kr(env.clip(0, 1), 2, ~nT.beatDur * 1.5) * trigGate * 10) + Line.kr(1, 0, 0.3)).clip(0, 1),
            controloffset: 0,
            controlscale: 0.5,
            vca: 0.5,
            resonance: 1,
            lowpassmode: 0,
            linearity: 1
        ) * 1;*/
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
        // sig = VadimFilter.ar(kick, 2000, 0, 5) * 0 + MiElements.ar(strike_in: sig, pit: 23, strength: 0.5, damp: 0.5, geom: 0.25, model: 0);
        sig = sig * EnvGen.kr(Env([0, 0, 1], [0.01, 0.001]));
        sig = VadimFilter.ar(sig, 1000, 0, 5) * 4 * 4 + (sig * 2) * 0.08;
        sig = VadimFilter.ar(sig, 2000, 0, 1);
        // sig = sig * 0 + (JPverb.ar(sig[0], t60: 0.5, damp: 0.6, high: 0) * 2);
    }.play(fadeTime: 0.0).register;
});
)


Safety(s).disable

(
y.free;
y = {
    var f = 22 + 12 + 7 - 12 + 5 + 12 - 1;
    var lfo = SinOsc.kr(0.1).range(0.1, 0.12);
    var trig = Impulse.ar(4);
    var dem = Demand.ar(trig, 0, Dseq(Pseries(0, 0.025, 16).asStream.nextN(16), inf));
    var lfo2 = SinOsc.kr(0.1, pi / 2).range(0, 0.5);
    var dem2 = Demand.ar(trig, 0, Dseq([0, -2, 0, 5, 0, -2, 0, 2], inf));
    var alg = 6;
    var sig1 = MiPlaits.ar(f + dem2, alg, harm: lfo, morph: lfo2, trigger: trig, usetrigger: 1, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1 + dem2, alg, harm: lfo, morph: lfo2, trigger: trig, usetrigger: 1, mul: 0.2);
    var sig = [sig1[0], sig2[0]] * 2;
    LPF.ar(sig, SinOsc.kr(0.1).range(800, 8000)) * 0.25;
    // sig;
}.play;
)


(
x.free;
x = {
    var f = 22 + 12 + 0;
    var lfo = SinOsc.kr(0.1).range(0.1, 0.12);
    var trig = Impulse.ar(8);
    var dem = Demand.ar(trig, 0, Dseq(Pseries(0, 0.1, 8).asStream.nextN(8), inf));
    var dem2 = Demand.ar(trig, 0, Dseq([0, -2, 0, 4], inf));
    var alg = 5;
    var sig1 = MiPlaits.ar(f + dem2, alg, harm: lfo, morph: dem, trigger: trig, usetrigger: 1, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1 + dem2, alg, harm: lfo, morph: dem, trigger: trig, usetrigger: 1, mul: 0.2);
    var sig = [sig1[0], sig2[0]] * 1.5;
    LPF.ar(sig, 400 + (10000 * dem));
}.play;
)



(
z.free;
z = {
    var f = 22 + 12 + 7 + 5;
    var lfo = SinOsc.kr(0.1).range(0.1, 0.12);
    var lfo2 = SinOsc.kr(0.5).range(0.8, 0.9);
    var trig = Impulse.ar(4);
    var alg = 5;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, morph: lfo2, trigger: trig, usetrigger: 0, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: lfo2, trigger: trig, usetrigger: 0, mul: 0.2);
    [sig1[0], sig1[0]] * 1.5 * 0.25;
}.play;
)


(
v.free;
v = {
    var f = 22 + 12 + 7 + 5 + 0;
    var lfo = SinOsc.kr(0.1).range(0.1, 0.12);
    var lfo2 = SinOsc.kr(0.1).range(0, 0.99);
    var trig = Impulse.ar(4);
    var alg = 5;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, timbre: 0.25, morph: lfo2, trigger: trig, usetrigger: 0, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, timbre: 0.25, morph: lfo2, trigger: trig, usetrigger: 0, mul: 0.2);
    [sig1[0], sig2[0]] * 1.5 * 0.25;
}.play;
)

(
x = {
    var f = 31 + 36 + -5;
    // var lfo = SinOsc.kr(0.1).range(0.25, 0.5);
    var lfo = 0.75;
    var alg = 0;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, timbre: 0.125, morph: 0.4, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, timbre: 0.125, morph: 0.4, mul: 0.2);
    var sig3 = [sig1[0], sig2[0]];
    var throb = SinOsc.kr(0.1).range(1930, 4200);
    MoogFF.ar(sig3, throb, 0.83 * 4);
}.play;
)
x.free;
MoogFF

(
x = {
    MoogFF.ar(
        Pulse.ar([40,121], [0.3,0.7]),
        SinOsc.kr(LFNoise0.kr(0.42).range(0.001, 2.2)).range(30, 4200),
        0.83 * 4)}.play(s);
)
x.free;



(
x = {
    var f = 31 + 36 + -5;
    // var lfo = SinOsc.kr(0.1).range(0.25, 0.5);
    var lfo = 0.75;
    var alg = 0;
    var sig1 = MiPlaits.ar(f, alg, harm: lfo, timbre: 0.125, morph: 0.4, mul: 0.2);
    var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, timbre: 0.125, morph: 0.4, mul: 0.2);
    var sig3 = [sig1[0], sig2[0]];
    var throb = SinOsc.kr(0.1).range(1930, 4200);
    MoogFF.ar(sig3, throb, 0.83 * 4);
}.play;
TempoClock.default.sched(3, {
    x = {
        var f = 31 + 36 + 0;
        // var lfo = SinOsc.kr(0.1).range(0.25, 0.5);
        var lfo = 0.75;
        var alg = 0;
        var sig1 = MiPlaits.ar(f, alg, harm: lfo, timbre: 0.125, morph: 0.4, mul: 0.2);
        var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, timbre: 0.125, morph: 0.4, mul: 0.2);
        var sig3 = [sig1[0], sig2[0]];
        var throb = SinOsc.kr(0.1).range(1930, 4200);
        MoogFF.ar(sig3, throb, 0.83 * 4);
    }.play;
});
TempoClock.default.sched(5, {
    x = {
        var f = 31 + 36 + 2;
        // var lfo = SinOsc.kr(0.1).range(0.25, 0.5);
        var lfo = 0.75;
        var alg = 0;
        var sig1 = MiPlaits.ar(f, alg, harm: lfo, timbre: 0.125, morph: 0.4, mul: 0.2);
        var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, timbre: 0.125, morph: 0.4, mul: 0.2);
        var sig3 = [sig1[0], sig2[0]];
        var throb = SinOsc.kr(0.1).range(1930, 4200);
        MoogFF.ar(sig3, throb, 0.83 * 4);
    }.play;
});
)


