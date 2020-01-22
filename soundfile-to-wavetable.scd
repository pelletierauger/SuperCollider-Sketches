f = SoundFile.openRead("/Users/guillaumepelletier/Desktop/0002 7-Audio.aif");


a = FloatArray.newClear(f.numFrames);
f.readData(a);
f.close; // close the file
a.size; // 169 in my file

// resamp the table to have a pow of 2 (bigger to avoid aliassing)
// if u read many diff samples choose a bigger pow of 2
a = a.resamp1(1024);

a = a.as(Signal);
a.size; // 256 ok

// Convert it to a Wavetable
a = a.asWavetable;
a.size; // 512 ok, (wavetable format is signal.size * 2


b = Buffer.loadCollection(s, a);
x = b.play(loop: true); // ok sounds
e = Env([1.0, 0.0], [0.5]);
g = EnvGen.ar(e, doneAction: 2);
x = { Osc.ar(b, 65.midicps, 5.6.mod(2pi), 0.3) }.play;
x.free;


(
x = play({
    Shaper.ar(
      b!2,
		SinOsc.ar(55, 0, Line.kr(0,1,1)),
      0.5
    )
});
)