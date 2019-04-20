~sigMix = Signal.newClear(513);
(
{
		arg min=0.2, max=1;
		var sig;
		sig = LFDNoise1.kr(
			LFNoise1.kr(8).exprange(min,max)
		).unipolar(1);

		/*
		uncomment this line to control wavetable
		interpolation with horizontal mouse position
		instead of a noise generator
		*/
		//sig = MouseX.kr!2;

		SendReply.kr(Impulse.kr(40), '/mouse', sig);
		0
	}.play();
// s.sync;
	OSCdef(\mouse, {
		arg msg;
    // msg[3].postln;
		/*
		when SendReply sends a value to the language,
		use that value as an interpolation parameter
		and update the wavetables from which the Osc
		UGen is reading
		*/

		//modify values
		~sigMix.waveFill({
			arg x, val, i;
			~interpFn.(~sigB[i], ~sigC[i], msg[3])
		});

		//dynamically update Buffers
    ~b.setn(0, ~sigMix.asWavetableNoWrap);
	}, '/mouse');
)


(
		~sigMix.waveFill({
			arg x, val, i;
			~interpFn.(~sigB[i], ~sigC[i], 0.25)
		});
~b.setn(0, ~sigMix.asWavetableNoWrap);
)

~sigMix.asWavetableNoWrap.size;


(
~interpFn = {
	arg old=20, new=10, bal=0.5;
	old + ((new - old) * bal);
};
)