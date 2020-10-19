(
// allocate a buffer for writinig into
s = Server.local;
s.sendMsg("/b_alloc", 0, 48000 * 2);
)

c = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider-Sketches/piano-loop-2-quiet-2-48kh.aiff")

c = Buffer.alloc(s, 48000 * 2, 1);
c;
c.play;
//write into the buffer with a BufWr
d = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider-Sketches/piano-loop-2-quiet-2-48kh.aiff")
~d = d.play;
~d.free;


(
x.free;
x = {
    | rate = 1 |
    var in, imp, dem, rs, bf;
    imp = Impulse.ar(2);
    rs = BufRateScale.ir(c) * rate;
    bf = BufFrames.ir(c);
    dem = Demand.ar(imp, 0, Dwhite(0, bf));
    in = BufRd.ar(2, c, Phasor.ar(imp, rs, dem, bf));
    BufWr.ar(in, d, Phasor.ar(0, rs, 0, bf));
    Line.kr(0, 1, BufDur.ir(c), doneAction: 2);
    0.0; // quiet output
}.play;
)


// ----------------------------------------------------------------------------

d = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider-Sketches/piano-loop-2-quiet-2-48kh.aiff")

~d = d.play;
~d.free;



(
x.free;
x = {
    | rate = 1 |
    var in, trig, rs, bf, spos, mod, freq, dem, dem0;
    rs = BufRateScale.ir(c) * rate;
    bf = BufFrames.ir(c);
    trig = Impulse.ar(4);
    freq = 880 * 0.25;
    dem0 = Demand.ar(trig, 0, Dwhite(0, 1000, inf));
    mod = SinOsc.ar(freq * 2) * dem0;
    dem = Demand.ar(trig, 0, Dseq([0, 2, 4, 7].stutter(4).midiratio, inf)) * 0.5;
    spos = bf * 0.19;
    in = BufRd.ar(2, c, Phasor.ar(trig, rs * dem, spos, bf, spos) + SinOsc.ar(freq, mod % 2pi, dem0 * 0.01));
    // BufWr.ar(in, d, Phasor.ar(0, rs, 0, bf));
    // Line.kr(0, 1, BufDur.ir(c), doneAction: 2);
    // 0.0; // quiet output
    Out.ar(0, in);
}.play;
)


(
x.free;
x = {
    | rate = 1 |
    var in, trig, rs, bf, spos, mod, freq, dem, dem0;
    rs = BufRateScale.ir(c) * rate;
    bf = BufFrames.ir(c);
    trig = Impulse.ar(4);
    freq = 55 * 1;
    dem0 = Demand.ar(trig, 0, Dwhite(10, 100, inf));
    mod = SinOsc.ar(freq * 0.5) * dem0;
    dem = Demand.ar(trig, 0, Dseq([0, 2, 4, 7].stutter(4).midiratio, inf)) * 0.5;
    spos = bf * 0.3;
    in = BufRd.ar(2, c, Phasor.ar(trig, rs * dem, spos, bf, spos) + SinOsc.ar(freq, mod % 2pi, dem0 * 0.1));
    // BufWr.ar(in, d, Phasor.ar(0, rs, 0, bf));
    // Line.kr(0, 1, BufDur.ir(c), doneAction: 2);
    // 0.0; // quiet output
    Out.ar(0, in);
}.play;
)

(
x.free;
x = {
    | rate = 1 |
    var in, rs, bf, mod;
    rs = BufRateScale.ir(c) * rate;
    bf = BufFrames.ir(c);
    mod = SinOsc.ar(110);
    in = BufRd.ar(2, c, Phasor.ar(0, rs, 0, bf) + SinOsc.ar(220, mod, 20));
    BufWr.ar(in, d, Phasor.ar(0, rs, 0, bf));
    Line.kr(0, 1, BufDur.ir(c), doneAction: 2);
    0.0; // quiet output
}.play;
)

// ----------------------------------------------------------------------------


(
x.free;
x = {
    | rate = 1 |
    var in, rs, bf;
    rs = BufRateScale.ir(c) * rate;
    bf = BufFrames.ir(c);
    in = BufRd.ar(2, c, Phasor.ar(0, rs, 0, bf) + SinOsc.ar(220, 0, 20));
    BufWr.ar(in, d, Phasor.ar(0, rs, 0, bf));
    Line.kr(0, 1, BufDur.ir(c), doneAction: 2);
    0.0; // quiet output
}.play;
)

        //


(
y = { arg rate=1;
    var in;
    in = SinOsc.ar(LFNoise1.kr(2, 300, 400), 0, 0.1);
    BufWr.ar(in, c, Phasor.ar(0, BufRateScale.kr(c) * rate, 0, BufFrames.kr(c)));
    0.0 //quiet
}.play;
)

y.free;
//read it with a BufRd
(
x.free;
x = { arg rate=1;
    BufRd.ar(1, c, Phasor.ar(0, BufRateScale.kr(c) * rate, 0, BufFrames.kr(c)))!2;
}.play(s);
)

