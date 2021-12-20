(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    y.set(\gate, 0, \fadeTime, 0.1);

    if(~drums.isPlaying, {~drums.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums = {
        | trigGate = 1 |
                var tempo = ~nT.tempo * 2;
        var basePulse = Impulse.kr(tempo) * trigGate;
        var swing = [0.5, 1.5];
        var swungTempo = Demand.kr(basePulse, 0, Dseq(swing * tempo, inf));
        var trig = Impulse.kr(swungTempo) * trigGate;
        var trig2 = Impulse.kr(swungTempo * 2) * trigGate;


        // var trig = Impulse.kr(~nT.tempo * 2) * trigGate;
        // var trig2 = Impulse.kr(~nT.tempo * 4) * trigGate;
        var a = Demand.kr(trig, 0, Dseq([0, 0, 0, 1].stutter(16), inf));
        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, a, 0, 0, 0, 0, 0] ++ [0, 0, 1, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, a, a] ++ [0, 0, 0, 0, 1, 1, 0, 0];
        var pat2 = [1, 0, 1, 0].wrapExtend(32 - 4) ++ [1, 1, 1, 1];
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8], inf));
        var sig = MiPlaits.ar(
            pitch: 28 + [0, 12, 12, 36 + 24] + 12,
            engine: 9,
            harm: 0.25,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0.1, 0.4] - 0,
            trigger: [block0, block1, block1, block2],
            decay: [0.9, 0.9, 0.9, dec] * 0.75,
            lpg_colour: 0
        );
        var kickhat = sig[0][1] * 8 + (sig[3][1] * 0.35);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 3 * snareFix;
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 1100, 8) * 0.5;
        sig = VadimFilter.ar(sig, 4000, 0, 1) * 0.125;
    }.play(fadeTime: 0.01).register;
});
)
