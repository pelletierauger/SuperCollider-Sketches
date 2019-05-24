






(
var stairs = [2, 2, 1, 2, 2, 2, 1];
)

(
~goingUpTwice = {
    |start|
    var stairs = [2, 2, 1, 2, 2, 2, 1];
    var note2 = stairs.wrapAt(start) + stairs.wrapAt(start + 1);
    var note3 = note2 + stairs.wrapAt(start + 2) + stairs.wrapAt(start + 3);

    var base = 0;
    if (start > 0, {
        var st = start - 1;
        forBy (st, 1, -1, {
            arg i; base = base + stairs.wrapAt(i);
            "yeaagh!".postln;
        });
        base.postln;
    });

    // [0, note2, note3] + base;
    (2.pow(1/12).pow([0, note2, note3] + base));
};
)
(2.pow(1/12).pow([0, 2, 3]))

~goingUpTwice.(2);

440 * 1.midiratio;
440 * 2.pow();

// ((2 to the power of 1/12) to the power of n)

forBy (8, 0, -2, { arg i; i.postln });

440 * (2.pow(1/12).pow(1));

c = [];
c.put(0, 3);

s.boot;

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
var freqs = 440 * ~goingUpTwice.(3);
Synth.new(\simplest, [\freq, freqs[0], \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, freqs[1], \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\simplest, [\freq, freqs[2], \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
)
