x.free;
(
x.free;
x = {
    var sig = Nes2Noise.ar(Dust.kr(100), 0, 0, LFNoise0.kr(1, 3.5, 3.5), LFNoise0.kr(3, 0.5, 0.5), LFNoise0.kr(3, 3, 4), LFNoise0.kr(0.3, 15.5, 15.5)).dup * 0.2;
    LPF.ar(sig, 1400) * 4;
    // sig;
}.play;
)