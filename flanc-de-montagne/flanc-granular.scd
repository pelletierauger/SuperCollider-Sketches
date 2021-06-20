s.sendMsg(\b_allocRead, 10, "/Users/guillaumepelletier/Desktop/0001 7-Audio-1-mono.wav");

(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    if(j.isPlaying, {j.set(\trigGate, 0, \gate, 0, \fadeTime, 3)});

    j = {
        | low = 1, high = 1.0, pitch = -2, trigGate = 1 |
        var trig, deem, sig, b = 10, trate, dur, clk, pos, pan, dem, beat, melody;
        trig = Impulse.kr(~nT.tempo * 1 * 1 * 0.25 * 0.25) * trigGate;
        deem = Demand.kr(trig, 0, Dseq([60, 66] + 0.3614, inf));
        deem = Demand.kr(trig, 0, Dseq([29.6, 33].reverse + 0.3614, inf));
        beat = Impulse.kr(0.25);
        melody = Demand.kr(beat, 0, Dseq([-5].midiratio, inf));
        trate = 16.8561;
        dur = 12 / trate;
        clk = Impulse.kr(trate * 4);
        dem = Demand.kr(clk, 0, Dseq([1, 0.5], inf)) * TRand.kr(low, high, clk);
        pos = deem + TRand.kr(0, 0.01, clk);
        pan = WhiteNoise.kr(1);
        sig = TGrains2.ar(
            numChannels: 2,
            trigger: clk * trigGate,
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
        LPF.ar(sig, 18000) * 1;
    }.play(fadeTime: 0.1).register;
});
)