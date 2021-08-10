
~nT.tempo = ~nT.tempo * 0.5
~nT.tempo = 1.8678125;
(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

    ~met = {Impulse.ar(~nT.tempo) * 0.1!2}.play(fadeTime: 0);
    ~met2 = {
        var imp = Impulse.ar(~nT.tempo * 3) * 0.1;
        var dem = Demand.ar(imp, 0, Dseq([0, 0, 1], inf));
        imp * dem!2 * 0.5;
    }.play(fadeTime: 0);
    ~met3 = {Impulse.ar(~nT.tempo * 2) * 0.1!2}.play(fadeTime: 0);
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~met2.free;
    ~met2 = {
        var imp = Impulse.ar(~nT.tempo * 8) * 0.1;
        var dem = Demand.ar(imp, 0, Dseq([0, 1], inf));
        imp * dem!2 * 0.5;
    }.play(fadeTime: 0);
});
)
(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~met24.free;
    ~met24 = {
        var imp = Impulse.ar(~nT.tempo * 3) * 0.1;
        var dem = Demand.ar(imp, 0, Dseq([1, 0, 0], inf));
        imp * dem!2 * 0.5;
    }.play(fadeTime: 0);
});
)
(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~metronome.set(\trigGate, 0, \gate, 0, \fadeTime, 15);
    ~metronome = {
        arg trigGate = 1, out = 0, amp = 1, pan = 0, atk = 0.001, dec = 0.01, sus = 1,
        rel = 0.5, susTime = 0.5, pitch = 12, timbre = 0, color = 1, model = 8,
        resamp = 2, decim = 2, bits = 6, ws = 0, lpfFreq = 1700;
        // var env = EnvGen.kr(Env([0, 1, sus, 0], [atk, dec, susTime, rel]), doneAction: 2);
        var envGate = EnvGate.new();

        var met1 = Impulse.ar(~nT.tempo) * trigGate * 0.5;
        var tail = Demand.ar(met1, 0, Dseq(Dgeom(2, 2, 4) * -1 * 4, inf));
        var decay = Demand.ar(met1, 0, Dseq((0.05!6) ++ (0.25!2), inf));
        // var envelope = Env([0, 1, 0], [0.005, 0.05], [8, tail, 'lin']);

        var envelope = Env([0, 1, 0], [0.1, 0.1], [16, -16, 'lin']);
        var env = EnvGen.ar(envelope, met1);
        var met2 = Impulse.ar(~nT.tempo * 3) * trigGate * 0.1;
        var dem = Demand.ar(met2, 0, Dseq([0, 0, 1], inf));
        var env2 = EnvGen.ar(envelope, met2 * dem) * 0.5;

        var met3 = Impulse.ar(~nT.tempo * 2) * trigGate * 0.5;
        var env3 = EnvGen.ar(envelope, met3);
        var sig = MiBraids.ar(
            pitch: pitch!3,
            timbre: timbre,
            color: color,
            model: [8, 8, 9],
            resamp: 2,
            decim: decim,
            bits: bits,
            ws: ws
        );
        // sig = sig * Amplitude.ar(met1.lag(0.1));
        sig = sig[0] * env + (sig[1] * env2 * 0.25) + (sig[2] * env3 * 0.25);
        // sig = met1;
        // sig = LPF.ar(sig, lpfFreq) * amp;
        // sig = LPF.ar(sig, 2000) * 8;
        // sig = Pan2.ar(sig, pan);
        sig = MiRings.ar(sig, pit: 45, struct: 0.5, bright: 0.2, damp: 0.5) * 8;
        Out.ar(out, sig * 0.5 * envGate);
    }.play(fadeTime: 0);
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4) - ~nT.beatDur, {
    ~metronome2.set(\trigGate, 0, \gate, 0, \fadeTime, 15);
    ~metronome2 = {
        arg trigGate = 1, out = 0, amp = 1, pan = 0, atk = 0.001, dec = 0.01, sus = 1,
        rel = 0.5, susTime = 0.5, pitch = 12, timbre = 0, color = 1, model = 8,
        resamp = 2, decim = 2, bits = 6, ws = 0, lpfFreq = 1700;
        // var env = EnvGen.kr(Env([0, 1, sus, 0], [atk, dec, susTime, rel]), doneAction: 2);
        var envGate = EnvGate.new();
        var tempo = ~nT.tempo * 0.25;
        var met1 = Impulse.ar(tempo) * trigGate * 0.5;
        var tail = Demand.ar(met1, 0, Dseq(Dgeom(2, 2, 4) * -1 * 4, inf));
        var decay = Demand.ar(met1, 0, Dseq((0.05!6) ++ (0.25!2), inf));
        // var envelope = Env([0, 1, 0], [0.005, 0.05], [8, tail, 'lin']);

        var envelope = Env([0, 1, 0], [0.1, 0.1], [16, -16, 'lin']);
        var env = EnvGen.ar(envelope, met1);
        var met2 = Impulse.ar(tempo * 3) * trigGate * 0.1;
        var dem = Demand.ar(met2, 0, Dseq([0, 0, 1], inf));
        var env2 = EnvGen.ar(envelope, met2 * dem) * 0.5;

        var met3 = Impulse.ar(tempo * 2) * trigGate * 0.5;
        var env3 = EnvGen.ar(envelope, met3);
        var sig = MiBraids.ar(
            pitch: pitch!3,
            timbre: timbre,
            color: color,
            model: [8, 8, 9],
            resamp: 2,
            decim: decim,
            bits: bits,
            ws: ws
        );
        // sig = sig * Amplitude.ar(met1.lag(0.1));
        sig = sig[0] * env + (sig[1] * env2 * 0.25) + (sig[2] * env3 * 0.25);
        // sig = met1;
        // sig = LPF.ar(sig, lpfFreq) * amp;
        sig = HPF.ar(sig, 4000) * 8;
        // sig = Pan2.ar(sig, pan);
        sig = MiRings.ar(sig, pit: 45 + 5 + [0, 0.1], struct: 0.5, bright: 0.2, damp: 0.6) * 8;
        Out.ar(out, sig * 2 * envGate);
    }.play(fadeTime: 0);
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 1) + (~nT.beatDur * 0.5) - 0.05, {
    ~k.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~k = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var t = Impulse.kr(~nT.tempo * 0.5) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10], inf));
        var sig = MiBraids.ar(
            pitch: 24 + 12 + Demand.kr(t, 0, Dseq([0, -1].stutter(4), inf)),
            timbre: 0.9,
            color: 0.3,
            model: 34,
            trig: t,
            resamp: [0, 2],
            decim: 32,
            bits: Demand.kr(t, 0, Dseq([2, 4, 6, 4], inf)),
            ws: 1
        );
        sig = (sig[0] + (sig[1] * 0.2 * sig[0]))!2;
        sig = LPF.ar(sig, 4400);
        sig * 2 * 0.45;
    }.play;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 1) + (~nT.beatDur * 0.5) - 0.05, {
    ~m.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~m = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var t = Impulse.kr(~nT.tempo * 0.5 * 3) * trigGate;
        var sig;
        t = t * Demand.kr(t, 0, Dseq([1, 1, 1, 0].stutter(6), inf));
        // var block = Demand.kr(t, 0, Dseq([1, 0, 1].rotate(0), inf));
        // var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
        // var note = Demand.kr(t, 0, Dseq([-6, -10], inf));
        sig = MiBraids.ar(
            pitch: 24 + 12 + 0 + -12 + [0, 0.1] + Demand.kr(t, 0, Dseq([0, -1].stutter(4), inf)),
            timbre: 0.5,
            color: 0.5,
            model: 34,
            trig: t,
            resamp: [2, 2],
            decim: 32,
            bits: Demand.kr(t, 0, Dseq([2, 4, 6, 4], inf)),
            ws: Demand.kr(t, 0, Dseq([0, 0.5].stutter(6), inf))
        );
        // sig = (sig[0] + (sig[1] * 0.2 * sig[0]))!2;
        sig = LPF.ar(sig, 4400);
        sig * 0.5 * 0.25;
    }.play;
});
)

(
~metronome.set(\trigGate, 0, \gate, 0, \fadeTime, 15);
~metronome2.set(\trigGate, 0, \gate, 0, \fadeTime, 15);
~k.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~m.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
)