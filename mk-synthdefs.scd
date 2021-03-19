AnalogBassDrum

(
Ndef(\stormofkicks, {
    var trig = Impulse.kr(2);
    var note = Demand.kr(trig, 0, 55 * 7.midiratio * Dseq([-5, 2, 7].midiratio, inf));
    var sig = AnalogBassDrum.ar(
        trig,
        infsustain: 0,
        accent: 0.0,
        freq: note,
        tone: 0.4,//TRand.kr(0.5,1.0,trig),
        decay: 1,
        attackfm: 0.0,//TRand.kr(0.1,1.0,trig),
        selffm: 0.1
    ) * 2;
    sig = LPF.ar(sig, 200);
    sig!2 * 40;
}).play;
)

(
Ndef(\helloooo, {
    //     var mod = SinOsc.kr(LFNoise2.kr(4) * 10);
    var sig = VarShapeOsc.ar(
        freq: 110 * [1, 1.001],
        pw: 0,
        waveshape: SinOsc.kr(0.1).range(0.0, 1.0),
        sync: 1,
        syncfreq: 110
    );
    sig = LPF.ar(sig, 200);
    Pan2.ar(sig, 0) * 8;
}).play;
)