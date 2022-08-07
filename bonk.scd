
~path = PathName.new("/Users/guillaumepelletier/Desktop/bonk.aiff");

~path.pathOnly.openOS

b = Buffer.read(s, ~path.fullPath);

(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    | freeze = 0 |
        var sig = PlayBuf.ar(2, b, 1, startPos: 0, loop: 1);
    sig + MiRings.ar(sig, 0, 24, struct: 0.25, bright: 0.5, damp: 0.7, pos: 0.25, model: 0) * 0.1;
    // var sig = XPlayBuf.ar(2, b, 0.5, 1, 332950, loop: 1);
}.play;
)