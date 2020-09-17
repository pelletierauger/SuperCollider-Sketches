// Create buffer and SynthDef
(
// read a whole sound into memory
// b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/p5/Graph-Sequencers-Experiments/Graph-Sequencers-SuperCollider-Croisement/server/public/soundfiles/a11wlk01.wav");
b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/sons/slide-0008-propre.wav");
// make a simple sampler instrument
SynthDef("help-LoopBuf",{
    arg out=0, bufnum=0, rate=1, glide=0, gate=1, loopRel=0, startPos=0, startLoop, endLoop, ipol=2, pan = 0, amp = 1;
    var env, signal;
    rate = Lag.kr(rate, glide);
    env = EnvGen.ar(Env.adsr(0.1,0.2,1,2), gate, doneAction: 2);
    signal = LoopBuf.ar(2, bufnum, BufRateScale.kr(bufnum) * rate, gate+loopRel, startPos, startLoop, endLoop, ipol);
    signal = Balance2.ar(signal[0], signal[1], pan, 1);
    Out.ar(out, signal * env * amp);
}).send(s);
)

// start playback
s.sendMsg("/s_new", "help-LoopBuf", 3000, 1, 0, \bufnum, b.bufnum, \startLoop, 5000, \endLoop, 15000);

s.sendMsg("/n_set", 3000, \rate, -1);    // backwards
s.sendMsg("/n_set", 3000, \rate, 1);    // forwards

s.sendMsg("/n_set", 3000, \startLoop, 11500, \endLoop, 11750, \rate, -24.midiratio) // change loop points
s.sendMsg("/n_set", 3001, \startLoop, 11500, \endLoop, 11749, \rate, -24.midiratio) // change loop points


s.sendMsg("/s_new", "help-LoopBuf", 3000, 1, 0, \bufnum, b.bufnum, \startLoop, 5000, \endLoop, 15000);
s.sendMsg("/s_new", "help-LoopBuf", 3001, 1, 0, \bufnum, b.bufnum, \startLoop, 5000, \endLoop, 15000);

(
var b = 652450;
var d = 12250;
var r = -5.midiratio;
var amp = 1;
s.sendMsg("/n_set", 3000, \startLoop, b, \endLoop, b + d, \rate, r, \amp, amp); // change loop points
s.sendMsg("/n_set", 3001, \startLoop, b, \endLoop, b + d, \rate, r * 0.999, \amp, amp); // change loop points
)


s.sendMsg("/n_set", 3000, \glide, 5) // 5 second glide
s.sendMsg("/n_set", 3000, \rate, 2); // up an octave
s.sendMsg("/n_set", 3000, \rate, -1); // backwards again
s.sendMsg("/n_set", 3000, \rate, 1);    // back to normal

s.sendMsg("/n_set", 3000, \ipol, 1);    // no interpolation
s.sendMsg("/n_set", 3000, \ipol, 2);    // linear interpolation
s.sendMsg("/n_set", 3000, \ipol, 4);    // cubic interpolation

// release gate to hear post-loop
s.sendMsg("/n_set", 3000, \gate, 0);

// release instrument without post-loop
s.sendMsg("/s_new", "help-LoopBuf", 3000, 1, 0, \bufnum, b.bufnum, \startLoop, 11000, \endLoop, 13000);
s.sendMsg("/n_set", 3000, \loopRel, 1, \gate, 0);