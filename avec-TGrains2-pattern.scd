(
k = {
    | low = 0.99, high = 1.01, pitch = 0 |
    var b = 10, trate, dur, clk, pos, pan, dem, beat;
    trate = MouseY.kr(8,120,1);
    dur = 12 / trate;
    clk = Impulse.kr(trate);
    beat = Impulse.kr(1);
    dem = Demand.kr(clk, 0, Dseq([1, 0.5], inf)) * TRand.kr(low, high, clk);
    pos = MouseX.kr(0,BufDur.kr(b)) + TRand.kr(0, 0.01, clk);
    pos = Demand.kr(beat, 0, Dseq([0.2, 0.25, 0.5, 0.6] * BufDur.kr(b), inf));
    pos = pos + TRand.kr(0, 0.01, clk);
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
