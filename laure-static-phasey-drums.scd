(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~snare = {
    | trigGate = 1 |
    var trig = Impulse.ar(~nT.tempo * 2);
    var pat0 = [1, 0, 0, 0, 0, 0, 0, 0] ++ [1, 0, 0, 0, 0, 1, 0, 0];
    var pat1 = [0, 0, 0, 0, 1, 0, 0, 0] ++ [0, 0, 0, 0, 1, 0, 0, 0];
    var pat2 = [1];
    var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
    var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
    var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
    var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
    var sig = MiPlaits.ar(
        pitch: 30 + [0, 0, 0, 24] + 24 - [24, 12, 12, 12] + 0,
        engine: 9,
        harm: 0.5,
        timbre: 1,
        morph: 0.25 - [0, 0.4, 0.4, 0.5],
        trigger: trig * [block0, block1, block1, block2] * trigGate,
        decay: 0.0 + [0.9, 1, 1, 0.96] * 0.585,
        lpg_colour: 0
    );
    var sig2 = [sig[1][0], sig[2][0]] * 0.75;
    sig = [sig[0][0] * 4 + (sig[3][0] * 0.25)]!2 + sig2;
    // sig = (sig * 0.75) + HPF.ar(sig, 200);
        sig = VadimFilter.ar(sig, 5500, 0, 1)  * 0.5;
    // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        // sig = sig * 1.6 * 3.5;
        // sig = sig.clip(-1, 1);
        sig = MiRings.ar(
            sig, 0, 30 - 12, struct: 0.0, bright: 0.85, damp: 0.05,
            pos: SinOsc.kr(0.25).unipolar * 0.25 + 0, model: 2) * 4;
        sig = (VadimFilter.ar(sig, 500, 0, 5) * 2) * 12 *4;
        // sig = VadimFilter.ar(sig, 8000, 0, 1);
}.play(fadeTime: 0.0).register;
});
)
