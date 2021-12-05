
~path = PathName.new("/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/SuperCollider/Signes-Vitaux-3, Fichiers inutilisés/slide-guitar.aif");

~path.pathOnly.openOS

b = Buffer.read(s, ~path.fullPath);

(

x.set(\gate, 0, \fadeTime, 0.1);
x = {
    | freeze = 0 |
        var sig = PlayBuf.ar(2, b, 1, startPos: 332950, loop: 1);
    // var sig = XPlayBuf.ar(2, b, 0.5, 1, 332950, loop: 1);
    // sig.size.poll;
    //     var dens = LFNoise1.kr(0.3).range(0.3, 0.45);
    sig = VadimFilter.ar(sig, 12000, 0, 1);
        MiClouds.ar(
        inputArray: sig,
        pit: 0,
        pos: 0,
        size: 0,
        dens: 0.01,
        tex: 0.25,
        drywet: 0.75,
        in_gain: 1,
        spread: 0,
        rvb: 0.8,
        fb: 0,
        freeze: freeze,
        mode: 1,
        lofi: 0
    ) * 0.25 * 1.5;
    // sig * 1;
    // MiVerb.ar(sig);
    // sig.size.poll;
    // sig * 0.5;
}.play;
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