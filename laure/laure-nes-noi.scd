(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0), {

x.set(\gate, 0, \fadeTime, 0.1);
x = {
    var t = Impulse.kr(~nT.tempo * 0.5);
    var t2 = Impulse.kr(20);
    var dem = Demand.kr(t, 0, Dseq([1, 7, 15, 7].stutter(1), inf));
    var sig = Nes2Noise.ar(
        trig: t2,
        loopenv: 0,
        envdecay: 0,
        vol: 3.5,
        short: 0,
        freq: dem,
        vbl: 0
    );
    sig = LPF.ar(sig, 2000);
    sig!2 * 0.1275 * 8 * 2;
}.play(fadeTime: 0.25);
});
)