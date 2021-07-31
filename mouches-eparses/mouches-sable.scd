b = Buffer.readChannel(s, "/Users/guillaumepelletier/Desktop/abeille-mono.wav", channels:[0]);
b.bufnum

(
~granulator = {
    | bufnum, tFreq = 20, overlap = 2, rate = 1, posRate = 1,
    tFreqMF = 0, tFreqMD = 0, rateMF = 0, rateMD = 0,
    posRateMF = 0, posRateMD = 0, trigGate = 1, amp = 1 |

    var t, phasor, gran, env;
    var bufFrames = BufFrames.ir(bufnum);

    var tFreqMod = {SinOsc.ar(tFreqMF, Rand(0.0, 2pi)) * tFreqMD};
    var rateMod = {SinOsc.ar(rateMF, Rand(0.0, 2pi)) * rateMD};
    var posRateMod = {SinOsc.ar(posRateMF, Rand(0.0, 2pi)) * posRateMD};

    tFreq = tFreq + tFreqMod.dup;
    posRate = posRate + posRateMod.dup;
    rate = rate + rateMod.dup;

    t = Impulse.ar(tFreq) * trigGate;

    phasor = Phasor.ar(
        rate: posRate * BufRateScale.kr(bufnum),
        start: 0.0,
        end: bufFrames,
    );

    gran = GrainBuf.ar(
        numChannels: 1,
        trigger: t,
        dur: tFreq.reciprocal * overlap,
        sndbuf: bufnum,
        rate: rate,
        pos: phasor / bufFrames,
        interp: 2,
        pan: 0,
        envbufnum: -1,
        maxGrains: 512,
    );

    gran = gran * 0.5 * amp;
    Out.ar(0, gran);
    // Out.ar(0, gran * 0.1);
    // gran;
}.play;
~granulator.set('rate', 0.56084656084656, 'tFreq', 2225.3870271043, 'posRateMF', 0.0, 'posRateMD', 0.0, 'rateMF', 8.8888888888889, 'tFreqMF', 1.9047619047619, 'tFreqMD', 8.7830687830688, 'rateMD', 0.24338624338624, 'overlap', 7.869077130828, 'posRate', 2.1587301587302, 'bufnum', b.bufnum, 'trigGate', 1);
~granulator.free;
~granulator.set(\trigGate, 1);
~granulator.set(\amp, 0.5);
/*Ndef('granulator').play;
Ndef(\granulator).addSpec(
    \overlap, [0.001, 40, \exp],
    \rate, [-2, 2],
    \posRate, [0, 4],
    \tFreq, \widefreq,
    \tFreqMF, [0.0,20],
    \tFreqMD, [0.0,20],
    \rateMF, [0.0,20],
    \rateMD, [0.0,2],
    \posRateMF, [0.0,20],
    \posRateMD, [0.0,2],
    \trigGate, [0, 1]
).edit;*/
)

(
~sableQuiGrince = {
~granulator.set(
    'rate', 0.56084656084656,
    'tFreq', 2225.3870271043,
    'posRateMF', 0.0,
    'posRateMD', 0.5,
    'rateMF', 8.8888888888889,
    'tFreqMF', 1.9047619047619,
    'tFreqMD', 8.7830687830688,
    'rateMD', 0.24338624338624,
    'overlap', 7.869077130828 * 0.125,
    'posRate', 2.1587301587302 * 0.25,
    'bufnum', b.bufnum,
    'trigGate', 1
);
};
~sableQuiGrince.();
)



(
~sableLourd = {
~granulator.set(
    'rate', 0.56084656084656,
    'tFreq', 2225.3870271043,
    'posRateMF', 0.0,
    'posRateMD', 0.5,
    'rateMF', 8.8888888888889,
    'tFreqMF', 1.9047619047619,
    'tFreqMD', 8.7830687830688,
    'rateMD', 0.24338624338624,
    'overlap', 7.869077130828 * 0.25,
    'posRate', 2.1587301587302 * 1,
    'bufnum', b.bufnum,
    'trigGate', 1
);
};
~sableLourd.();
)

Ndef(\granulator).set(\trigGate, 1);



(
~mm = 1;
~granStutter = Task {
    {
        ~granulator.set(\trigGate, max(~mm, 0));
        ~mm = ~mm * -1;
        // ~drum.();
        (~nT.beatDur * 8).wait;
    }.loop;
}.start(~nT, quant: [4]);
)
~granStutter.stop;