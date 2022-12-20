(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0.5), {
    if(~toms.isPlaying, {~toms.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~toms = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[1] * dd;
        var trig = t;
        var trig2 = t + DelayN.kr(t, 0.5, ~nT.beatDur / 8);
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0];
        var pat2 = [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var hh = Demand.kr(trig * block2, 0, Dseq([0.9, 1.1], inf));
        var scr = Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf));
        var sig = MiPlaits.ar(
            pitch: 27 + [0, 12, 12, 24],
            engine: 9,
            harm: [0.25, 0.4, 0.4, 0.25],
            timbre: [1, 1, 1, 1],
            morph: 0.75 - [0, 0.2, 0, -0.1],
            trigger: (trig!3)++(trig2!1) * [block0, block1, block1, block2] * trigGate,
            decay: [0.9, 0.6, 0.6, hh] * 0.5,
            lpg_colour: [0.75, 0.75, 0.75, 1],
            // fm_mod: -0.5,
            // timb_mod: 0.5
            morph_mod: -1
        ) * dd.lag(0.1);
        // var dd = Demand.kr(trig, 0, Dseq([2, 1].stutter(16), inf));
        var ddd = Demand.kr(trig, 0, Dseq([8000, 5000].stutter(16), inf));
        var v = 1;
        var sig3;
        var sig2 = [sig[1][v], sig[2][v]] * 1.5 * Line.kr(0, 1, ~nT.beatDur * 2);
        sig = [sig[0][v] * 2 + (sig[3][v] * 0.15)]!2 + sig2;
        sig = sig + (~v.(sig, 3000, 0, 5) * 8);
        // sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        // sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        // sig3 = [sig2, sig3] * 0.25;
        // sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500), 0, 5) * 8;
        // sig = sig + (sig3 * Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf)).lag(1));
        sig * 2;
    }.play(fadeTime: 0.01).register;
});
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~x3b2x.set(\trigGate, 0, \gate, 0, \fadeTime, 30.1);
    ~x3b2x = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[1] * dd;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 0.5], [2, -8, 'lin']), t);
        var env2 = EnvGen.kr(Env([0, 1, 0], [0.001, 0.25 * 1], [2, -8, 'lin']), t);
        var d = Demand.kr(t, 0, Dseq([4, 4, 4, 5, 3, 3, 3, 2].stutter(1) - 0, inf));
        var note = Demand.kr(t, 0, Dseq(
            [0, 0, 0, 1, -1, -1, -1, -2].stutter(4), inf));
        // [0, 0, 0, 1, 3, 3, 3, 5, 0, 0, 0, 1, -1, -1, -1, -2].stutter(4), inf));

        var sig = MiBraids.ar(
            pitch: 27 + 24 + 0 + [0, 0.5] + 12 + note,
            timbre: 0.5 + [0.0, 0.1],
            color: 0.5 + (note * 0.2),
            model: 28,
            trig: t,
            resamp: 2,
            decim: \decim.kr(2) + [0, 4],
            bits: 1,
            ws: 0
        ).sum * dd.lag(0.05);
        sig = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
            shelvingfreq: 600, oversample: 0
        ) * 0.5;
        /*        sig = AnalogVintageDistortion.ar(
        input: sig,
        drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
        shelvingfreq: 600, oversample: 0
        ) * 0.25;
        sig = AnalogVintageDistortion.ar(
        input: sig,
        drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.3,
        shelvingfreq: 600, oversample: 0
        ) * 0.75;*/
        sig = ~v.(sig, 100 + (4000 * env) + 3000, 0, 5) * 1;
        // sig = ~v.(sig, 10000) * 4;
        /*        sig = Pan2.ar(sig,
        Demand.kr(t, 0, Dseq([-0.5, 0.5].stutter(1).lag(1), inf))
        ) * 8;*/

        MiRings.ar(sig!2,
            pit: 27+12+note, struct: 0.25, bright: 0.25,
            damp: 0.2, pos: 0.25, model: 2) * 16 * 8 * dd.lag(0.05);
    }.play(fadeTime: 0.05);
});
)


(
if(~toms.isPlaying, {~toms.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
~x3b2x.set(\trigGate, 0, \gate, 0, \fadeTime, 30.1);
~x3b.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
)