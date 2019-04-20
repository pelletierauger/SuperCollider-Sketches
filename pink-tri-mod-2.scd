(
SynthDef.new(\pink, {
    arg freq = 220, mod = 0.1;
    var sig1, sig2, lfo, lfo2, env;
    env = XLine.kr(0.5, 0.001, 3, 1, 0, 2);
    lfo = SinOsc.kr(mod);
    lfo2 = SinOsc.kr(ExpRand(20,800), mul: 0.75, add:1);
    env = env * lfo;
    sig1 = PinkNoise.ar(mul: 0.2);
    sig2 = PinkNoise.ar(mul: 0.2);
    sig1 = Ringz.ar(sig1, freq, 15, 0.2) * env;
    sig2 = Ringz.ar(sig2, freq + 1, 15, 0.2) * env;
    Out.ar(0, sig1);
    Out.ar(1, sig2);
}).add;
)

(
SynthDef.new(\triangle, {
    arg freq = 220, mod = 0.1;
    var sig1, sig2, lfo, lfo2, env;
    env = XLine.kr(0.5, 0.001, 3, 1, 0, 2);
    lfo = SinOsc.kr(mod);
    lfo2 = SinOsc.kr(ExpRand(20,800), mul: 0.75, add:1);
    env = env * lfo;
    sig1 = LFTri.ar((freq + 1)) * env;
    sig2 = LFTri.ar(freq) * env;
    sig1 = FreeVerb.ar(sig1, mix: 0.3, room: 0.95, damp: 0.15);
    sig2 = FreeVerb.ar(sig2, mix: 0.3, room: 0.95, damp: 0.15);
    Out.ar(0, sig1);
    Out.ar(1, sig2);
}).add;
)


(
OSCdef.new(
    \fromnode,
    {
        arg msg, time, addr, port;
        d = Synth.new(\pink, [
			\freq, msg[1] * [1,2,4].choose,
			\mod, [0.1,1,3].choose
		]);
        d = Synth.new(\triangle, [
			\freq, msg[1] * [0.5,1,2].choose,
			\mod, [0.1,1,3].choose
		]);
    },
    '/hello/from/oscjs'
);
)