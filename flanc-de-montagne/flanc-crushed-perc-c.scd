(
~nT.sched(~nT.timeToNextBeat(quant: 1), {
if(~crushedPerc.isPlaying, {~crushedPerc.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});

    ~crushedPerc = {
        | trigGate = 1 |
        var trig, sig, env, block, decay, timbre, delrd, note, amp;
        trig = Impulse.kr(~nT.tempo * 1.5 * 0.5 * 4) * trigGate;
        block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 0], inf));
        timbre = Demand.kr(trig, 0, Dseq([0.0, 0.2, 0.4, 0.6].stutter(1), inf));
        note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        env = EnvGen.kr(Env([0, 1, 0.5, 0], [0.001, 0.05, 0.125 * 4], [2, 0, 0, 'lin']), trig);
    amp = Demand.kr(trig * block, 0, Dseq([1, 0.5, 0.75, 0.5], inf));

    env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 0.5 + (amp * 0.5)], [2, -8, 'lin']), trig);

    delrd = LocalIn.ar(2);
        sig = MiBraids.ar(
            pitch: 60 - 12,
            timbre: 0.5,
            color: timbre,
            model: 30,
            trig: trig * block,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        ) * env * amp;
    // sig = LPF.ar(sig, 1700 + SinOsc.ar(0.1).range(0, 7000));
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.92 * [1, 0.95], 0.1, 0.025 * note));
    sig = LPF.ar(sig, 700 + (1000 * env) + SinOsc.kr(6).range(100, 4000));
        sig = HPF.ar(sig, 2700);
        sig!2 * 0.25 * 16 * 8;
    }.play(fadeTime: 0.01).register;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 1) + (~nT.beatDur * 0.0), {
    if(~crushedPerc2.isPlaying, {~crushedPerc2.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});

    ~crushedPerc2 = {
        | trigGate = 1 |
        var trig, sig, env, block, decay, timbre, delrd, note, amp;
        trig = Impulse.ar(~nT.tempo * 1.5 * 0.5 * 2) * trigGate;
        block = Demand.ar(trig, 0, Dseq([1, 0, 1, 0, 1, 0], inf));
        timbre = Demand.ar(trig * block, 0, Dseq([0.0, 0.0].stutter(1), inf));
        note = Demand.ar(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        env = EnvGen.ar(Env([0, 1, 0.5, 0], [0.001, 0.05, 0.125 * 4], [2, 0, 0, 'lin']), trig);
    amp = Demand.ar(trig * block, 0, Dseq([1, 0.5, 0.75, 0.5], inf));

    env = EnvGen.ar(Env([0, 1, 0], [0.014, 0.125 * 16 + (amp * 0.5)], [2, -8, 'lin']), trig * block);
        env = env.lag(0.07);
        // delrd = LocalIn.ar(2);
        sig = MiBraids.ar(
            pitch: 60 - 12 - 12,
            timbre: 0.6,
            color: timbre,
            model: 33,
            trig: trig * block,
            resamp: 0,
            decim: 32,
            bits: 4,
            ws: 0
        ) * env;
    // sig = LPF.ar(sig, 1700 + SinOsc.ar(0.1).range(0, 7000));
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.92 * [1, 0.95], 0.1, 0.025 * note));
        // sig = LPF.ar(sig, 200 + (500 * env) + SinOsc.kr(6).range(100, 1000));
        sig!2 * 0.25 * 16 * 2;
    }.play(fadeTime: 0.01).register;
});
)