Quarks.gui


b = Buffer.read(s,"/Users/guillaumepelletier/Desktop/Dropbox/Art/p5/Graph-Sequencers-Experiments/Graph-Sequencers-SuperCollider-Simpler/server/public/soundfiles/a11wlk01.wav")



(

{

	var in = PlayBuf.ar(1,b);

	var out = in + Fb({

		arg feedback; // this will contain the delayed output from the Fb unit



		// filter and distort the feedback signal.

		// Note that the input signal is fed in here as well:

		BPF.ar(feedback * 1.1 + in, 2000, 3.8).distort;

		// for fun effects, try changing the 0.8 to something greater than one



	}, 0.6);

	DetectSilence.ar(out,doneAction:2);

	out!2;

}.play;

)


(

{

	var sig = Impulse.ar(0)!2; // stereo input - feedback will expand to two channels

	var freq = 200;

	sig = FbL({arg fb; LPF.ar(LeakDC.ar(fb),8000)*0.99+sig;},1/freq);

	DetectSilence.ar(sig,doneAction:2);

	sig;

}.play

)


(
{
	var sig = Impulse.ar(0);
    sig = FbL({arg fb; LPF.ar(LeakDC.ar(fb),[8009, 8000])*[0.995, 0.99] +sig;},1/25);
    sig = FbL({arg fb; LPF.ar(LeakDC.ar(fb),[7991, 8000])*[0.99, 0.91]+sig;},1/100);
	sig = FbL({arg fb; LPF.ar(LeakDC.ar(fb),8000)*0.99+sig;},1/400);
	DetectSilence.ar(sig,doneAction:2);
	sig;
}.play;
)



(
{
	var sig = Decay.kr(Impulse.kr(1/2),0.6)*PinkNoise.ar(1!2);
	sig = FbL({
		arg fb1;
		sig = sig + FbL({
			arg fb2;
			(OnePole.ar(LeakDC.ar(0-fb2),0.2)*0.99*1)+(fb1*9) / 10;
		},1/250);
		OnePole.ar(sig,-0.01);
	},0.1);
	sig;
}.play;
)