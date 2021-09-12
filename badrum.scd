(
{
    var t = Impulse.kr(1);
    var sig = AnalogBassDrum.ar(
        trig: t,
        accent: 0,
        freq: 50,
        tone: 0.0,
        decay: 0.95,
        attackfm: 0.25,
        selffm: 0.5
    ) * 16!2;
    VadimFilter.ar(
        input: sig,
        type: 1,
        freq: 200,
        resonance: 2 - (sig * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - sig))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 2;
}.play;
)