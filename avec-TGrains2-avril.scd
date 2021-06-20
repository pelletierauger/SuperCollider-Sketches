s.sendMsg(\b_allocRead, 10, "/Users/guillaumepelletier/Desktop/0001 7-Audio-1-mono.wav");


(
{
    var b = 10, trate, dur, clk;
    trate = MouseY.kr(2,200,1);
    dur = 4 / trate;
    clk = Dust.kr(trate);
    TGrains2.ar(2, clk, 10, 1.0, LFNoise2.kr(0.5).range(0, BufDur.kr(b)), dur, 0, TRand.kr(0.1, 0.2, clk), MouseX.kr(0.003, 0.01), 0.007, 4);
}.play;
)

k.set(\low, 1, \high, 1);
k.set(\low, 0.99, \high, 1.01);

j.set(\pitch, 0);


16.8561
66.3614
(
o.stop;
o = {
    MouseY.kr(8, 120, 1).poll;
    MouseX.kr(0, BufDur.kr(10)).poll;
}.play;
)

(
k = {
    | low = 0.99, high = 1.01, pitch = 0 |
    var b = 10, trate, dur, clk, pos, pan, dem;
    trate = MouseY.kr(8,120,1);
    dur = 12 / trate;
    clk = Impulse.kr(trate);
    dem = Demand.kr(clk, 0, Dseq([1, 0.5], inf)) * TRand.kr(low, high, clk);
    pos = MouseX.kr(0,BufDur.kr(b)) + TRand.kr(0, 0.01, clk);
    pan = WhiteNoise.kr(0.6);
    TGrains2.ar(
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
    );
}.play;
)



(
j.set(\gate, 0, \fadeTime, 0.1);
j = {
    | low = 1, high = 1.0, pitch = 0 |
    var sig, b = 10, trate, dur, clk, pos, pan, dem, beat, melody;
    beat = Impulse.kr(0.25);
    melody = Demand.kr(beat, 0, Dseq([-5].midiratio, inf));
    trate = 16.8561;
    dur = 12 / trate;
    clk = Impulse.kr(trate * 4);
    dem = Demand.kr(clk, 0, Dseq([1, 0.5], inf)) * TRand.kr(low, high, clk);
    pos = 66.3614 + TRand.kr(0, 0.01, clk);
    pan = WhiteNoise.kr(0.6);
    sig = TGrains2.ar(
        numChannels: 2,
        trigger: clk,
        bufnum: b,
        rate: dem * pitch.midiratio * melody,
        centerPos: pos,
        dur: dur,
        pan: pan,
        amp: 0.1,
        att: dur * 0.3,
        dec: dur * 8,
        interp: 4
    );
    LPF.ar(sig, 18000);
}.play;
)

(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-5, -12, -10, -17] + 16, inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note,
        engine: 2,
        harm: 0.25,
        timbre: 0.0,
        morph: 0.2
    ) * 0.5 * env;
    sig[1]!2;
}.play;
n.set(\gate, 0, \fadeTime, 1);
n = {
    var freq = 61;
    var trig = Impulse.kr(8, 0.1);
    var dem = Demand.kr(trig, 0, Dseq(([1, 3, 1, 6] ++ [1, 3, 8, 10]).stutter(16) + 4, inf));
    var dem2 = Demand.kr(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
    var amp = EnvGen.kr(Env.new([0, 1, 0], [0.05, 0.025]), trig);
    var sig = MiPlaits.ar(freq + [0, 0.1] + dem,
        engine: 2,
        harm: 0.65,
        timbre: 0.25,
        morph: 0.45,
        trigger: trig,
        decay: 0.25
    );
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    sig = [sig[0][0], sig[1][0]];
    LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo * 0.125;
}.play;
m.set(\gate, 0, \fadeTime, 1);
m = {
    var freq = 61 - 12;
    var trig = Impulse.kr(8, 0.1);
    var dem = Demand.kr(trig, 0, Dseq(([1, 3, 1, 6] ++ [1, 3, 8, 10]).reverse.stutter(4) + 4, inf));
    var dem2 = Demand.kr(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
    var amp = EnvGen.kr(Env.new([0, 1, 0], [0.05, 0.025]), trig);
    var sig = MiPlaits.ar(freq + [0, 0.1] + dem,
        engine: 2,
        harm: 0.65,
        timbre: 0.25,
        morph: 0.45,
        trigger: trig,
        decay: 0.25
    );
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    sig = [sig[0][0], sig[1][0]];
    LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo * 0.125;
}.play;
)