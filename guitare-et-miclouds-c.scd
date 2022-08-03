
~path = PathName.new("/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/SuperCollider/Signes-Vitaux-3, Fichiers inutilisés/slide-guitar.aif");
~path = PathName.new("/Users/guillaumepelletier/Desktop/scorda.aiff");
~path.pathOnly.openOS

b = Buffer.read(s, ~path.fullPath);

(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    | freeze = 0 |
        var sig = PlayBuf.ar(2, b, 1, startPos: 0, loop: 1);
    // var sig = XPlayBuf.ar(2, b, 0.5, 1, 332950, loop: 1);
    // sig.size.poll;
    //     var dens = LFNoise1.kr(0.3).range(0.3, 0.45);
    // sig = VadimFilter.ar(sig, 12000, 0, 1);
    // sig = sig[0];
    var verb = MiClouds.ar(
        inputArray: sig,
        pit: 0,
        pos: 0,
        size: 0.5,
        dens: 0.0,
        tex: 0.5,
        drywet: 1,
        in_gain: 1,
        spread: 1,
        rvb: 1,
        fb: 0.75,
        freeze: freeze,
        mode: 1,
        lofi: 0
    );
    verb = VadimFilter.ar(verb, 2000, 0, 1);
    verb = VadimFilter.ar(verb, 100, 0, 5) * 1.5;
    sig + verb;
    // MiVerb.ar(sig);
    // sig.size.poll;
    // sig * 0.5;
}.play;
)




~nT = TempoClock.new(1.6).permanent_(true);
~nT.tempo = 1.6;
~nT.tempo = 1.8;
~nT.tempo = 1.39;
~nT.tempo;
~cb = Bus.control(s, 2);
Safety(s).disable;
(
SynthDef.new(\tick, {
    arg beat, subd;
    var sig = Impulse.kr(0.01);
    Line.kr(0, 1, 0.1, doneAction: 2);
    Out.kr(~cb, sig * [beat, subd]);
}).add;
)

(
~ticks.stop;
~ticks = Pbind(
    \instrument, \tick,
    \dur, 0.25,
    \beat, Pseq([1, 0, 0, 0], inf),
    \subd, Pseq([1, 1, 1, 1], inf)
).play(~nT, quant: 4);
)



~hearCB.free;
~hearCB = {HPF.ar(K2A.ar(In.kr(~cb, 2)), 7000) * 4}.play;




(
[~noLowB].do({|i| i.set(\gate, 0, \fadeTime, 1)});
~noLowB = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var trig = tr[0] * dd;
    var block = Demand.kr(trig, 0, Dseq([1] ++ (0!7), inf));
    var notes = Demand.kr(trig, 0,
        Dseq(32 + [0] + 0, inf)
    );
    var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
    var dem2 = Demand.kr(trig * block, 0, Dseq([0, 0], inf));
    var pitch = Demand.kr(trig * block, 0, Dseq([0, -5].stutter(2), inf));
    var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
    var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
    var lfo3 = SinOsc.kr(1).range(0, 2000);
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
    var sig = MiBraids.ar(
        pitch: 24 + 7 - 12 + 7 + pitch - 2 - 3,
        timbre: 0.25,
        color: 0.0 + [0, 0.01],
        model: 0,
        resamp: 2,
        decim: 32,
        bits: 16,
        ws: 0
    );
    sig = sig * 0.6;
    sig = MiRings.ar(sig,
        pit: 36 + 2 + 7 + 2 - 2 - 24 + 12 * [1, 1.005],
        struct: 0.75,
        bright: 0.75,
        // pos: 0,
        model: 4
    ) * 0.15;
    [sig[1], sig[0] * 4] * 0.75 * 0.25 * dd.lag(0.1);
}.play(fadeTime: 0.1);
)










(
[~noLowB].do({|i| i.set(\gate, 0, \fadeTime, 1)});
~noLowB = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var trig = tr[0] * dd;
    var block = Demand.kr(trig, 0, Dseq([1] ++ (0!7), inf));
    var notes = Demand.kr(trig, 0,
        Dseq(32 + [0] + 0, inf)
    );
    var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
    var dem2 = Demand.kr(trig * block, 0, Dseq([0, 0], inf));
    var pitch = Demand.kr(trig * block, 0, Dseq([0, -5].stutter(2), inf));
    var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
    var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
    var lfo3 = SinOsc.kr(1).range(0, 2000);
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
    var sig = MiBraids.ar(
        pitch: 24 + 7 - 12 + 7 + pitch - 2 - 3,
        timbre: 0.25,
        color: 0.0 + [0, 0.01],
        model: 0,
        resamp: 2,
        decim: 32,
        bits: 16,
        ws: 0
    );
    sig = sig * 0.6;
    sig = MiRings.ar(sig,
        pit: 36 + 2 + 7 + 2 - 2 - 24 + 12 + 12 * [1, 1.005],
        struct: 0.25,
        bright: 0.25,
        // pos: 0,
        model: 4
    ) * 0.5;
    [sig[1], sig[0] * 4] * 0.75 * 0.25 * dd.lag(0.1);
}.play(fadeTime: 0.1);
)












