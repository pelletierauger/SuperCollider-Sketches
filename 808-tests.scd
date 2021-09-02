




(
~sna.free;
~sna = {
    var trig = Impulse.kr(8);
    var sig = AnalogSnareDrum.ar(
        trig: trig,
        infsustain: 0.0,
        accent: 0.25,
        freq: 55,
        tone: TRand.kr(0.0, 0.4, trig),
        decay: TRand.kr(0.1, 0.8, trig),
        snappy: TRand.kr(0.0, 0.9, trig),
    ) * 0.25;
sig!2;
}.play;
)


(
Ndef(\stormofkicks, {
    var trig = Impulse.kr(2);
    var sig = AnalogBassDrum.ar(
        trig,
        infsustain: 0.0,
        accent: 0.05,
        freq: 55 * 0.midiratio,
        tone: 0.0, //TRand.kr(0.5,1.0,trig),
        decay: 0.05,
        attackfm: 0.0, //TRand.kr(0.1,1.0,trig),
        selffm: 0.9 //TRand.kr(0.1,0.9,trig)
    ) * 8 * 4;
    sig!2;
    //     Pan2.ar(sig, TRand.kr(-1.0,1.0,trig));
}).play;
)