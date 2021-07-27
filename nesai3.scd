(
b = Buffer.alloc(s, 1);
~salive.set(\gate, 0, \fadeTime, 0.1);
~salive = {
var x, y, rate, a, c, m, sig, imp, dem, dem2, env;
    imp = Impulse.kr(0.25);
    env = EnvGen.kr(Env([0, 1, 0], [0.001, 4], [2, 'lin', 'lin']), imp);

    dem = Demand.kr(imp, 0, 440 * Dseq([0, -5].midiratio, inf));
    dem2 = Demand.kr(imp, 0, Dseq([50, 100], inf));
    rate = MouseX.kr(100, SampleRate.ir);
    rate = (dem * 62.midiratio + (rate * 0.001)).lag(0.125);
    // rate = 8000;
    a = 1.1;
    c = 0.13;
    m = 1.0;
    x = Dbufrd(b); // read from buffer
    x = x * a + c % m;
    y = Dbufwr(x, b); // write to buffer
    sig = Duty.ar(1 / rate, 0, y) * 0.1!2;
    sig = LFCub.ar(rate * 0.125 * 0.25 * sig * dem2) * 0.02;
    LPF.ar(sig, 100 + (2000 * env.pow(3)).lag(0.1));
    // LPF.ar(sig, 2000);
}.play(fadeTime: 0.4);
)