(
~seq = [
    ( 'beat': 0, 'midinote': 46, 'sustain': 0.4 ),
    ( 'beat': 2, 'midinote': 50, 'sustain': 0.4 ),
    ( 'beat': 0, 'midinote': 74, 'sustain': 0.2 ),
    ( 'beat': 0.66666666666667, 'midinote': 74, 'sustain': 0.2 ),
    ( 'beat': 2.3333333333333, 'midinote': 51, 'sustain': 0.2 ),
    ( 'beat': 2.8333333333333, 'midinote': 50, 'sustain': 0.2 ),
    ( 'beat': 2, 'midinote': 70, 'sustain': 0.2 ),
    ( 'beat': 0.33333333333333, 'midinote': 50, 'sustain': 0.2 ),
    ( 'beat': 0.83333333333333, 'midinote': 51, 'sustain': 0.2 ),
    ( 'beat': 1.3333333333333, 'midinote': 50, 'sustain': 0.2 ),
    ( 'beat': 1.8333333333333, 'midinote': 46, 'sustain': 0.36666666666667 ),
    ( 'beat': 0.5, 'midinote': 53, 'sustain': 0.2 ),
    ( 'beat': 1.5, 'midinote': 55, 'sustain': 0.2 ),
    ( 'beat': 2.5, 'midinote': 53, 'sustain': 0.2 ),
    ( 'beat': 0, 'midinote': 43, 'sustain': 1 ),
    ( 'beat': 1, 'midinote': 43, 'sustain': 1 ),
    ( 'beat': 2, 'midinote': 43, 'sustain': 1 ),
    ( 'beat': 0, 'midinote': 58, 'sustain': 0.25 ),
    ( 'beat': 0.25, 'midinote': 58, 'sustain': 0.25 ),
    ( 'beat': 0.5, 'midinote': 58, 'sustain': 0.25 ),
    ( 'beat': 2, 'midinote': 60, 'sustain': 0.25 ),
    ( 'beat': 2.25, 'midinote': 60, 'sustain': 0.25 ),
    ( 'beat': 2.5, 'midinote': 60, 'sustain': 0.25 ),
    ( 'beat': 0.75, 'midinote': 60, 'sustain': 0.25 ),
    ( 'beat': 2.75, 'midinote': 58, 'sustain': 0.25 ),
    ( 'beat': 1.5, 'midinote': 77, 'sustain': 0.25 ),
    ( 'beat': 2.25, 'midinote': 72, 'sustain': 0.25 )
];
)

(
{{~seq.do({|i|
    {
        var note = i.midinote;
        var dyn = 0;
        (i.beat*3).wait;
        // if (note < 52, {note = note - 12});
        if (note > ~toMidi.("A4"), {dyn = 1});
        // if (note < 52, {dyn = 1});
        (type: \pianoEvent, num: note+0, dyn:dyn).play;

        // ~toNote.(note+24).postln;
    }.fork;
});
(3*3).wait;}.loop;
}.fork;
)

(
{{~seq.do({|i|
    {
        var note = i.midinote;
        var dyn = 0;
        var amp = 0.25;
        (i.beat*3).wait;
        if (note < 52, {note = note - 12});
        // if (note > ~toMidi.("A4"), {dyn = 1});
        if (note < 52, {dyn = 1; amp = 0.0625});
        (type: \pianoEvent, num: note * -1 + 120 + 12, dyn:dyn, amp: amp).play;

        // ~toNote.(note+24).postln;
    }.fork;
});
(3*3).wait;}.loop;
}.fork;
)

(
~twn.free;
~twn = {
    var note = 46+48+0 + ((0..9)/10);
    var e = EnvGen.kr(Env.sine(dur: 24, level: 1).circle) * 0.8 + 0.2;
    var sig = MiBraids.ar(note, timbre: 0.6, color: 0.54, model: 42);
    sig = ~v.(~split.(sig), 2000,0,5)* 0.125*1 * (note.size.reciprocal);
    sig = ~v.(sig,9000)*1.5*e*8;
}.play;
)