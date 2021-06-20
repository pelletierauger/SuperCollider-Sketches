s.sendMsg(\b_allocRead, 10, "/Users/guillaumepelletier/Desktop/0001 7-Audio-1-mono.wav");

b = Buffer.readChannel(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/La-faim/samples/soft-pluck-b.wav", channels:[0]);

(
// k.free;
k.set(\trigGate, 0, \gate, 0, \fadeTime, 2);
k = {
    | low = 0.99, high = 1.01, pitch = 0, trigGate = 1 |
    var sig, trate, dur, clk, pos, pan, dem, ci, cd, ca;
    ci = Impulse.kr(0.125);
    cd = Demand.kr(ci, 0, Dseq([-7, -5], inf));
    trate = MouseY.kr(8,120,1);
    dur = 12 / trate * 4;
    clk = Impulse.kr(trate) * trigGate;
    dem = Demand.kr(clk, 0,
        Dseq([-12, 0, cd, 3].midiratio.stutter(1), inf)
        * Dseq([0.5, 0.25], inf)
    ) * TRand.kr(low, high, clk);
    pos = MouseX.kr(0,BufDur.kr(b)) + TRand.kr(0, 0.01, clk);
    pan = WhiteNoise.kr(1);
    ca = Demand.kr(clk, 0, Dseq([0.1, 2], inf));
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
    );
    LPF.ar(sig, 2000);
}.play;
)