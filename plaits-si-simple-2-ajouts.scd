
s.sendMsg(\b_allocRead, 10, "/Users/guillaumepelletier/Desktop/0001 7-Audio-1-mono.wav");

k.set(\low, 1, \high, 1);
k.set(\low, 0.99, \high, 1.01);

(
k.set(\gate, 0, \fadeTime, 1);
k = {
    | low = 1.0, high = 1.0, pitch = -9 |
    var b = 10, trate, dur, clk, pos, pan, dem, sig;
    trate = 59.187;
    dur = 12 / trate;
    clk = Impulse.kr(trate);
    dem = Demand.kr(clk, 0, Dseq([1, 0.5], inf)) * TRand.kr(low, high, clk);
    pos = 52.5144 + TRand.kr(0, 0.01, clk);
    pan = WhiteNoise.kr(0.6);
    sig = TGrains2.ar(
        numChannels: 2,
        trigger: clk,
        bufnum: b,
        rate: dem * pitch.midiratio,
        centerPos: pos,
        dur: dur,
        pan: pan,
        amp: 0.1,
        att: dur * 0.3,
        dec: dur * 0.5,
        interp: 4
    ) * 1;
    // HPF.ar(sig, 50);
}.play;
)

(
o.set(\gate, 0, \fadeTime, 1);
o = {
    var freq = 61 + 12;
    var trig = Impulse.kr(7.5 * 0.5, 0.1);
    var dem = Demand.kr(trig, 0, Dseq(([1, 3, 1, 6] ++ [1, 3, 8, 10]).stutter(8), inf));
    var dem2 = Demand.kr(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
    var sig = MiPlaits.ar(freq + [0, 0.1] + dem,
        engine: 2,
        harm: 0.65,
        timbre: 0.5,
        morph: 0.45,
        trigger: trig,
        decay: 0.2
    );
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    sig = [sig[0][0], sig[1][0]];
    LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo * 0.2;
}.play;
)

(
// o.set(\gate, 0, \fadeTime, 1);
o = {
    var freq = 61 + 12 + 12;
    var trig = Impulse.kr(7.5 * 0.25, 0.1);
    var dem = Demand.kr(trig, 0, Dseq(([1, 3, 1, 6] ++ [1, 3, 8, 10]).stutter(8), inf));
    var dem2 = Demand.kr(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
    var sig = MiPlaits.ar(freq + [0, 0.1] + dem,
        engine: 2,
        harm: 0.65,
        timbre: 0.5,
        morph: 0.45,
        trigger: trig,
        decay: 0.2
    );
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    sig = [sig[0][0], sig[1][0]];
    LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo * 0.2;
}.play;
)



// ----


(
i.set(\gate, 0, \fadeTime, 0.1);
i = {
    var t = Impulse.kr(0.5);
    var note = Demand.kr(t, 0,
        Dseq([-7, -5, -10, -12].stutter(1), inf) + Dseq([12], inf)
    );
    var env = EnvGen.kr(Env([0, 1, 1, 0], [0.02, 4, 4], [2, 'lin', 'lin', 'lin']), t);
    var sig = AnalogSnareDrum.ar(
        trig: t,
        infsustain: 0.0,
        accent: 0.0,
        freq: 110 * 0.5 * note.midiratio * -1.midiratio,
        tone: 0.7,
        decay: 0.4,
        snappy: 0.0,
    );
    sig = LPF.ar(sig, 1000);
    Pan2.ar(sig, TRand.kr(-1.0, 1.0, t) * 0) * 2;
}.play(fadeTime: 0);
)


(
j.set(\gate, 0, \fadeTime, 0.1);
j = {
    var t = Impulse.kr(0.25);
    var note = Demand.kr(t, 0,
        Dseq([-10, -7, -5].stutter(1), inf) + Dseq([0], inf)
    );
    var env = EnvGen.kr(Env([0, 1, 1, 0], [0.005, 2, 2], ['lin', 'lin', 'lin', 'lin']), t);
    var sig = AnalogSnareDrum.ar(
        trig: t,
        infsustain: 0.0,
        accent: 0.0,
        freq: 110 * 0.5 * note.midiratio * -1.midiratio,
        tone: 0.8,
        decay: 0.4,
        snappy: 0.0,
    );
    sig = LPF.ar(sig, 1000);
    Pan2.ar(sig, TRand.kr(-1.0, 1.0, t) * 0) * 2;
}.play(fadeTime: 0);
)