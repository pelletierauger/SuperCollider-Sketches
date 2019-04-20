(
s.boot;
p = ProxySpace.push(s);
)
playing and monitoring

// play some output to the hardware busses, this could be any audio rate key.
~out.play;
~out.stop;
​
~out = { SinOsc.ar([400, 408] * 0.8, 0, 0.2) };
​
​
// replacing the node. the crossfade envelope is created internally.
~out = { SinOsc.ar([443, 600 - Rand(0,200)], 0, 0.2) };
~out = { Resonz.ar(Saw.ar(40 + [0,0.2], 1), [1200, 1600], 0.1) + SinOsc.ar(60 * [1,1.1],0,0.2) };
~out = { Pan2.ar(PinkNoise.ar(0.1), LFClipNoise.kr(2)) };
setting the node controls

~out = { arg rate = 2; Pan2.ar(PinkNoise.ar(0.1), LFClipNoise.kr(rate)) };
~out.set(\rate, 30);
~out = { arg rate = 2; Pan2.ar(Dust.ar(2000, 0.2), LFClipNoise.kr(rate)) };
~out.set(\rate, 2);


~lfo = { LFNoise2.kr(30, 300, 500) };
~out = { SinOsc.ar(~lfo.kr, 0, 0.15) };
~out = { SinOsc.ar(~lfo.kr * [1, 1.2], 0, 0.1) * Pulse.ar(~lfo.kr * [0.1, 0.125], 0.5) };
~lfo = { LFNoise1.kr(30, 40) + SinOsc.kr(0.1, 0, 200, 500) };
~out = { SinOsc.ar(~lfo.kr * [1, 1.2], 0, 0.1) };
~lfo = 410;