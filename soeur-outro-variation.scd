~t = TempoClock.new(1).permanent_(true);

(
~t.sched(~t.timeToNextBeat(quant: 4) - 0.25, {
    ~chor.set(\relGate, 1, \trigGate, 0);
    ~chor = {
        | trigGate = 1, relGate = 0|
        var amp = EnvGen.ar(
            envelope: Env([1, 1, 0], [0, 15], ['lin', -8], releaseNode: 1),
            gate: Trig.kr(relGate),
            doneAction: 2
        );
        var t = Impulse.kr(~t.tempo) * trigGate;
        var b = t * Demand.kr(t, 0, Dseq([1, 0, 0, 0], inf));
        var cc = Demand.kr(b, 0, Dseq([
            [-10, -5, 3], [-10, -3, 4],
            [-10, -5, 3], [-12, -3, 4]
        ], inf));
        var dT = DelayN.kr(b!3, 0.4, (0..2)/10 * 2);
        var env = EnvGen.kr(Env([0, 1, 0], [0.5, 3.85], [2, -2, 'lin']), dT).lag(0.25);
        var sig = MiBraids.ar(
            pitch: ~toMidi.("D4") + cc,
            timbre: 0.2 + (1 - env * 0.1),
            color: 0.2,
            model: 37,
            resamp: 0,
            decim: 12,
            bits: 2,
            ws: 0
        ) * 0.1;
        // sig = sig * env;
        var lfo = SinOsc.kr((3..5) + 2).range(0.6, 1);
        // env.size.poll
        sig = VadimFilter.ar(sig, 500 + (4000 * env * lfo), 0, 1) * env;
        // sig = sig.sum;
        // sig = sig + K2A.ar(dT);
        // sig = K2A.ar(dT);
        // sig.size.poll;
        // sig = sig[0] + sig[1] + sig[2];
        // sig = [sig[0] + (sig[1] * 0.5) + (sig[2] * 0.25), (sig[0] * 0.25) + (sig[2] * 2) + (sig[1] * 1)];
        sig = Splay.ar(sig, 0.25) * 4;
        sig = sig * 2 * amp;
        // sig = sig[1]!2;
        Out.ar(0, sig * 0.25);
        Out.ar(~reverb, sig * 0.5);
    }.play(fadeTime: 0);
});
)



(
~t.sched(~t.timeToNextBeat(quant: 4), {
    if(~rub.isPlaying, {~rub.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~toMidi.("A2");
    x.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~t.tempo * 4) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0.15, 0.15, 0.15, 0.5].rotate(1), inf));
        var sig = MiBraids.ar(
            pitch: 45,
            timbre: 0.65,
            color: d,
            model: 34,
            trig: t
        );
        sig * VadimFilter.ar(sig, 200, 0.25, 1) * 1!2;
    }.play(fadeTime: 0);
    ~x2.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    ~x2 = {
        | trigGate = 1 |
        var t = Impulse.kr(~t.tempo * 4) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 3.85], [2, -8, 'lin']), t);
        var d = Demand.kr(t, 0, Dseq([4, 5, 6, 5], inf));
        var sig = MiBraids.ar(
            pitch: 45 + 24,
            timbre: 0.65 + [0.0, 0.1],
            color: 0.5,
            model: 34,
            trig: t,
            resamp: 2,
            decim: 22 + [0, 4],
            bits: d,
            ws: 0
        ) * 0.5 * env;
        sig * VadimFilter.ar(sig, SinOsc.kr(0.1).range(1000, 6000), 0.25, 5);
    }.play(fadeTime: 0);
    ~t.sched(~t.timeToNextBeat(quant: 4), {
        ~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
        ~snare = {
            | trigGate = 1|
            var t = Impulse.kr(~t.tempo) * trigGate;
            var b = t * Demand.kr(t, 0, Dseq([0, 1], inf));
            var env = EnvGen.kr(Env([0, 1, 0], [0.01, 4.85], [2, -2, 'lin']), b);

            var sig = MiBraids.ar(
                pitch: 15,
                timbre: 0.5,
                color: 1,
                model: 36,
                trig: b,
                resamp: 2,
                decim: 22,
                bits: 4,
                ws: 0
            ) * 0.5!2 * env;
            sig * VadimFilter.ar(sig, 8000, 0, 1) * 4;
        }.play(fadeTime: 0);
    });
});
)



(
~t.sched(~t.timeToNextBeat(quant: 4) - (~t.beatDur * 0.5), {
    ~synthLine2.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~synthLine2 = {
        | trigGate = 1 |
        var t = Impulse.kr(~t.tempo * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([1, 1, 1, 1,    1, 1, 1, 0], inf)) * t;
        var note = Demand.kr(t, 0, Dseq((4!6) ++ ([8]) * 32 * 1.5, inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.5, 0.125 * note], [2, -8, 'lin']), d).lag(0.75);

        var note2 = Demand.kr(d, 0, Dseq(
            // [0, -3, -2, -5].wrapExtend(16) - 5 ++
            [ 3, 2, 5, 2 ] ++ [ 3, 2, 0 ]  /*++ [ 3, 2, 5, 9 ] ++ [ 3, 7, 0 ]*/ + 24, inf));
        var sig = MiBraids.ar(
            pitch: 21 - 2 + 12 + note2 + [0, 0.02] - 0.49 - 24,
            timbre: 0.9,
            color: 0.1,
            model: 43,
            // trig: t,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        ) * env * env;
        sig = VadimFilter.ar(sig, 400 + (SinOsc.kr(~t.tempo / 4).range(0.25, 1) * 1200 * env) * [1, 0.75], 0.25, 1);
        sig.reverse * 0.25 * 1 * [3, 3];
    }.play(fadeTime: 15.0).register;
});
)


(
~chor.set(\relGate, 1, \trigGate, 0);
x.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
~x2.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
~synthLine2.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
)