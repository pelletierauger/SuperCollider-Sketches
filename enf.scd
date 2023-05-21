-1.midiratio



(
{
    var sig2;
    var t = Impulse.kr(2);
    var d = Demand.kr(t, 0, Dseq([0, -2, -4, -5, -7, -7, -7, -7].midiratio.stutter(2), inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [0, -8]), gate: t);
    var sig = SinOsc.ar(220 * d * [1, 1.01]).sum * e;
    sig = (sig * 1000).softclip(-1, 1);
    sig = sig + CombN.ar(sig, 1, [0.1, 0.1001] * 4, 1);
    sig = AnalogVintageDistortion.ar(sig,
        drivegain: 1, bias: 0.5, lowgain: 0.1, highgain: 0.5,
        shelvingfreq: 600, oversample: 0
    );
    sig = AnalogVintageDistortion.ar(sig,
        drivegain: 1, bias: 0.25, lowgain: 0.1, highgain: 0.5,
        shelvingfreq: 200, oversample: 0
    );
    sig = PitchShift.ar(sig, 0.2, 0.5) * sig * sig;
    // sig = (sig * 1000).softclip(-1, 1);

    sig = sig + CombN.ar(sig, 1, [0.1, 0.1001], 1) * sig;
    // sig = (sig * 1000).softclip(-1, 1);

    sig = AnalogPhaser.ar(
            sig,
            SinOsc.ar(1),
            skew: SinOsc.kr(0.059),
            feedback: SinOsc.kr(0.005, 1pi).range(0.0,0.85),
            modulation: SinOsc.kr(0.92, 2pi).unipolar,
            stages: 50
        );
        sig = AnalogPhaser.ar(
            sig,
            SinOsc.ar(3),
            skew: SinOsc.kr(0.059),
            feedback: SinOsc.kr(0.005, 1pi).range(0.0,0.85),
            modulation: SinOsc.kr(0.92, 2pi).unipolar,
            stages: 50
        );
/*        sig = AnalogVintageDistortion.ar(sig,
        drivegain: 1, bias: 0.25, lowgain: 0.1, highgain: 0.5,
        shelvingfreq: 200, oversample: 0
    );*/
/*    sig = MiClouds.ar(
        inputArray: sig,
        pit: 0,
        pos: 0,
        size: 0,
        dens: 0.1,
        tex: 0.25,
        drywet: 0.5,
        in_gain: 1,
        spread: 0,
        rvb: 0.8,
        fb: 0,
        freeze: 0,
        mode: 1,
        lofi: 0
    );*/
    sig = ~v.(sig, 4000 * e + 200);
/*        sig = AnalogPhaser.ar(
            sig,
            SinOsc.ar(1.111),
            skew: SinOsc.kr(0.059),
            feedback: SinOsc.kr(0.005, 1pi).range(0.0,0.85),
            modulation: SinOsc.kr(0.0192, 2pi).unipolar,
            stages: 50
        );*/
    sig * 0.1;
}.play;
)

AnalogPhaserMod