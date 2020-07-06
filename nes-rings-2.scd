(
i.free;
i = {
    var sig = Nes2Square.ar(Dust.kr(3), 2, 1, 1, 10, 1, LFNoise0.kr(3, 3.5, 3.5), LFNoise0.kr(3, 0.5, 0.5), LFNoise0.kr(3, 3.5, 3.5), LFNoise0.kr(0.3 * [1, 1.01], 100, 200)) * 0.25;
    MiRings2.ar(sig, pit: 31 + 12 - 5);
}.play
)