(
~droo.free;
~droo = {
    // var x = MouseX.kr(0, 1);
    var x = ~lerp.(0.75, 0.707809, 0.75);
    // var y = MouseY.kr(0, 1);
    var y = ~lerp.(0.5, 0.501411, 0.75);
    var lfo = SinOsc.kr(0.1);
    var xx = (round(sin(x * 50) * 0.5 + 0.5)).lag(0.5);
    var sig = MiPlaits.ar(
        30 - 12 + [0, 0.01 * lfo] + 12 + 7 + xx - 25,
        engine: 0,
        harm: x, timbre: 1 - y, morph: y
    );
    sig = [sig[0][1], sig[1][1]];
    sig = VAKorg35.ar(sig, 3000, 0, overdrive: 1, type: 0);
    sig = AnalogVintageDistortion.ar(sig,
        drivegain: 0.95, bias: 0, lowgain: 0.4, highgain: 0.1,
        shelvingfreq: 600, oversample: 0
    ) * 1;
    sig = ~v.(sig, 1100, 0.25) * 0.25 * 0.125 * 0.5;
}.play;
)