x.set(\freeze, 0);

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    y.set(\trigGate, 0, \gate, 0, \fadeTime, 1.1);
    y = {
        | trigGate = 1 |
        var pulse = ~nT.beatDur * 1;
        var t = Impulse.ar(~nT.tempo) * trigGate;
        var e = EnvGen.ar(
            Env([0, 1, 0, 0], [0.001, pulse * 0.75, pulse * 0.25])
            , t);
        var sig = XPlayBuf.ar(2, b, 0.5, t, 332950 + 1000, loopDur: pulse, loop: 1);
        // sig = sig * 1 + (WhiteNoise.ar(0.025));
        var filSig = VadimFilter.ar(sig * e, 5000, 0, 1);
        filSig = filSig + (VadimFilter.ar(sig * e, 6000, 0, 3) * 0.4);
        filSig * 4;
    }.play(fadeTime: 0);
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 1), {
    z.set(\trigGate, 0, \gate, 0, \fadeTime, 1.1);
    z = {
        | trigGate = 1 |
        var pulse = ~nT.beatDur * 1;
        var t = Impulse.ar(~nT.tempo) * trigGate;
        t!2 * 0.1;
    }.play(fadeTime: 0);
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    z.set(\trigGate, 0, \gate, 0, \fadeTime, 1.1);
    z = {
        | trigGate = 1 |
        var speed = 4;
        var pulse = ~nT.beatDur / speed;
        var t = Impulse.ar(~nT.tempo * speed) * trigGate;
        var e = EnvGen.ar(
            Env([0, 1, 0, 0], [0.001, pulse * 0.75, pulse * 0.25])
            , t);
        var sig = XPlayBuf.ar(2, b, 0.5, t, 332950 + 1000, loopDur: pulse, loop: 1);
        // sig = sig * 1 + (WhiteNoise.ar(0.025));
        sig = VadimFilter.ar(sig * e, 4000, 0, 5);
        sig * 4 * 3;
    }.play(fadeTime: 0);
});
)

(
    y.set(\trigGate, 0, \gate, 0, \fadeTime, 1.1);
    z.set(\trigGate, 0, \gate, 0, \fadeTime, 1.1);
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    y.set(\trigGate, 0, \gate, 0, \fadeTime, 1.1);
    y = {
        | trigGate = 1 |
        var pulse = ~nT.beatDur * 1;
        var t = Impulse.ar(~nT.tempo) * trigGate;
        var e = EnvGen.ar(
            Env([0, 1, 0, 0], [0.025, pulse * 0.95, pulse * 0.05], [2, 0, 0])
            , t);
        var sig = XPlayBuf.ar(2, b, 0.5, t, 332950 + 2000, loopDur: pulse, loop: 1);
        // sig = sig * 1 + (WhiteNoise.ar(0.025));
        var filSig = VadimFilter.ar(sig * e.pow(2), 4000, 0, 1);
        // filSig = filSig + (VadimFilter.ar(sig * e * e, 3000, 0.5, 3) * 0.2);
        filSig.reverse * 2;
    }.play(fadeTime: 0);
});
)

s.record;
s.stopRecording;

thisProcess.platform.recordingsDir.openOS;


(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur * 0), {
    z.set(\trigGate, 0, \gate, 0, \fadeTime, 1.1);
    z = {
        | trigGate = 1 |
        var speed = 2;
        var pulse = ~nT.beatDur / speed;
        var t = Impulse.ar(~nT.tempo * speed) * trigGate;
        var e = EnvGen.ar(
            Env([0, 1, 0, 0], [0.025, pulse * 0.95, pulse * 0.05], [2, 0, 0])
            , t);
        var sig = XPlayBuf.ar(2, b, 0.5, t, 332950 + 9000, loopDur: pulse, loop: 1);
        // sig = sig * 1 + (WhiteNoise.ar(0.025));
        var filSig = VadimFilter.ar(sig * e.pow(2), 5000, 0, 1) * 0.5;
        // filSig = filSig + (VadimFilter.ar(sig * e * e, 3000, 0.5, 3) * 0.2);
        filSig.reverse * 8;
    }.play(fadeTime: 0);
});
)