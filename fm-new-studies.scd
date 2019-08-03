
(
{
    var freq = 440 * 3.midiratio;
    var mod0 = SinOsc.ar([0.15, 0.151]).range(10, 20).round;
    var mod = SinOsc.ar([freq + 1, freq] * 4) * SinOsc.ar(freq * 0.25 * mod0).range(100, 500) * Line.kr(0.01, 1, 1);
    var sig = SinOsc.ar([freq, freq + 1] + mod) * 0.1;
    sig;
}.play;
)

FreqScope.new(400, 200, 0, server: s);


(
{
    var freq = 440 * 3.midiratio;
    var mod0 = SinOsc.ar(freq * 0.5) * 400;
    var mod = SinOsc.ar(freq * 2 + mod0) * 4000;
    var car = SinOsc.ar([freq, freq + 1] + mod) * 0.1;
    car;
}.play;
)

PMOsc

// ronronnement
(
{
    var carfreq = 440 * -24.midiratio;
    var modfreq = carfreq * 0.25;
    var modphase = SinOsc.ar(modfreq * 1, 0, 16).range(-1.0, 1.0);
    var pmindex = SinOsc.ar([0.1, 0.15]).range(5, 20);
    var sig = SinOsc.ar([carfreq, carfreq + 1], LFTri.ar(modfreq, modphase, pmindex).range(-1.0, 1.0)) * 0.1;
    // LPF.ar(sig, 900);
    sig;
}.play;
)



(
{
    var carfreq = 440 * -12.midiratio;
    var modfreq = carfreq * 0.25;
    var modphase = SinOsc.ar(modfreq * 0.5, 0, 1).range(-8pi, 8pi) * 0;
    var pmindex = SinOsc.ar([0.1, 0.15]).range(5, 20);
    var sig = SinOsc.ar([carfreq, carfreq + 1], SinOsc.ar(modfreq, modphase, pmindex).range(-8pi, 8pi)) * 0.1;
    // LPF.ar(sig, 900);
    sig;
}.play;
)

PMOsc  {

	*ar { arg carfreq,modfreq,pmindex=0.0,modphase=0.0,mul=1.0,add=0.0;
		^SinOsc.ar(carfreq, SinOsc.ar(modfreq, modphase, pmindex),mul,add)
	}

	*kr { arg carfreq,modfreq,pmindex=0.0,modphase=0.0,mul=1.0,add=0.0;
		^SinOsc.kr(carfreq, SinOsc.kr(modfreq, modphase, pmindex),mul,add)
	}

}
