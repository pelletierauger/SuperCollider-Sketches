s.boot;

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
	var sig, mod, lp, sp;
	mod = SinOsc.kr(3);
	sp = abs(SinOsc.kr(0.1)) * 220;
	sig = Impulse.ar(sp, mul: 0.4)!2;
	sig = LPF.ar(sig, freq / 1);
	sig = (sig * 0.85) + Ringz.ar(sig, [freq, freq+1], 3);

	// sig = sig * 1;
	sig = sig * mod;

	Out.ar(0, sig);
}).add;
)

h = Synth.new(\pul, [\freq, 440]);
t = Synth.new(\pul, [\freq, 440 * -5.midiratio]);
Synth.new(\pul, [\freq, 440 * 3.midiratio]);
y = Synth.new(\pul, [\freq, 220]);
y.free;
Synth.new(\pul, [\freq, 770]);
Synth.new(\pul, [\freq, 880]);
t.free;