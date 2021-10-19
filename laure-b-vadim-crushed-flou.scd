~nT = TempoClock.new(1.39 * 1.25).permanent_(true);
~nT.tempo = 1.39;
~nT.tempo = 1.39 * 2.5;
2.5 / 2

// ----------------------------------------------------------------------
// Version stéréo, bien meilleure
// ----------------------------------------------------------------------

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    if(~snare.isPlaying, {~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
    ~snare = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 1);
        var pat0 = [1, 0, 0, 0, 0, 1, 0, 0];
        var pat1 = [0, 0, 1, 0, 0, 0, 1, 1];
        var pat2 = [1];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig, 0, Dseq(pat2, inf));
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var sig = MiPlaits.ar(
            pitch: 30 + [ 0, 12, 12, 36 ],
            engine: 9,
            harm: 0.25,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0, 0],
            trigger: trig * [block0, block1, block1, block2] * trigGate,
            decay: [0.9, 0.6, 0.6, 0.7] * 0.85,
            lpg_colour: 0
        );
        var dd = Demand.kr(trig, 0, Dseq([2, 1].stutter(16), inf));
        var ddd = Demand.kr(trig, 0, Dseq([8000, 5000].stutter(16), inf));
        var sig2 = [sig[1][1], sig[2][1]] * 1.5;
        sig = [sig[0][1] * 2 + (sig[3][1] * 0.25)]!2 + sig2;
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = VadimFilter.ar(sig, 2500, 0.5, 1);
        sig = Decimator.ar(sig, 1100 * dd, 12) * 0.5;
        sig = VadimFilter.ar(sig, ddd, 0.25, 1) * 2;
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 3.6 * 1;
    }.play(fadeTime: 0.01).register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    if(~synthLine.isPlaying, {~synthLine.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
    ~synthLine = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.25) * trigGate;
        var note = Demand.kr(t, 0, Dseq([4, 4] * 32, inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * note], [2, -8, 'lin']), t);

        var note2 = Demand.kr(t, 0, Dseq([0, -3, -2, -5], inf));
        var sig = MiBraids.ar(
            pitch: 60 - 5 - 12 - 7 + note2,
            timbre: 0.89,
            color: [0.1, 0.11],
            model: 43,
            // trig: t,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        ) * env;
        var lfo = SinOsc.kr(0.1).unipolar * 400;
        sig = VadimFilter.ar(sig, 1000 + lfo, 0.25, 1);
        sig * 0.125 * 3;
    }.play.register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

    x.set(\gate, 0, \fadeTime, 0.1);
    x = {
        // var cutoff = SinOsc.kr(1).range(4000, 2000);
        var t = Impulse.kr(~nT.tempo * 0.25);
        var env = EnvGen.kr(Env([0, 1, 0.5, 0], [0.5, 0.2, 4 - 0.2], [2, 'lin', 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([0, -2, -5, -4].stutter(2), inf));
        var in = MiBraids.ar(60 + -24 + note.lag(0.2), timbre: 0.845, color: 0.1, model: 43);
        var    cutoff = 100 + (1000 * env);
        var sig = VadimFilter.ar(
            input: in,
            type: 1,
            freq: cutoff,
            resonance: (2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))) * 0.25
            //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
        ) * 2 * 0.35;
        sig;
/*        sig = sig + (VadimFilter.ar(
            input: in,
            type: 5,
            freq: cutoff + 5000,
            resonance: (2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))) * 0.25
            //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
        ) * 2 * 0.25 * 0.25 * 0.5 * (0.2 + (env * 0.8)));*/
        // sig = sig + (MiRings.ar(sig, pit: 60 - 12) * 0.5);
        // LPF.ar(in, cutoff)!2;
    }.play;
});
)

s.record;
s.stopRecording;

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~rim.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~rim = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * 2);
        var pat0 = [1, 0, 0, 0, 0, 1, 0, 0];
        var pat1 = [0, 0, 1, 0, 0, 0, 1, 1];
        var pat2 = [1];
        var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
        var dec = Demand.ar(trig, 0, Dseq(0!24 ++ (0.75!8), inf));
        var pit = Demand.ar(trig, 0, Dseq(0!24 ++ (-24!8), inf));
        var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var sig = MiPlaits.ar(
            pitch: 30 + [0, 0, 0, 24] + 0 - [24, 12, 12, 12] + 24 + 12 + pit,
            engine: 9,
            harm: 0.95,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0, 0],
            trigger: trig * [block0, block1, block1, block2] * trigGate,
            decay: 0.0 + [0.9, 0.6, 0.6, 0.7] * dec,
            lpg_colour: 0
        );
        var sig2 = [sig[1][1], sig[2][1]] * 1.5;
        sig = [sig[0][1] * 2 + (sig[3][1] * 0.25)]!2 + sig2;
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 3.6;
        sig = sig * 1 + (CombC.ar(in: sig,
            maxdelaytime: 0.5,
            delaytime: ~nT.tempo * [0.125, 0.126] * 0.125,
            decaytime: 1,
            mul: 1, add: 0) * 0.125 * 0) * 0.25;

        // sig = Decimator.ar(sig, 1100 * 1, 12) * 0.5;
        // sig = VadimFilter.ar(sig, 5000, 0.25, 1) * 2;
    }.play(fadeTime: 0.01).register;
});
)

(
if(~snare.isPlaying, {~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
~rim.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
x.set(\gate, 0, \fadeTime, 0.1);
    [~billes0, ~billes1].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});
    ~lushZ.set(\pulseGate, 0, \gate, 0, \fadeTime, 0.1);
    if(~synthLine.isPlaying, {~synthLine.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});

)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

    var f = 0;
    [~billes0, ~billes1].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

    ~billes0 = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * 2) * trigGate;
        var sig = MiPlaits.ar(62 + f + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.75, 0.95),
            trigger: trig,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        VadimFilter.ar(sig, 7000, 0.25, 5) * 0.8 * 0.8 * 8;
    }.play.register;

    ~billes1 = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * 4) * trigGate;
        var sig = MiPlaits.ar(59 + f + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.75, 0.95),
            trigger: trig,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        VadimFilter.ar(sig, 7000, 0.25, 5) * 0.8 * 0.8 * 8;
    }.play.register;
});
)