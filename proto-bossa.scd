s.boot;

t = TempoClock.new;
t.tempo_(52/60);
t.tempo_(55/60);
t.tempo * 60;
t.tempo

~printemps = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Projets Ableton Live/Latin de cuisine Project/Samples/Recorded/0010 Loop 3.aif");
~printemps.numFrames;
~printemps.numChannels;
7144448/14400/2/60;
(
SynthDef(\printemps, {
    arg buf = ~printemps, rate = 1, spos = 0, pan = 0, amp = 1, rel = 2, atk = 0.001, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, ~printemps, rate * BufRateScale.ir(buf), startPos: spos * 192000);
    sig = sig * env;
    sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)
s.scope;
(
a = [
    {|a = 1| Synth.new(\printemps, [\spos, 0.12, \rel, 0.55, \rate, 0.5, \amp, 1 * a])},
    {|a = 1| Synth.new(\printemps, [\spos, 0.3, \rel, 0.2, \rate, 1, \amp, 1 * a])},
    {|a = 1| Synth.new(\printemps, [\spos, 0.62, \rel, 1.02, \rate, 0.5, \amp, 1 * a])},
    {|a = 1| Synth.new(\printemps, [\spos, 0.7, \rel, 0.35, \rate, 0.5, \amp, 1 * a])},
    {|a = 1| Synth.new(\printemps, [\spos, 0.835, \rel, 0.4, \rate, 0.5, \amp, 1 * a])},
    {|a = 1| Synth.new(\printemps, [\spos, 0.835, \rel, 0.2, \rate, 1, \amp, 1 * a])},
    {|a = 1| Synth.new(\printemps, [\spos, 0.84, \rel, 0.175, \rate, 1, \amp, 1 * a])},
    {|a = 1| Synth.new(\printemps, [\spos, 0.84, \rel, 0.25, \rate, 0.5, \amp, 1 * a])},
    {|a = 1| Synth.new(\printemps, [\spos, 0.88, \rel, 0.6, \rate, 0.5, \amp, 1 * a])},
    {|a = 1| Synth.new(\printemps, [\spos, 0.96, \rel, 0.45, \rate, 0.5, \amp, 1 * a])},
    {|a = 1| Synth.new(\printemps, [\spos, 0.96, \rel, 0.18, \rate, 1, \amp, 1 * a])},
    {|a = 1| Synth.new(\printemps, [\spos, 0.961, \rel, 0.18, \rate, 1, \amp, 1 * a])},
    {|a = 1| Synth.new(\printemps, [\spos, 0.961, \rel, 0.9, \rate, 0.5, \amp, 1 * a])},
    {|a = 1| Synth.new(\printemps, [\spos, 0.835, \rel, 0.8, \rate, 0.25, \amp, 1 * a])}
];
)

a[5].();


{|a = 1| Synth.new(\printemps, [\spos, 0.96, \rel, 0.18, \rate, 1, \amp, 1 * a])}.();
{|a = 1| Synth.new(\printemps, [\spos, 0.961, \rel, 0.18, \rate, 1, \amp, 1 * a])}.();
{|a = 1| Synth.new(\printemps, [\spos, 0.835, \rel, 0.175, \rate, 1, \amp, 1 * a])}.();


a.size;
Synth.new(\printemps, [\spos, 0.12, \rel, 0.55, \rate, 0.5, \amp, 1]);
Synth.new(\printemps, [\spos, 0.1, \rel, 0.7, \rate, 0.5, \amp, 1])

Synth.new(\printemps, [\spos, 0.3, \rel, 0.2, \rate, 1, \amp, 4]);
Synth.new(\printemps, [\spos, 0.6, \rel, 0.31, \rate, 1, \amp, 1]);
Synth.new(\printemps, [\spos, 0.96, \rel, 1.05, \rate, 0.25, \amp, 1]);
Synth.new(\printemps, [\spos, 0.835, \rel, 0.8, \rate, 0.25, \amp, 1]);

t.tempo * 60;
t.tempo_(54/60);

t.tempo_(80/60);

t.tempo_(95/60);
t.tempo_(102/60);
t.tempo * 60;
(
Event.addEventType(\beatPrintanier, {
    // if (~amp.isFunction, {~amp = 1});
    a[~num].(~amp);
})
)
(
~beat.stop;
~beat = Pbind(
    \type, \beatPrintanier,
    \dur, Pseq([1], inf),
    \num, Pseq([11, 10], inf),
    \amp, Pseq([2.25, 1.125, 1.5, 1.125], inf)
).play(t, quant: 1);
)

(
~hat.stop;
~hat = Pbind(
    \type, \beatPrintanier,
    \dur, Pseq([0.5 + (1/32), 0.5 - (1/32)], inf),
    \dur, Pseq([0.5], inf),
    \num, Pseq([10, 11], inf),
    \amp, Pseq([2.25, 1.125, 1.5, 1.125], inf) * Pseq([1, 0.5], inf) * 0.75
).play(t, quant: 4);
)


(
~crossStick.stop;
~crossStick = Pbind(
    \type, \beatPrintanier,
    \dur, Pseq([3, 3, 2] * 0.5, inf),
    // \dur, Pseq([2, 3, 3] ++ [3, 3, 2] * 0.5, inf),
    \dur, Pseq([2, 3, 3] * 0.5, inf),
    \dur, Pseq([3, 3, 2] ++ [Rest(2), 3, 3] * 0.5, inf),
    \num, Pseq([4], inf),
    \amp, 4
).play(t, quant: [4, -1/32]);
)


(
~kick.stop;
~kick = Pbind(
    \type, \beatPrintanier,
    \dur, Pseq([3, 1] * 0.5, inf),
    \num, Pseq([13], inf),
    \amp, Pseq([3, 1.5], inf) * 2
).play(t, quant: [4, -1/32]);
)


(
~hat.stop;
~crossStick.stop;
~kick.stop;
~pia.stop;
~piaBas.stop;
~tamb.stop;
~tamb2.stop;
~surdo.stop;
)
(
~p2.stop;
~p2 = Pbind(
    \type, \beatPrintanier,
    \dur, Pseq([0.125, 0.125, 0.25], inf),
    \num, Pseq([9, 10, 12, 11], inf),
    \amp, Pseq([1.25, 1.5, 1.5, 1.25], inf) * Pseq([Pgeom(1.5, 0.9, 8)], inf)
).play(t, quant: 1);
)

(
~p3.stop;
~p3 = Pbind(
    \type, \beatPrintanier,
    \dur, Pseq([0.75, 0.25], inf),
    \num, Pseq([13], inf),
    \amp, Pseq([3, 1.5], inf) * 2
).play(t, quant: 1);
)


(
~p3.stop;
~p3 = Pbind(
    \type, \beatPrintanier,
    \dur, Pseq([0.125], inf),
    \num, Pseq([1], inf),
    \amp, Pseq([Pgeom(1, 0.8, 4)], inf),
).play(t, quant: 1);
)

(
~p1.stop;
~p1 = Pbind(
    \type, \beatPrintanier,
    \dur, Pseq([1, 0.5, 0.5], inf) * 0.25,
    \num, Pseq([0, 1, 1], inf),
    \amp, Pseq([1, 1, 0.5], inf),
).play(t, quant: 1);
)


(
p.stop;
p = Pbind(
    \type, \beatPrintanier,
    \dur, Pseq([0.25, 0.25, 0.25, 1], inf),
    \num, Pseq([1, 0, 1, 2], inf),
    \amp, 1
).play(t, quant: 1);
)


(
p.stop;
p = Pbind(
    \type, \beatPrintanier,
    \dur, Pseq([0.25, 0.25, 0.5].stutter(4), inf) * 0.5,
    \num, Pseq([0, 0, 1, 2], inf)
).play(t, quant: 1);
)
