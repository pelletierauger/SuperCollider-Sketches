
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
~metronome.set(\gate, 0, \fadeTime, 0);
~metronome = {
    arg out = 0, amp = 1, pan = 0, atk = 0.001, dec = 0.01, sus = 1,
    rel = 0.5, susTime = 0.5, pitch = 12, timbre = 0, color = 1, model = 8,
    resamp = 2, decim = 2, bits = 6, ws = 0, lpfFreq = 1700;
    // var env = EnvGen.kr(Env([0, 1, sus, 0], [atk, dec, susTime, rel]), doneAction: 2);
    var envGate = EnvGate.new();

    var met1 = Impulse.ar(~nT.tempo) * 0.5;
    var tail = Demand.ar(met1, 0, Dseq(Dgeom(2, 2, 4) * -1 * 4, inf));
        var decay = Demand.ar(met1, 0, Dseq((0.05!6) ++ (0.25!2), inf));
        // var envelope = Env([0, 1, 0], [0.005, 0.05], [8, tail, 'lin']);

    var envelope = Env([0, 1, 0], [0.1, 0.1], [16, -16, 'lin']);
    var env = EnvGen.ar(envelope, met1);
    var met2 = Impulse.ar(~nT.tempo * 3) * 0.1;
    var dem = Demand.ar(met2, 0, Dseq([0, 0, 1], inf));
    var env2 = EnvGen.ar(envelope, met2 * dem) * 0.5;

    var met3 = Impulse.ar(~nT.tempo * 2) * 0.5;
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
    Out.ar(out, sig * 0.5);
}.play(fadeTime: 0);
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
~metronome2.set(\gate, 0, \fadeTime, 0);
~metronome2 = {
    arg out = 0, amp = 1, pan = 0, atk = 0.001, dec = 0.01, sus = 1,
    rel = 0.5, susTime = 0.5, pitch = 12, timbre = 0, color = 1, model = 8,
    resamp = 2, decim = 2, bits = 6, ws = 0, lpfFreq = 1700;
    // var env = EnvGen.kr(Env([0, 1, sus, 0], [atk, dec, susTime, rel]), doneAction: 2);
    var envGate = EnvGate.new();
        var tempo = ~nT.tempo * 0.25;
    var met1 = Impulse.ar(tempo) * 0.5;
    var tail = Demand.ar(met1, 0, Dseq(Dgeom(2, 2, 4) * -1 * 4, inf));
        var decay = Demand.ar(met1, 0, Dseq((0.05!6) ++ (0.25!2), inf));
        // var envelope = Env([0, 1, 0], [0.005, 0.05], [8, tail, 'lin']);

    var envelope = Env([0, 1, 0], [0.1, 0.1], [16, -16, 'lin']);
    var env = EnvGen.ar(envelope, met1);
    var met2 = Impulse.ar(tempo * 3) * 0.1;
    var dem = Demand.ar(met2, 0, Dseq([0, 0, 1], inf));
    var env2 = EnvGen.ar(envelope, met2 * dem) * 0.5;

    var met3 = Impulse.ar(tempo * 2) * 0.5;
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
    Out.ar(out, sig * 2);
}.play(fadeTime: 0);
});
)