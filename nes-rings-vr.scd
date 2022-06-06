(
i.free;
i = {
    var x = MouseX.kr(0, 1);
    var y = MouseY.kr(0, 1);
    var sig = Nes2Square.ar(Dust.kr(1), 2, 1, 1, 10, 1, LFNoise0.kr(3, 3.5, 3.5), LFNoise0.kr(3, 0.5, 0.5), LFNoise0.kr(3, 3.5, 3.5), LFNoise0.kr(0.3 * [1], 100, 200)) * 0.25!2;
    MiRings.ar(sig, pit: 31 + 12 - 5 - 12, struct: x, bright: 0.5, damp: 0.7, pos: y, model: 1) * 0.5;
}.play
)