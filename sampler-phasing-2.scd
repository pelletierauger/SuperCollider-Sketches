(
var off = 169000 + 37000;
s.sendMsg("/n_set", 3000, \startLoop, 10600 + off, \endLoop, 14150 + off, \rate, -8.midiratio) // change loop points
)


(
// read a whole sound into memory
// b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/p5/Graph-Sequencers-Experiments/Graph-Sequencers-SuperCollider-Croisement/server/public/soundfiles/a11wlk01.wav");

// make a simple sampler instrument
SynthDef("help-LoopBuf-2",{
    arg out=0, bufnum=0, rate=1, glide=0, gate=1, loopRel=0, startPos=0, startLoop, endLoop, ipol=2;
    var env, signal, offset;
    rate = Lag.kr(rate, glide);
    env = EnvGen.ar(Env.adsr(0.1,0.2,1,2), gate, doneAction: 2);
    offset = floor(SinOsc.ar(0.01).range(0, 100));
    signal = LoopBuf.ar(2, bufnum, BufRateScale.kr(bufnum) * rate * [1, 1.001], gate+loopRel, startPos, startLoop + 0, endLoop, ipol);
    Out.ar(out, signal * env);
}).send(s);
)


s.sendMsg("/s_new", "help-LoopBuf-2", 3000, 1, 0, \bufnum, ~guitare.bufnum, \startLoop, 5000, \endLoop, 15000);


~guitare.bufnum