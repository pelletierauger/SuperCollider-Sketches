(
play {
    m=Impulse;
    n=1;
    u=Splay.ar(
		{|i|
        i=i+1;
        o=1+ToggleFF.kr(m.kr((i*0.51)/n));
        Ringz.ar(OnePole.ar(m.ar(i/n)),o*444/8,o*4).sin;
    }!n).tanh;
    (u + GVerb.ar(0.5 * u.mean, 11, 11, 0)).sin;
}
)

{|i|i + 1;}!8;

(
SynthDef(\pul, {
	arg freq = 440;
	var sig, mod;
	mod = SinOsc.kr(3);
	sig = Impulse.ar(freq / 440, mul: 0.4)!2;
	sig = Ringz.ar(sig, freq, 3);
	// sig = sig * 1;
	sig = sig * mod + (sig * 0.0625);
	Out.ar(0, sig);
}).add;
)

h = Synth.new(\pul, [\freq, 440]);
t = Synth.new(\pul, [\freq, 330]);
Synth.new(\pul, [\freq, 220]);
y = Synth.new(\pul, [\freq, 660]);
t.free;