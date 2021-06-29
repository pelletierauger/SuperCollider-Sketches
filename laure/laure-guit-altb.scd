c = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Projets Ableton Live/Avec l'AT2020 Project/Samples/Recorded/0002 6-Audio.aif");


(
SynthDef(\samplerAbs, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, atk = 0.01, susT = 1, rel = 0.01, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], ['lin', -8]), doneAction: 0);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufSampleRate.ir(buf));
    sig = sig * env * amp;
      sig = sig + (CombC.ar(in: sig,
    maxdelaytime: 0.5,
    delaytime: [0.1],
    decaytime: 4,
        mul: 1, add: 0)* 0.0);
/*          sig = sig + (CombC.ar(in: sig,
    maxdelaytime: 0.5,
    delaytime: [0.0025 * 0.5],
    decaytime: 5,
        mul: 0.1, add: 0));*/
    sig = LPF.ar(sig, 9500);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Line.kr(0, 1, 10, doneAction: 2);
    Out.ar(out, sig);
}).add;
)

(
~guitareD.stop;
~guitareD = Pbind(
    \instrument, \samplerAbs,
    \buf, c,
    \dur, 4,
    // \spos, Pseq([11.339], inf),
    \spos, Pseq([143.866], inf),
    \rel, 0.5,
    // \atk, 0.5,
    \susT, 1.5,
    \rate, -2.midiratio,
    // \rate, Pseq([-12, -7].midiratio.stutter(2), inf),
    \amp, 1.5 * 6 * 2,
    // \lpf, 3000,
    // \pan, Pwhite(-0.75, 0.75, inf),
    \out, 0
).play(~nT, quant: [4, -0.4]);
)