// Read a sample file and store it into a Buffer.
~buf = Buffer.read(s, "/Users/guillaumepelletier/Downloads/21055__samulis__vsco-2-ce-keys-upright-piano/374308__samulis__upright-piano-a3-player-dyn2-rr1-018.wav")
~buf = Buffer.read(s, "/Users/guillaumepelletier/Downloads/piano-loop-2-quiet-2.wav");
~buf = Buffer.read(s, "/Users/guillaumepelletier/Music/SuperCollider Recordings/SC_191223_030818.aiff");
~buf = Buffer.read(s, "/Users/guillaumepelletier/Desktop/0002 7-Audio.aif");
~buf.play;
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