s.boot;

p = ProxySpace.new;
p.fadeTime = 4; // fadeTime specifies crossfade
p[\out].play; // monitor an empty placeholder through hardware output
// set its source
p[\out] = { SinOsc.ar([350, 351.3], 0, 0.2) };
p[\out] = { Pulse.ar([350, 351.3] / 4, 0.4) * 0.2 };
p[\out] = Pbind(\dur, 0.03, \freq, Pbrown(0, 1, 0.1, inf).linexp(0, 1, 200, 350));

// route one proxy through another:
p[\out] = { Ringz.ar(p[\in].ar, [350, 351.3] * 8, 0.2) * 4 };
p[\in] = { Impulse.ar([5, 7]/2, [0, 0.5]) };

p.clear(3); // clear after 3 seconds

p;
p.fadeTime = 2;

p[\mine].play;
p[\mine] = { LFTri.ar([369.99, 370] * -2.midiratio, 0, 0.2 * p[\osc]) * p[\modulator] };
p[\mine] = { SinOsc.ar([220, 220.1] * 5.midiratio, 0, 0.2 * p[\osc]) };
p[\modulator] = { LFTri.ar([369.99, 370] * 12.midiratio * SinOsc.ar(0.1, add: 1, mul: 0.1), 0.2) };

p[\modulator] = { LFTri.ar([369.99, 370] * -2.midiratio * 0.9999, 0.2) };

p[\mine] = { SinOsc.ar([220, 220.1] * 5.midiratio, 0, 0.2) };
p[\mine].stop;

p[\osc].play;
p[\osc].stop;
(
p[\osc] = {
    var freq = 24 * 1.75 * 3;
    // freq = 3;
    // freq = SinOsc.kr(0.1, 1, 0.5);
    LFTri.ar([freq, freq + 0.1], 0, 1)
};
p[\osc2] = {
    var freq = 24 * 1.75 * 1;
    // freq = 3;
    // freq = SinOsc.kr(0.1, 1, 0.5);
    SinOsc.ar([freq, freq + 0.1], 0, 1)
};
)
p[\mine2].play;
p[\mine2] = { SinOsc.ar([220, 220.1] * 5.midiratio, 0, 0.2 * p[\osc2]) };

p[\osc].set(\freq, 24 * 1.75 * 3);

currentEnvironment;
topEnvironment === currentEnvironment;

e = Environment.make( {~def = 2});

e.push;
e.pop;

~abc = 10;
~abc;
~def;


(
a = Environment.make({
    ~a = 100;
    ~b = 200;
    ~c = 300;
});
a.postln;
)
a;

(
var f = 10;
f.postln;
)

f;
