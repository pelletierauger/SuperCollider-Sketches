(
r = Routine({
    "abcde".yield;
    "fghij".yield;
    "klmno".yield;
    "pqrst".yield;
    "uvwxy".yield;
    "z{|}~".yield;
});
)

r.next;    // get the next value from the Routine
6.do({ r.next.postln });

(
SynthDef(\singrain, { |freq = 440, amp = 0.2, sustain = 1|
    var sig;
    sig = SinOsc.ar(freq, 0, amp) * EnvGen.kr(Env.perc(0.01, sustain), doneAction: Done.freeSelf);
    Out.ar(0, sig ! 2);    // sig ! 2 is the same as [sig, sig]
}).add;

r = Routine({
    var delta;
    loop {
        delta = rrand(1, 3) * 0.125;
        Synth(\singrain, [freq: exprand(200, 800), amp: rrand(0.1, 0.5), sustain: delta * 1.8]);
        delta.yield;
    }
});
)
r.next;

TempoClock.default.sched(0, r);

r.stop;
r.play;

(
t = Task({
    loop {
        [60, 62, 64, 65, 67, 69, 71, 72].do({ |midi|
            Synth(\singrain, [freq: midi.midicps, amp: 0.2, sustain: 0.1]);
            0.125.wait;
        });
    }
}).play;
)

(
h = Task({
    loop {
        [60, 62, 64, 65, 67, 69, 71, 72].do({ |midi|
            Synth(\singrain, [freq: midi.midicps * 0.5, amp: 0.2, sustain: 0.5]);
            0.25.wait;
        });
    }
});
)

h.play;
h.stop;

// probably stops in the middle of the scale
t.stop;

TempoClock.default.sched(0, t.play.value);

t.play(quant: 1);
h.play(quant: 1);    // should pick up with the next note

t.stop;


(
f = {
    Task({
        loop {
            [60, 62, 64, 65, 67, 69, 71, 72].do({ |midi|
                Synth(\singrain, [freq: midi.midicps, amp: 0.2, sustain: 1]);
                0.5.wait;
            });
        }
    });
};
)
(
~f2 = {
    Task({
        loop {
            [60, 62, 64, 65, 67, 69, 71, 72].do({ |midi|
                Synth(\singrain, [freq: midi.midicps * -5.midiratio, amp: 0.2, sustain: 1]);
                0.5.wait;
            });
        }
    });
};
)

t = f.value.play(quant: 4);        // start on next 4-beat boundary

u = ~f2.value.play(quant: [4, -0.125]);    // next 4-beat boundary + a half-beat

t.stop;
u.stop;

7;