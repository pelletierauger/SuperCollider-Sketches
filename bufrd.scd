(
// read a whole sound into memory
s = Server.local;
// note: not *that* columbia, the first one
b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");
)
b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/sons/slide-0008-propre-b.wav");

//use any AUDIO rate ugen as an index generator

{ BufRd.ar(1, b, SinOsc.ar(0.1) * BufFrames.ir(b)) }.play;
{ BufRd.ar(1, b, LFNoise1.ar(1) * BufFrames.ir(b)) }.play;
{ BufRd.ar(1, b, LFNoise1.ar(10) * BufFrames.ir(b)) }.play;
{ BufRd.ar(1, b, LFTri.ar(0.1) + LFTri.ar(0.23) * BufFrames.ir(b)) }.play;
// original duration
{ BufRd.ar(1, b, LFSaw.ar(BufDur.ir(b).reciprocal).range(0, BufFrames.ir(b)) ) }.play;


//use a phasor index into the file

(
{
    var mod = SinOsc.ar(1).range(0.25, 1) * 10;
    var sta = 2000 + Line.ar(0, 2000, 10, doneAction: 2);
    var dur = 250 * 12.midiratio;
    BufRd.ar(
        numChannels: 1,
        bufnum: b,
        phase: Phasor.ar(0, BufRateScale.kr(b), sta, sta + dur),
        loop: 1,
        interpolation: 2
    )!2 * 32;
}.play;
)


(
{
    var mod = SinOsc.ar(1).range(0.25, 1) * 10;
    var sta = 176000 + 44000;
    var dur = 9000;
    BufRd.ar(
        numChannels: 1,
        bufnum: b,
        phase: Phasor.ar(0, BufRateScale.kr(b), sta, sta + dur),
        loop: 1,
        interpolation: 2
    )!2 * 32;
}.play;
)





//change rate and interpolation
(
x = { arg rate=1, inter=2;
    BufRd.ar(1, b, Phasor.ar(0, BufRateScale.kr(b) * rate, 0, BufFrames.kr(b)), 1, inter)
}.play;
)

x.set(\rate, 0.9);
x.set(\rate, 0.6);
x.set(\inter, 1);
x.set(\inter, 0);


//write into the buffer with a BufWr
(
y = { arg rate=1;
    var in;
    in = SinOsc.ar(LFNoise1.kr(2, 300, 400), 0, 0.1);
    BufWr.ar(in, b, Phasor.ar(0, BufRateScale.kr(b) * rate, 0, BufFrames.kr(b)));
    0.0 //quiet
}.play;
)

//read it with a BufRd
(
x = { arg rate=1;
    BufRd.ar(1, b, Phasor.ar(0, BufRateScale.kr(b) * rate, 0, BufFrames.kr(b)))
}.play;
)



x.set(\rate, 5);
y.set(\rate, 2.0.rand);
x.set(\rate, 2);

b.free