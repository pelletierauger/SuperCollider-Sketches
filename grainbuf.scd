s.boot;

(
var winenv;

b = Buffer.readChannel(s, "/Users/guillaumepelletier/Desktop/sons/0002 7-Audio.aif", channels: [0]);
c = Buffer.readChannel(s, "/Users/guillaumepelletier/Desktop/sons/0002 7-Audio.aif", channels: [1]);

// a custom envelope
winenv = Env([0, 1, 0], [0.5, 4], [8, -8]);
z = Buffer.sendCollection(s, winenv.discretize, 1);

SynthDef(\buf_grain_test, { |out, gate = 1, amp = 1, sndbuf1, sndbuf2, envbuf|
    var sig, sig1, sig2, pan, pos, env, freqdev;
    // use mouse x to control panning
    pan = MouseX.kr(0.1, 0.8);
    env = EnvGen.kr(
        Env([0, 1, 0], [1, 1], \sin, 1),
        gate,
        levelScale: amp,
        doneAction: Done.freeSelf);
    pos = LFNoise2.kr(10).range(0.1, 0.101) + pan;
    sig1 = GrainBuf.ar(1,
        trigger: Impulse.kr(20),
        dur: 0.1,
        sndbuf: sndbuf1,
        rate: 1,
        pos: pos,
        interp: 2,
        pan: [-1, 1],
        envbufnum: envbuf
    );
    sig2 = GrainBuf.ar(1,
        trigger: Impulse.kr(20),
        dur: 0.1,
        sndbuf: sndbuf2,
        rate: 1,
        pos: pos,
        interp: 2,
        pan: [-1, 1],
        envbufnum: envbuf
    );
    sig = [sig1[0], sig2[0]];
    Out.ar(out, sig * env);
}).add;
)

// use built-in env
x = Synth(\buf_grain_test, [\sndbuf1, b, \sndbuf2, c, \envbuf, -1])

// switch to the custom env
x.set(\envbuf, z)

(
var winenv = Env([0, 1, 0], [1, 4], [\linear, \linear]);
z = Buffer.sendCollection(s, winenv.discretize, 1);
x.set(\envbuf, z);
)


x.set(\envbuf, -1);

x.set(\gate, 0);
b.play;