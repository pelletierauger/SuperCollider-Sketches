b.play;

(
~sli.free;
~sli = {
  var start = LFNoise0.kr(1).range(0,BufDur.ir(b));
    var t = Impulse.kr(0.25);
    var f = Demand.kr(t, 0, Dseq([0, -2, 2, -3].midiratio, inf));
    var dem = Demand.kr(t, 0, Dseq([1, 0.125], inf));
    var env = EnvGen.kr(Env([0, 1, 0.25, 0], [0.75, 0.5, 1], [2, 'lin', 'lin']), t);
var cutoff = 100 + (4000 * env);
    // var po = Demand.kr(t, 0, Dxrand((0..10)/100, inf));
    var po = Demand.kr(t, 0, Dseq([0.25] + 0.0, inf));
    var sig = XPlayBuf.ar(
        2, b, rate: 0.5,
        trigger: t,
        // startPos: 5.259,
        startPos: 1.985,
        loopDur: 6,
        loop:1,
        fadeTime: 0.005
    ) * 0.5;
    //
    // sig = [sig[0][0] + sig[1][1], sig[0][1] + sig[1][0]];
/*    var mod = Amplitude.ar(sig[0] + sig[1]);
    sig = (sig * 0.125 * dem) + VadimFilter.ar(
        input: sig,
        type: 1,
        freq: 100 + (4000 * mod),
        resonance: 2 - (mod * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - mod))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 1;*/
        sig = AnalogPhaser.ar(
        sig,
        SinOsc.ar(0.022 * [1, 1.1]),
        skew: SinOsc.kr(5.59 * [1, 1.1]),
        feedback: SinOsc.kr(0.005 * [1, 1.1], 1pi).range(0.8,0.85),
        modulation: SinOsc.kr(2.0192 * [1, 1.1], 2pi).unipolar,
        // modulation: 0.25,
        stages: 50
    );
    sig * 0.35;
    // MiVerb.ar(sig, drywet: 1, damp: 0.7) * 4;
}.play;
)