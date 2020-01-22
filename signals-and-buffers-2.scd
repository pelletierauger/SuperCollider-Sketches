(
a = Signal.newClear(44100 * 5);
a.do({
    |item, i|
    a[i] = sin(i/44100 * 2pi * 440 * -5.midiratio);
    // i.postln;
});
b = Buffer.loadCollection(s, a, 1, {|buf| buf.play});
// b.play;
)

a.plot;
c = Buffer.loadCollection(s, a);
c.play;
b = a.play;

b.play;


// Read a sample file and store it into a Buffer.
~buf = Buffer.read(s, "/Users/guillaumepelletier/Downloads/21055__samulis__vsco-2-ce-keys-upright-piano/374308__samulis__upright-piano-a3-player-dyn2-rr1-018.wav")
~buf = Buffer.read(s, "/Users/guillaumepelletier/Downloads/piano-loop-2-quiet-2.wav");
~buf = Buffer.read(s, "/Users/guillaumepelletier/Music/SuperCollider Recordings/SC_191223_030818.aiff");
~buf = Buffer.read(s, "/Users/guillaumepelletier/Desktop/0002 7-Audio.aif");

// Store the values from the Buffer in a FloatArray called ~fl
~buf.loadToFloatArray(action: { arg array; ~fl = array;});
// Evaluate ~fl and confirm that it is a FloatArray.
~fl;
~fl.size;

// Deinterleave the stereo buffer
~flA = FloatArray.newClear(~fl.size/2);
~flB = FloatArray.newClear(~fl.size/2);
~flA.size / 44100;
(
~flA.size.do({
    |i|
    ~flA[i] = ~fl[i * 2];
});
)
(
~flB.size.do({
    |i|
    ~flB[i] = ~fl[1 + (i * 2)];
});
)
d = Signal.newFrom(~flA);
b = Buffer.loadCollection(s, d, 1, {|buf| buf.play});
b.play;
b.plot;
// ~buf.play;

(
30.do({
var amp = 0;
var zoneSize = 44100 * 3;
var ampInc = 1 / (zoneSize / 2);
var offset = rrand(0, ~flA.size - zoneSize);
var offset2 = rrand(0, ~flA.size - zoneSize);
zoneSize.do({
    |i|
    var loc1 = floor(sin(i * 1e-2 * 0.midiratio) * 10);
    var loc2 = floor(sin(i * 1e-2 * 0.midiratio * 1.001) * 10);
    ~flA[offset + i] = ~flA[offset + i] + (~flA[offset2 + loc2] * amp);
    ~flB[offset + i] = ~flB[offset + i] + (~flB[offset2 + loc1] * amp);
    amp = amp + ampInc;
    if (amp >= 1, {ampInc = ampInc * -1});
});
});
)

(
~flEnd = FloatArray.newClear(~fl.size);
~flA.size.do({
   |i|
   ~flEnd[i * 2] = ~flA[i];
   ~flEnd[1 + (i * 2)] = ~flB[i];
});
)
d = Signal.newFrom(~flEnd);
// b = Buffer.loadCollection(s, d, 2, {|buf| buf.play});
b = Buffer.loadCollection(s, d, 2);
b.play;
b.plot;
b.write("/Users/guillaumepelletier/Downloads/piano-loop-2-quiet-2-glitchy.wav");
({PlayBuf.ar(2, b, 0.midiratio) * 0.5}.play);
44100 / 2
1 / 22050



a.sampleRate
a.getn(31000, 10, {|i| i.postln});

d = Signal.newFrom([0, 2, 3, 4, 5]);
d = Signal.newFrom(a.getn(31000, 10, {|i| i.postln}));
d[0]

f = b.loadToFloatArray(0, -1, {|item| item});
f;
b.loadToFloatArray(action: { arg array; a = array; { a.plot }.defer; "done".postln });
b.numFrames * b.numChannels
~fl[0] = 2;
~fl[0]
~fl2 = ~fl;
~fl2[0]
~fl2 = FloatArray.newFrom(~fl);

~fl2[0];
~fl[0] = 3;
d = Signal.newFrom(~fl);
d.size
f = b.loadToFloatArray(action: { arg array; ~fl = array;});

f