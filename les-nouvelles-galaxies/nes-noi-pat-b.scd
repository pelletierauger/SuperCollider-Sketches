(
w.set(\gate, 0, \fadeTime, 0.1);
w = {
    var pulse = Impulse.kr(1.39);
    var dem = Demand.kr(pulse, 0, Dseq([15, 1].stutter(1), inf));
    var sig = Nes2Noise.ar(
        trig: pulse,
        loopenv: 0,
        envdecay: 0,
        vol: 10,
        short: 1,
        freq: dem,
        vbl: 3
    );
    LPF.ar(sig, 1000) * 1.6!2;
}.play;
)