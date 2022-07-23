(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    // cross feedback

    ~basse.set(\relGate, 3, \trigGate, 0);
    ~basse = {
        | trigGate = 1, relGate = 0 |
        var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
        var amp = EnvGen.ar(
            envelope: Env([1, 1, 0], [0, 5], ['lin', -8], releaseNode: 1),
            gate: Trig.kr(relGate),
            doneAction: 2
        );
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t = Impulse.kr(~nT.tempo * 2) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2].stutter(8), inf));
        var dd = Demand.kr(t, 0, Dseq([1, 1].stutter(8), inf));
        var ddd = Demand.kr(t, 0, Dseq([0, 0].stutter(8), inf)).lag(0.1);
        var dddd = Demand.kr(t, 0, Dseq([-4, 2].reverse.stutter(1), inf));

        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 4], [-8, dddd]), t).lag(0.1);
        var d5 = Demand.kr(t, 0, Dseq(Dseries(0, 1/2, 16), inf)).lag(0.5);
        var sig = MiOmi.ar(pit: 76 - 12 - 12 + d - 12, fm1: e * 0.125 * d5, xfb: min(e * dd * 0.25, 1)) * 0.4 * e;
        // sig.poll;
        var ssig = Sanitize.ar(sig);

        // sig = Decimator.ar(sig, 4100, 8) * 0.5;
/*                sig = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;
        sig = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;
        sig = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;*/
        var sigH = VadimFilter.ar(ssig, 1400, 0, 5) * 4 * amp;
        // x.poll;
        // y.poll;
        sig = (ssig * 0) + MiRings.ar(sigH * 0.5, pit: 76 - 48 + 12 + d.lag(1), damp: 0.47, struct: 0.51, model: 5) * 4;
        Out.ar(0, sig * 16);
    }.play(fadeTime: 0).register;   // cross feedback
});
)




(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    // cross feedback

    ~basse.set(\relGate, 3, \trigGate, 0);
    ~basse = {
        | trigGate = 1, relGate = 0 |
        var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
        var amp = EnvGen.ar(
            envelope: Env([1, 1, 0], [0, 5], ['lin', -8], releaseNode: 1),
            gate: Trig.kr(relGate),
            doneAction: 2
        );
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t = Impulse.kr(~nT.tempo * 2) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2].stutter(8), inf));
        var dd = Demand.kr(t, 0, Dseq([1, 1].stutter(8), inf));
        var ddd = Demand.kr(t, 0, Dseq([0, 0].stutter(8), inf)).lag(0.1);
        var dddd = Demand.kr(t, 0, Dseq([-4, 2].reverse.stutter(1), inf));

        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 4], [-8, dddd]), t).lag(0.1);
        var d5 = Demand.kr(t, 0, Dseq(Dseries(0, 1/2, 16), inf)).lag(0.5);
        var sig = MiOmi.ar(pit: 76 - 12 - 12 + d - 12, fm1: e * 0.125 * d5, xfb: min(e * dd * 0.25, 1)) * 0.4 * e;
        // sig.poll;
        var ssig = Sanitize.ar(sig);

        // sig = Decimator.ar(sig, 4100, 8) * 0.5;
/*                sig = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;
        sig = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;
        sig = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;*/
        var sigH = VadimFilter.ar(ssig, 1400, 0, 5) * 4 * amp;
        // x.poll;
        // y.poll;
        sig = (ssig * 0) + MiRings.ar(sigH * 0.5, pit: 76 - 48 + 12 + d.lag(1), damp: 0.47, struct: 0.51, pos: 0.5 + (SinOsc.kr(3) * 0.5), bright: 0.2, model: 5) * 4;
        Out.ar(0, sig * 16);
    }.play(fadeTime: 0).register;   // cross feedback
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    // cross feedback

    ~basse.set(\relGate, 3, \trigGate, 0);
    ~basse = {
        | trigGate = 1, relGate = 0 |
        var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
        var amp = EnvGen.ar(
            envelope: Env([1, 1, 0], [0, 5], ['lin', -8], releaseNode: 1),
            gate: Trig.kr(relGate),
            doneAction: 2
        );
        var xfb = LFTri.kr(0.05).range(0.5,1);
        var t = Impulse.kr(~nT.tempo * 2) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2].stutter(8), inf));
        var dd = Demand.kr(t, 0, Dseq([1, 1].stutter(8), inf));
        var ddd = Demand.kr(t, 0, Dseq([0, 0].stutter(8), inf)).lag(0.1);
        var dddd = Demand.kr(t, 0, Dseq([-4, 2].reverse.stutter(1), inf));

        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 4], [-8, dddd]), t).lag(0.1);
        var d5 = Demand.kr(t, 0, Dseq(Dseries(0, 1/2, 16), inf)).lag(0.5);
        var sig = MiOmi.ar(pit: 76 - 12 - 12 + d - 12, fm1: e * 0.125 * d5, xfb: min(e * dd * 0.25, 1)) * 0.4 * e;
        // sig.poll;
        var ssig = Sanitize.ar(sig);

        // sig = Decimator.ar(sig, 4100, 8) * 0.5;
/*                sig = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;
        sig = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;
        sig = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;*/
        var sigH = VadimFilter.ar(ssig, 1400, 0, 5) * 4 * amp;
        // x.poll;
        // y.poll;
        sig = (ssig * 0) + MiRings.ar(sigH * 0.5, pit: 76 - 48 + 12 - 5 + d.lag(1), damp: 0.7, struct: 0.51, pos: 0.5 + (SinOsc.kr(3) * 0.5), bright: 0.2, model: 1) * 4;
        Out.ar(0, sig * 16);
    }.play(fadeTime: 0).register;   // cross feedback
});
)