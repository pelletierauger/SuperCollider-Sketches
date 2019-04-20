~b1 = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Projets Ableton Live/Avec Caroline Project/Samples/Recorded/0002 7-Audio.aif");
~b1.numFrames;


(
~dur = PatternProxy(Pn(0.005, inf));
~loc = PatternProxy(Pn(712000, inf));
~har = PatternProxy(Pn(0.midiratio, 1));
~invHar = PatternProxy(Pn(0.midiratio, 1));
)
(
SynthDef(\bpfbuff, {
    arg buf = ~b1, rate = 1, spos = 0, pan = 1, amp = 1;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0.5, 0], [0.1, 0.15, 0.75]), doneAction: 2);
    sig = PlayBuf.ar(2, ~b1, rate * BufRateScale.ir(buf), startPos: spos);
    sig = sig * env;
    sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(0, sig);
}).add;
)
~loc.source = Pn(720000, inf);
~loc.source = Pn(-60000, inf);
~loc.source = Pn(-70000, inf);
(
p.stop;
p = Pbind(
    \instrument, \bpfbuff,
    \dur, Pseq([~dur], inf),
    \spos, Pwhite(1047552 - 850000 + ~loc, 1047552 - 840000 + ~loc, inf).round,
    \rate, Pseq([Plazy({
    var x;
        // x = (a[0] + 10).midicps;
        if (floor(~currentChord).asInteger.even, {x = 1 * -9.midiratio * [0, 12].choose.midiratio}, {x = 1 * -14.midiratio});
        Pseq([x],1);
})], inf),
    \amp, Pseq([0.25], inf),
    \pan, Pwhite(-1, 1, inf)
).play;
)