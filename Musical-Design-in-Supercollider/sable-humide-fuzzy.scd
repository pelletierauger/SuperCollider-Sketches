(
Ndef('granulator', {
    | bufnum, tFreq = 20, overlap = 2, rate = 1, posRate = 1,
    tFreqMF = 0, tFreqMD = 0, rateMF = 0, rateMD = 0,
    posRateMF = 0, posRateMD = 0, trigGate = 1 |

    var t, phasor, gran, env;
    var bufFrames = BufFrames.ir(bufnum);

    var tFreqMod = {
        SinOsc.ar(tFreqMF, Rand(0.0, 2pi)) * tFreqMD;
    };

    var rateMod = {
        SinOsc.ar(rateMF, Rand(0.0, 2pi)) * rateMD;
    };

    var posRateMod = {
        SinOsc.ar(posRateMF, Rand(0.0, 2pi)) * posRateMD;
    };

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
    gran = gran[1]!2;
    gran = gran * SinOsc.kr(1, [0, pi * 0.5]);
    gran * 0.5;

});
Ndef('granulator').set('rate', 0.8994708994709, 'tFreq', 15.40730446841, 'posRateMF', 0.0, 'posRateMD', 1.3015873015873, 'rateMF', 0.0, 'tFreqMF', 14.074074074074, 'tFreqMD', 0.42328042328042, 'trigGate', 0.0, 'rateMD', 0.48677248677249, 'overlap', 12.323100555167, 'posRate', 0.78306878306878, 'bufnum', -0.0070546737213384, 'trigGate', 1);
Ndef('granulator').play(
	vol: 0.8028869718655
);
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
).edit;
);
Ndef(\granulator).set(\trigGate, 1);