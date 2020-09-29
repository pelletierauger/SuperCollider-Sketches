b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/cpp/supercollider-Version-3.9.3/sounds/a11wlk01-44_1.aiff");
b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/sons/slide-0008-propre-b.wav");
b.numChannels
b.play;
(
x.free;
x = {
    var freq, dur;
    freq = 10 * 0.midiratio;
    // dur = SinOsc.kr(0.5).range(0.025,0.05) * 4 / freq;
    dur = 4 / freq;
    TGrains.ar(
        numChannels: 2,
        trigger: Impulse.ar(freq),
        bufnum: b.bufnum,
        rate: 1 * 4.midiratio,
        centerPos: MouseX.kr(0, 0.9, 0) * BufDur.kr(b.bufnum),
        dur: dur,
        pan: 0,
        amp: 2,
        interp: 2
    );
}.play;
)

"/Users/guillaumepelletier/Desktop/sons/slide-0008-propre.wav"