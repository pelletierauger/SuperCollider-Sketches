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
    | low = 0.99, high = 1.01, pitch = 0 |
    var sig, b = 10, trate, dur, clk, pos, pan, dem, beat, melody;
    beat = Impulse.kr(0.25);
    melody = Demand.kr(beat, 0, Dseq([0, -5].midiratio, inf));
    trate = 16.8561;
    dur = 12 / trate;
    clk = Impulse.kr(trate);
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
        dec: dur * 0.5,
        interp: 4
    );
    LPF.ar(sig, 12000);
}.play;
)