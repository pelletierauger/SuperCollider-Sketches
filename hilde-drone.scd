(
{        var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
    var lfo = SinOsc.kr(0.1);
    var xx = (round(sin(x * 50) * 0.5 + 0.5)).lag(0.5);
    var sig = MiPlaits.ar(30 + [0, 0.01 * lfo] + 12 + 7 + xx, engine: 4, harm: x, timbre: 1 - y, morph: y);
    sig = [sig[0][1], sig[1][1]];
    sig = VadimFilter.ar(sig, 5000 * lfo.unipolar + 100, 0.25, 1) * 0.4;}.play;
)


(o).unipolar


Scale.minor.degrees
Scale.phrygian.degrees;


(
{        var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
    var lfo = SinOsc.kr(0.1).unipolar;
    var lfo2 = SinOsc.kr(0.1).unipolar;
    // var xx = (round(sin(x * 50) * 0.5 + 0.5)).lag(0.5);

    var scale = Scale.minor.degrees ++ [12];
    var xx = Select.kr([floor(x * 8)], scale).lag(0.5);
    var sig = MiPlaits.ar(30 + [0, 0.01 * lfo], engine: 5, harm: 0.25, timbre: 0.5 - (lfo2 * 0.1), morph: 0.5);
    sig = [sig[0][1], sig[1][1]];
    sig = VadimFilter.ar(sig, 1000 * lfo.unipolar + 100, 0.25, 1) * 0.4;}.play;
)

(
{        var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
    var lfo = SinOsc.kr(0.1);
    // var xx = (round(sin(x * 50) * 0.5 + 0.5)).lag(0.5);

    var scale = Scale.minor.degrees ++ [12];
    var xx = Select.kr([floor(x * 8)], scale).lag(0.5);
    var sig = MiPlaits.ar(30 + [0, 0.01 * lfo] + 12 + 0 + xx, engine: 0, harm: x, timbre: 1 - y, morph: y);
    sig = [sig[0][1], sig[1][1]];
    sig = VadimFilter.ar(sig, 1000 * lfo.unipolar + 4100, 0.25, 1) * 0.1;
}.play;
)