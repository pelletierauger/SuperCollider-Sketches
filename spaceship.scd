(
~spaceship.set(\gate, 0, \fadeTime, 0.1);
~spaceship = {
    |freq=180, gain=10.0, amp=0.25, bias=0.99, biasfreq=0.29|
    // var biasOsc = SinOsc.ar(biasfreq, mul: bias);
    // var sig = SinOsc.ar(freq) + biasOsc;

    // Fold the signal
    // sig = sig * gain + biasOsc;
    var lfo = SinOsc.ar(0.1).range(5, 15);
    var sig = MiBraids.ar(40 + 5 + [0, 0.1], timbre: 0.5, color: 0.25, model: 10);
    sig = sig * lfo + (SinOsc.ar(0.1) * 0.99);
    sig = LockhartWavefolder.ar(input: sig, numCells: 4);
    sig = VadimFilter.ar(
        input: sig,
        type: 1,
        freq: 3200,
        resonance: 0
        // resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 1;
    // Filter out dc signals which might occur at low frequencies
    LeakDC.ar(sig) * 0.25 * amp
}.play;
)