Onsets


~path = PathName.new("/Users/guillaumepelletier/Desktop/sacred-drums.aiff");

~path.pathOnly.openOS

c = Buffer.read(s, ~path.fullPath);
b.sample
b = Buffer.alloc(s, 512, 2);

(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    | freeze = 0 |
        var sig = PlayBuf.ar(2, c, 1, startPos: 14400 * 20, loop: 1);
    var chain = FFT(b, sig);
    var trig = Onsets.kr(chain, MouseX.kr(0,1), \rcomplex);
    MiRings.ar(in: sig * 16, trig: 0, pit: 24 + 12,
        struct: 0.25, bright: 0.5, damp: 0.7, pos: 0.25, model: 0,
        // intern_exciter: 1,
    ) * 1 + MiRings.ar(in: sig * 16, trig: trig, pit: 24 + 0,
        struct: 0.25, bright: 0.5, damp: 0.4, pos: 0.25, model: 1,
         intern_exciter: 1,
    ) * 1;
    // var sig = XPlayBuf.ar(2, b, 0.5, 1, 332950, loop: 1);
}.play;
)