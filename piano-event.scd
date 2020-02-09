(
Event.addEventType(\happyEvent, { |server|
    ~octave = [5, 6, 7]; // always play three octaves
    ~detune = 10.0.rand2; // always play a bit out of tune
    ~type = \note; // now set type to a different one
    currentEnvironment.play;
});

Pbind(\type, \happyEvent, \degree, Pseq([0, 1, 2, 3, 4, 4, 5, 5, 5, 5, 4, 2, 3, 2, 3, 1], inf), \dur, Pwhite(0.1, 1.0, inf)).play;
);



(
var key = ~toMidi.("A4");
var notes = key + ([-12, 3, 7, 10] ++ [-5, 2, 3, 9]);
~pianoRiff.stop;
~pianoRiff = Pbind(
    \type, \pianoEvent,
    \dur, 0.25,
    \num, Pseq(notes, inf),
    \dyn, Pseq([1, 0, 0, 1], inf),
    \amp, Pseq([1, 2, 2, 1], inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 3
).play(quant: [2]);
)

(
Event.addEventType(\pianoEvent, { |server|
    var ind, pit, bufArr, location;
    ind = topEnvironment.use({~indices});
    pit = topEnvironment.use({~pitches});
    bufArr = topEnvironment.use({~pianoSamples});
    if (~num.isNil, {~num = 60});
    if (~dyn.isNil, {~dyn = 0});
    location = ~num + (~dyn * 111);
    ~index = ind[location];
    ~buf = bufArr[~index];
    ~rate = pit[location];
    ~instrument = \pianoSynth;
    ~type = \note;
    currentEnvironment.play;
});
)


(
SynthDef(\pianoSynth, {
    arg buf = ~pianoSamples[0], rate = 1, spos = 0, pan = 0, amp = 1, out = 0, atk = 0, sus = 0, rel = 8;
    var sig, env;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, sus, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos, doneAction: 2);
    sig = sig * amp * 18 * env;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)