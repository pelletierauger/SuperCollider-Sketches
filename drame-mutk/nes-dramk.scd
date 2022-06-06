(
i.free;
i = {
    var x = MouseX.kr(0, 1);
    var y = MouseY.kr(0, 1);
    var sig = Nes2Square.ar(Dust.kr(1), 2, 1, 1, 10, 1, LFNoise0.kr(3, 3.5, 3.5), LFNoise0.kr(3, 0.5, 0.5), LFNoise0.kr(3, 3.5, 3.5), LFNoise0.kr(0.3 * [1], 100, 200)) * 0.25!2;
    MiRings.ar(sig, pit: 31 + 12 - 5 - 12, struct: x, bright: 0.5, damp: 0.7, pos: y, model: 1) * 0.5;
}.play
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4) - 0.0, {
~nesNoi.set(\trigGate, 0, \gate, 0, \fadeTime, 10);
~nesNoi = {
        | trigGate = 1 |
            var x = MouseX.kr(0, 1);
    var y = MouseY.kr(0, 1);
    var sig = Nes2Noise.ar(Impulse.kr(~nT.tempo * 4) * trigGate, 0, 0, LFNoise0.kr(1, 3.5, 3.5), LFNoise0.kr(3, 0.5, 0.5), LFNoise0.kr(3, 3, 4), LFNoise0.kr(0.3, 15.5, 15.5)).dup * 0.2;
        // LPF.ar(sig, 1400) * 4;
    // sig;
            MiRings.ar(sig, pit: 31 + 12 - 5 - 12, struct: x, bright: 0.5, damp: 0.2, pos: y, model: 0) * 2;

}.play;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4) - 0.0, {
~nesNoi2.set(\trigGate, 0, \gate, 0, \fadeTime, 10);
~nesNoi2 = {
        | trigGate = 1 |
            var x = MouseX.kr(0, 1);
    var y = MouseY.kr(0, 1);
    var sig = Nes2Square.ar(Impulse.kr(~nT.tempo * 4) * trigGate, 2, 1, 1, 10, 1, LFNoise0.kr(3, 3.5, 3.5), LFNoise0.kr(3, 0.5, 0.5), LFNoise0.kr(3, 3.5, 3.5), LFNoise0.kr(0.3 * [1], 100, 200)) * 0.25!2;
        // LPF.ar(sig, 1400) * 4;
    // sig;
            MiRings.ar(sig, pit: 31 + 12 - 5 - 12, struct: x, bright: 0.5, damp: 0.2, pos: y, model: 0) * 2;

}.play;
});
)