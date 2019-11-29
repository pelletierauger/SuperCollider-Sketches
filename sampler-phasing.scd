// Create buffer and SynthDef
(
// read a whole sound into memory
b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/p5/Graph-Sequencers-Experiments/Graph-Sequencers-SuperCollider-Croisement/server/public/soundfiles/a11wlk01.wav");

// make a simple sampler instrument
SynthDef("help-LoopBuf",{
    arg out=0, bufnum=0, rate=1, glide=0, gate=1, loopRel=0, startPos=0, startLoop, endLoop, ipol=2;
    var env, signal, offset;
    rate = Lag.kr(rate, glide);
    env = EnvGen.ar(Env.adsr(0.1,0.2,1,2), gate, doneAction: 2);
    offset = floor(SinOsc.ar(0.01).range(0, 100));
    signal = LoopBuf.ar(1,bufnum, BufRateScale.kr(bufnum) * rate * [1, 1.001], gate+loopRel, startPos, startLoop + offset, endLoop, ipol);
    Out.ar(out, signal * env);
}).send(s);
)

// start playback
s.sendMsg("/s_new", "help-LoopBuf", 3000, 1, 0, \bufnum, b.bufnum, \startLoop, 5000, \endLoop, 15000);

s.sendMsg("/n_set", 3000, \rate, -1);    // backwards
s.sendMsg("/n_set", 3000, \rate, 1);    // forwards

s.sendMsg("/n_set", 3000, \startLoop, 12800, \endLoop, 13250, \rate, -8.midiratio) // change loop points


(
var off = 9000;
s.sendMsg("/n_set", 3000, \startLoop, 10600 + off, \endLoop, 11250 + off, \rate, -8.midiratio) // change loop points
)


s.sendMsg("/n_set", 3000, \glide, 0) // 5 second glide
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