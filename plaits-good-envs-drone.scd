y.free;
y = { MiRings2.ar(PinkNoise.ar(0.1), pit: 50) * 0.25 * Line.kr(0, 1, 3)}.play;
z = { MiRings2.ar(PinkNoise.ar(0.1), pit: 50 - 24, model:3) * 16.25 * Line.kr(0, 1, 3)}.play;
y = { MiRings2.ar(PinkNoise.ar(0.1), pit: 50 - 12, model:3) * 16.25 * Line.kr(0, 1, 3)}.play;
z.free;
y.free;