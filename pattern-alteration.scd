(
SynthDef.new(\simplest, {
    arg out, freq = 220, amp = 1, pan = 0, atk = 0.02, rel = 1;
    var sig, env;
    rel = min(max(rel, 0.001), 10);
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = LFTri.ar([freq, freq + 0.1]) * 0.1;
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)


(
SynthDef.new(\tone, {
    arg out, freq = 220, amp = 1, pan = 0, atk = 0.02, rel = 1;
    var sig, env;
    rel = min(max(rel, 0.001), 10);
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = SinOsc.ar([freq, freq + 0.1]) * 0.1;
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

Pdefn(\list, Pseq([0, 4, 7].midiratio, inf));
(
~p1.stop;
~p1 = Pbind(
    \instrument, \simplest,
    \dur, 0.25,
    // \freq, 110 * Pseq([Plazy({~iter}.())], inf) * Pseq([1, 2, 4, 8], inf),
    \freq, 110 * Pn(Pfunc(~iter), inf),
    \rel, 0.1,
    \amp, Pseq([Pgeom(2, 0.6, 4)], inf),
    // \amp, 2,
    \out, 0
).play(t, quant: 1);
)

(
~list = [0, 4, 7, 11, 12, 16, 19];
~minList = 0;
~maxList = 3;
~currentBeat = 0;
~curInList = ~minList;
)
(
~iter = {
    var ret = ~list[~curInList].midiratio;
    if (~currentBeat == 0, {
        (~list[~curInList]!4).postln;
    });
    ~currentBeat.postln;
    ~currentBeat = ~currentBeat + 1;
    if (~currentBeat == 4, {
        ~currentBeat = 0;
        ~curInList = ~curInList + 1;
        if (~curInList > ~maxList, {
           ~curInList = ~minList;
        });
    });
    ret;
};
)
~iter.();


Synth.new(\simplest, [\freq, 440, \amp, 1, \out, 0, \rel, 0.1, \pan, rrand(-0.5, 0.5)]);

().play;