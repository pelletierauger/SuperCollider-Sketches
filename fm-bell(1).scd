// Michael McNabb's fm bell:
// translated from CLM instrument by Fernando Lopez-Lezcano 2007

(
SynthDef (\fmbell, {
	arg dur, freq, amplitude, ampenv, indexenv, index;

	var mod1, mod2, mod3, mod4;
	var fmind1, fmind2, fmind3, fmind4;
	var ampf, indf, out;

	mod1 = SinOsc.ar(freq * 2);
	mod2 = SinOsc.ar(freq * 1.41);
	mod3 = SinOsc.ar(freq * 2.82);
	mod4 = SinOsc.ar(freq * 2.4);

	fmind1 = freq * 32.0;
	fmind2 = 4.0 * (8.0 - (freq / 50.0));
	fmind3 = fmind2 * 0.705 * (1.4 - (freq / 250.0));
	fmind4 = 32.0 * (20 - (freq / 20));

	// (0 1 2 1.1 25 .75 75 .5 100 .2))
	indf = EnvGen.kr(Env.new([1, 1.1, 0.75, 0.5, 0.2], [2, 23, 50, 25],'linear'), 
		levelScale: index, timeScale: dur / 100, doneAction: 2);

	// (0 0 .1 1 10 .6 25 .3 50 .15 90 .1 100 0)
	ampf = EnvGen.kr(Env.new([0, 1, 0.6, 0.3, 0.15, 0.1, 0], [0.1, 9.9, 15, 25, 40, 10],'linear'), 
		levelScale: amplitude, timeScale: dur / 100, doneAction: 2);

	out = ampf * (SinOsc.ar(freq + (mod1 * indf * fmind1))
		+ (0.15 * (SinOsc.ar(freq + (indf * ((mod2 * fmind2) + (mod3 * fmind3))))))
		+ (0.15 * (SinOsc.ar(freq * 2.4 + (indf * fmind4 * mod4)))));

	Out.ar(0, out);
}
).send(s);
)

// examples

Synth(\fmbell, [\dur, 5.000, \freq, 233.046, \amplitude, 0.028, \index, 0.750]).play;
Synth(\fmbell, [\dur, 2.000, \freq, 205.641, \amplitude, 0.019, \index, 0.650]).play;
Synth(\fmbell, [\dur, 5.000, \freq, 207.152, \amplitude, 0.017, \index, 0.750]).play;
Synth(\fmbell, [\dur, 7.000, \freq, 205.641, \amplitude, 0.010, \index, 0.650]).play;
Synth(\fmbell, [\dur, 0.500, \freq, 880, \amplitude, 0.060, \index, 0.500]).play;
Synth(\fmbell, [\dur, 6.500, \freq, 293.66, \amplitude, 0.1, \index, 0.500]).play;
Synth(\fmbell, [\dur, 7.000, \freq, 146.5, \amplitude, 0.1, \index, 1.000]).play;
Synth(\fmbell, [\dur, 6.000, \freq, 110, \amplitude, 0.1, \index, 1.000]).play;
Synth(\fmbell, [\dur, 10.00, \freq, 73.415, \amplitude, 0.028, \index, 0.500]).play;
Synth(\fmbell, [\dur, 4.000, \freq, 698.46, \amplitude, 0.068, \index, 0.500]).play;

