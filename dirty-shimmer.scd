~dirtyShimmer = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider-Sketches/dirty-shimmer.wav");


(
~dirt.stop;
~dirt = Pbind(
    \instrument, \sampler,
    \buf, ~dirtyShimmer,
    \dur, 16,
    // \spos, Pseq([0.3509], inf),
    \atk, 0.001,
    \susT, 8,
    \rel, 0.001,
    // \rate, -0.midiratio,
    \amp, 1
).play(~t, quant: [2, -0.06]);
)

s.record;
s.stopRecording;