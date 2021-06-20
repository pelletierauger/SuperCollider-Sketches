(
   if(~crushedPerc.isPlaying, {~crushedPerc.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});

    ~crushedPerc = {
        | trigGate = 1 |
        var trig, sig, block, decay, timbre, delrd, note;
        trig = Impulse.kr(~nT.tempo * 1.5 * 1);
        block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
        timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
        note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));


    // delrd = LocalIn.ar(2);
        sig = MiBraids.ar(
            pitch: 12,
            timbre: 1,
            color: timbre,
            model: 37,
            trig: trig * trigGate * block,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        );
    sig = LPF.ar(sig, 1700 + SinOsc.ar(0.1).range(0, 7000));
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
    // sig = LPF.ar(sig, 2700);
        sig!2 * 0.25 * 2;
    }.play(fadeTime: 0.01).register;
)

0.99 * 0.999