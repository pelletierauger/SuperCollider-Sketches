~nT = TempoClock.new(1.39 * 1.35).permanent_(true);
~nT.tempo = 1.39;
~nT.tempo = 1.39 * 3.5;


Safety(s).disable;
Safety(s).enabled;
s.queryAllNodes; // gone
CmdPeriod.run; // -> no post after  cmd-.

// enable again
Safety(s).enable;  // posts Safety... again
Safety(s).enabled;

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    if(~snare.isPlaying, {~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 4)});
    ~snare = {

        | trigGate = 1 |
                var tempo = ~nT.tempo;
        var basePulse = Impulse.kr(tempo) * trigGate;
        var swing = [0.75, 1.25];
        // var swing = [2, 4] / 3;
        var swungTempo = Demand.kr(basePulse, 0, Dseq(swing * tempo, inf));
        var swungPulse = Impulse.kr(swungTempo) * trigGate;

        // var swungPulse = Impulse.kr(~nT.tempo * 1);
        var pat0 = [1, 0, 0, 1, 0, 1, 0, 0];
        var pat1 = [0, 0, 1, 0, 0, 0, 1, 0] ++ [0, 0, 1, 0, 0, 1, 0, 0];
        var pat2 = [1];
        var block0 = Demand.kr(swungPulse, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(swungPulse, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(swungPulse, 0, Dseq(pat2, inf));
        var dm = Demand.kr(swungPulse * block2, 0, Dseq([0.7, 0.6], inf));
        var sig = MiPlaits.ar(
            pitch: 30 + [0, 12, 12, 36] + 12,
            engine: 9,

            harm: 0.75,
            timbre: [0.5, 0.5, 0.5, 0.25]  + 0.3,
            morph: 0.5 - [0, 0.2, 0, 0],
            trigger: swungPulse * [block0, block1, block1, block2].rotate(0) * trigGate,
            decay: [0.9, 0.85, 0.85, 0.7] * 0.5,
            lpg_colour: 0
        );
        var dd = Demand.kr(swungPulse, 0, Dseq([2, 1].stutter(16), inf));
        var ddd = Demand.kr(swungPulse, 0, Dseq([8000, 5000].stutter(16), inf));
        var sig2 = DelayN.ar([sig[1][1], sig[2][1]], 0.1, 0.01) * 1.5;
        sig = [sig[0][1] * 2 + (sig[3][1] * 0.125)]!2 + sig2;
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = VadimFilter.ar(sig, 2500, 0.5, 1);
        // sig = Decimator.ar(sig, 1100 * dd, 8) * 0.5;
        sig = VadimFilter.ar(sig, 7000, 0, 1) * 0.25;
        // sig.unipolar.poll;
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 1.44;
        // Amplitude.ar(sig).poll;
        sig;
    }.play(fadeTime: 0.01).register;
});
)