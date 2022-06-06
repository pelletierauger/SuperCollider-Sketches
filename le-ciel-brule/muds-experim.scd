(
SynthDef(\muds,  {
    arg note = 110, detune = -1, atk = 0.08, dec = 3.5, muu = 1, amp = 1, lpf = 5000, faa = 1;
    var dem, bf, sig, sig2, st, buf, end, env, trig, lfo, dif;
    trig = Impulse.ar(0);
    env = EnvGen.ar(Env.new([0.001, 1, 0.75, 0.001], [atk, 0.1, dec], [-8, -8, -8]), doneAction: 2);
    dem = Demand.ar(trig, 0, Dseq((1..8) * 5, inf));
    buf = ~pizzi3;
    bf = BufFrames.ir(buf);
    st = 297696 + 1800 + muu;
    end = st + floor(BufSampleRate.ir(buf) / note.midicps);
    dif = 4000 - 300;
    sig = BufRd.ar(2, buf, Phasor.ar(0, 1, st, end, st), interpolation: 0);
    sig2 = BufRd.ar(2, buf, Phasor.ar(0, 1, st - dif, end - dif + detune, st), interpolation: 0);
    sig = sig + sig2;
    sig = VadimFilter.ar(sig * 0.5, lpf + (6000 * (1 - env)), 0, 1);
    lfo = SinOsc.kr(~nT.tempo * 0.5 * faa, pi * 1.5).unipolar;
    sig = (sig * 0.5) + (VadimFilter.ar(sig, 400 + (1000 * lfo), 0, 5) * 1);
    sig = VadimFilter.ar(sig * 0.5, 4000 * env + 10, 0, 1);
    Out.ar(0, sig * env * 4 * amp);
}).add;
)


(
~nT.schedAbs(~nT.nextBar - 0.1, {
    ~muds2.stop;
    ~muds2 = Pbind(
        \instrument, \muds,
        \dur, Pseq([0.0625, 1.5, 1.5, 1 - 0.0625] * 4, inf),
        \dur, Pseq([1] * 1, inf),
        \note, ~toMidi.("Gb4") + Pseq(
            [0, 3, 2, -5] ++ [0, 3, 5, -5]
            // [0, 3, -2, -5] ++ [0, 3, -3, -5]
            , inf),
        \detune, 0.5 * Pseq([1] * 1, inf),
        \muu, floor(Pwhite(0, 2000, inf)),
        \dec, 4.5,
        \amp, 1,
        \lpf, Pseq([5000, 5000, 5000, 4000] * 1, inf),
        \faa, Pseq([1, 1, 1, 2], inf)
        // \detune, Pseq(Pseries(0.4, 1/4, 4).asStream.nextN(4).reverse, inf)
    ).play(~nT, quant: [4]);
});
)