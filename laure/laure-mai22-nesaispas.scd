(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
~rim2.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~rim2 = {
    | trigGate = 1 |
    var trig = Impulse.ar(~nT.tempo * 2);
    var pat0 = [1, 0, 0, 0, 0, 1, 0, 0].rotate(-2);
    var pat1 = [0, 0, 1, 0, 0, 0, 1, 1].rotate(-2);
    var pat2 = [1];
    var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
    var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
    var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
        var dec = Demand.ar(trig, 0, Dseq((0.75!1) ++ (0.5!23) ++ (0.65!8), inf));
        var pit = Demand.ar(trig, 0, Dseq(-12!24 ++ (-24!8), inf));
    var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
    var sig = MiPlaits.ar(
        pitch: 20 + [0, 0, 0, 24] + 24 - [24, 12, 12, 12] + 0 + 12 + pit,
        engine: 10,
        harm: 0.1,
        timbre: 1,
        morph: 0.45 - [0, 0.2, 0, 0],
        trigger: trig * [block0, block1, block1, block2] * trigGate,
        decay: 0.0 + [0.9, 0.6, 0.6, 0.9] * dec * 1.2,
            // timb_mod: 0.5,
        lpg_colour: 0
    );
    var env = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [-8, -8]), gate: [block0, block1]).sum!2;
 var sig2 = [sig[1][1], sig[2][1]] * 1.5;
    sig = [sig[0][1] * 2 + (sig[3][1] * 0.5)]!2 + sig2;
        // env = CombC.kr(env.pow(7), 1, ~nT.beatDur * 0.125 * 0.125 * 0.125, ~nT.beatDur * 0.5);
        env = DelayN.kr(env, 1, ~nT.beatDur * 1.5);
        sig = LPG.ar(
            input: sig * 0.75,
            controlinput: env.clip(0, 1) + Line.kr(1, 0, ~nT.beatDur),
            controloffset: 0.25,
            controlscale: 0.5,
            vca: 0.75,
            resonance: 0,
            lowpassmode: 1,
            linearity: 1
        );
        sig = VadimFilter.ar(sig, 500, 0, 1) * 2 + (sig * 0.5);
    // sig = (sig * 0.75) + HPF.ar(sig, 200);
    // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
    sig = sig * 3.6 * 0.5;
}.play(fadeTime: 0).register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
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
        var dec = Demand.ar(trig, 0, Dseq((0.75!1) ++ (0.5!23) ++ (0.65!8), inf));
        var pit = Demand.ar(trig, 0, Dseq(-12!24 ++ (-24!8), inf));
    var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
    var sig = MiPlaits.ar(
        pitch: 0 + [0, 0, 0, 24] + 24 - [24, 12, 12, 12] + 0 + 12 + pit,
        engine: 3,
        harm: 0.1,
        timbre: 1,
        morph: 0.45 - [0, 0.2, 0, 0],
        trigger: trig * [block0, block1, block1, block2] * trigGate,
        decay: 0.0 + [0.9, 0.6, 0.6, 0.9] * dec * 1.2,
            // timb_mod: 0.5,
        lpg_colour: 0
    );
    var env = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [-8, -8]), gate: [block0, block1]).sum!2;
 var sig2 = [sig[1][1], sig[2][1]] * 1.5;
    sig = [sig[0][1] * 2 + (sig[3][1] * 0.5)]!2 + sig2;
        // env = CombC.kr(env.pow(7), 1, ~nT.beatDur * 0.125 * 0.125 * 0.125, ~nT.beatDur * 0.5);
        env = DelayN.kr(env, 1, ~nT.beatDur * 1.5);
        sig = LPG.ar(
            input: sig * 0.75,
            controlinput: env.clip(0, 1) + Line.kr(1, 0, ~nT.beatDur),
            controloffset: 0.5,
            controlscale: 0.95,
            vca: 0.75,
            resonance: 0,
            lowpassmode: 1,
            linearity: 1
        );
        sig = VadimFilter.ar(sig, 500, 0, 1) * 2 + (sig * 0.25);
    // sig = (sig * 0.75) + HPF.ar(sig, 200);
    // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
    sig = sig * 3.6 * 0.5;
}.play(fadeTime: 0).register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
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
        var dec = Demand.ar(trig, 0, Dseq((0.75!1) ++ (0.5!23) ++ (0.65!8), inf));
        var pit = Demand.ar(trig, 0, Dseq(-12!24 ++ (-24!8), inf));
    var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
    var sig = MiPlaits.ar(
        pitch: 0 + [0, 0, 0, 24] + 24 + [-24, 3, 3, -2 + 12] + 0 + 12 + pit,
        engine: 6,
        harm: 0.1,
        timbre: 1,
        morph: 0.45 - [0, 0.2, 0, 0],
        trigger: trig * [block0, block1, block1, block2] * trigGate,
        decay: 0.0 + [0.9, 0.6, 0.6, 0.9] * dec * 1.2,
            // timb_mod: 0.5,
        lpg_colour: 0
    );
    var env = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [-8, -8]), gate: [block0, block1]).sum!2;
 var sig2 = [sig[1][1], sig[2][1]] * 1.5;
    sig = [sig[0][1] * 2 + (sig[3][1] * 0.5)]!2 + sig2;
        // env = CombC.kr(env.pow(7), 1, ~nT.beatDur * 0.125 * 0.125 * 0.125, ~nT.beatDur * 0.5);
        env = DelayN.kr(env, 1, ~nT.beatDur * 1.5);
        sig = LPG.ar(
            input: sig * 0.75,
            controlinput: env.clip(0, 1) + Line.kr(1, 0, ~nT.beatDur),
            controloffset: 0.5,
            controlscale: 0.95,
            vca: 0.75,
            resonance: 0,
            lowpassmode: 1,
            linearity: 1
        );
        sig = VadimFilter.ar(sig, 500, 0, 1) * 2 + (sig * 0.25);
    // sig = (sig * 0.75) + HPF.ar(sig, 200);
    // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
    sig = sig * 3.6 * 0.5;
}.play(fadeTime: 0).register;
});
)