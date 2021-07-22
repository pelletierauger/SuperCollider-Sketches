p = ProxySpace.new.push;
p.gui;
p.pop;
Environment.pop;
~out = {Limiter.ar(\in.ar(0), 0.98).dup};

~impulse = {| t_trig | Trig1.ar(t_trig, SampleDur.ir)};

~impulse <>> ~out;

// play the instrument on demand
(
Button(nil, Rect(800, 200, 100, 30))
.front
.state_([["click"]])
.action_((~impulse.set(\t_trig, 1)));
)

// 1 pulse per second
~impulse = {Impulse.ar(1)};

// convolution
// the piano note is fairly long (loading about 2 seconds here)
// so we'll use 'partitioned convolution'
// setup takes 3 steps
(
fork {
    b = Buffer.readChannel(s, "/Users/guillaumepelletier/Desktop/Dropbox/La beauté de 2020/sons/slide-0008.wav"
, numFrames: 131072, channels: [1]);
    s.sync;
    c = Buffer.alloc(s, PartConv.calcBufSize(1024, b), 1);
    s.sync;
    c.preparePartConv(b, 1024);
};
)
// but the convolution unit is easy to use
(
~convolver = {
    var trig = \in.ar(0);
    PartConv.ar(trig, 1024, c);
};
)

// patch the convolver to the output
~impulse <>> ~convolver <>> ~out;

// each pulse = one note!
~impulse = {Impulse.ar(3)};

// impulse varies by mouse
(
~impulse = {
    var freq = MouseX.kr(1, 800, 1);
    SendReply.kr(Impulse.kr(10), '/freq', freq);
    Impulse.ar(freq)
};
)
