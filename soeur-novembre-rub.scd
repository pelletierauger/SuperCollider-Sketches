(
~t.sched(~t.timeToNextBeat(quant: 4), {
    x.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
~x2.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    ~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~synthLine3.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
if(~rub.isPlaying, {~rub.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
[~billes0, ~billes1].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

~rub = {
    | trigGate = 1 |
    var trig, sig, env, block, decay, timbre, delrd, note, note2, r, n;
    trig = Impulse.kr(2 * 1 * 1);
    block = Demand.kr(trig, 0, Dseq([1, 0, 1, 1], inf));
    timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
    note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
    note2 = Demand.kr(trig * block, 0, Dseq([0.4, 0.8], inf));
    r = 0.01;
    n = (2 * 1.5 * 0.5).reciprocal;
    env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    // timbre = timbre.lag(0.07);
    // delrd = LocalIn.ar(2);
    sig = MiBraids.ar(
        pitch: 12 + -0,
        timbre: 1,
        color: 0.8,
        model: 9,
        resamp: 2,
        decim: 32,
        bits: 2,
        ws: 0
    );
    sig = VadimFilter.ar(sig, 3700 + SinOsc.ar(0.1).range(0, 7000), 0, 1);
    // sig = ;
    sig = MiRings.ar(sig,
        pit: ~toMidi.("A2") + note.lag(0.1),
        struct: 0.25,
        bright: note2 * 0.5,
        damp: 0.9,
        pos: 0,
        model: 1
    );
        // sig.size.poll;
        // sig = VadimFilter.ar(sig, 100, 0, 5);
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
    // sig = LPF.ar(sig, 2700);
    sig * 0.25 * 1;
}.play(fadeTime: 0.1).register;
});
)
