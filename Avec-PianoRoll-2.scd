(
~seq = [
    ( 'beat': 0, 'midinote': 53, 'sustain': 1 ),
    ( 'beat': 1, 'midinote': 56, 'sustain': 1 ),
    ( 'beat': 1.75, 'midinote': 58, 'sustain': 1 ),
    ( 'beat': 1.5, 'midinote': 48, 'sustain': 1 ),
    ( 'beat': 2.5, 'midinote': 49, 'sustain': 0.5 ),
    ( 'beat': 2, 'midinote': 55, 'sustain': 1 ),
    ( 'beat': 6, 'midinote': 53, 'sustain': 1 ),
    ( 'beat': 7, 'midinote': 56, 'sustain': 1 ),
    ( 'beat': 7.75, 'midinote': 58, 'sustain': 1 ),
    ( 'beat': 8, 'midinote': 55, 'sustain': 1 ),
    ( 'beat': 7.5, 'midinote': 46, 'sustain': 1 ),
    ( 'beat': 8.5, 'midinote': 48, 'sustain': 0.5 ),
    ( 'beat': 3.5, 'midinote': 49, 'sustain': 0.5 ),
    ( 'beat': 9.5, 'midinote': 48, 'sustain': 0.5 ),
    ( 'beat': 4, 'midinote': 51, 'sustain': 0.5 ),
    ( 'beat': 10, 'midinote': 49, 'sustain': 0.5 ),
    ( 'beat': 0, 'midinote': 65, 'sustain': 1 ),
    ( 'beat': 6, 'midinote': 63, 'sustain': 1 ),
    ( 'beat': 5, 'midinote': 68, 'sustain': 1 ),
    ( 'beat': 11, 'midinote': 67, 'sustain': 1 ),
    ( 'beat': 0, 'midinote': 70, 'sustain': 1 ),
    ( 'beat': 6, 'midinote': 72, 'sustain': 1 ),
    ( 'beat': 0, 'midinote': 113, 'sustain': 1 ),
    ( 'beat': 6, 'midinote': 111, 'sustain': 1 ),
    ( 'beat': 0.109375, 'midinote': 46, 'sustain': 1 ),
    ( 'beat': 6.125, 'midinote': 44, 'sustain': 1 )
];
)

~pr.sequence.list = ~seq; ~pr.refresh;

(
{{~pr.sequence.list.do({|i|
    {
        var note = i.midinote;
        var dyn = 0;
        (i.beat*0.75).wait;
        if (note < 52, {note = note - 12});
        if (note > 65, {dyn = 1});
        // if (note < 52, {dyn = 1});
        (type: \pianoEvent, num: note+24, dyn:dyn).play;
        // ~toNote.(note+24).postln;
    }.fork;
});
(12*0.75).wait;}.loop;
}.fork;
)

(
{{~pr.sequence.list.do({|i|
    {
        var note = i.midinote;
        var dyn = 0;
        (i.beat*0.75).wait;
        if (note < 52, {note = note - 12});
        if (note > ~toMidi.("F4"), {dyn = 1; note = note - 24;});
        // if (note < 52, {dyn = 1}).;
        (type: \pianoEvent, num: note+24 * -1 + 150, dyn:dyn).play;
    }.fork;
});
(12*0.75).wait;}.loop;
}.fork;
)

(
{{~pr.sequence.list.do({|i|
    {
        var note = i.midinote;
        var dyn = 0;
        (i.beat*0.75).wait;
        if (note < 52, {note = note - 12});
        if (note < ~toMidi.("C5"), {
            if (note > ~toMidi.("F4"), {dyn = 1; note = note - 24;},
                {note = note - 24};
            );
        });

        // if (note < 52, {dyn = 1}).;
        (type: \pianoEvent, num: note+24 * -1 + 150, dyn:dyn).play;
    }.fork;
});
(12*0.75).wait;}.loop;
}.fork;
)


(
~twn.free;
~twn =
{
    var note = 46+48+0 + ((0..9)/10);

        var e = EnvGen.kr(Env.sine(dur: 24, level: 1).circle) * 0.8 + 0.2;
    var sig = MiBraids.ar(note, timbre: 0.6, color: 0.54, model: 42);
    sig = ~v.(~split.(sig), 2000,0,5)* 0.125*1 * (note.size.reciprocal);
    sig = ~v.(sig,9000)*1.5*e*8;
}.play;
)


(
// ~nT.sched(~nT.timeToNextBeat(quant: 8), {
    y.free;
    y = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625 * 0.125*0.125) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 5, 3, 7].stutter(1), inf));
        var e = EnvGen.kr(Env.sine(dur: 24, level: 0.125).circle);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.025, inf));
        var note = 40 + 24 + d + ((0..3) * 6 * 0.025)+0;
        var sig = MiBraids.ar(
            pitch: note ++ (note + shift)  ++ (note + shift + 1) - 0.49 + ~lfo.(3,0,1),
            timbre: 0.29, color: 0.75, model: 37,
            resamp: 0, decim: 16, bits: 3, ws: 0
        );
        sig = VadimFilter.ar(sig, 7500 * e + 200 * 0.5, 0, 1);
        // sig = [sig[0].sum, sig[1].sum];
        // sig.size.poll;
        sig = sig.scramble;
        sig = DelayN.ar(sig, 4, ((1..sig.size).reverse - 1) / 10 * 1);
        sig = Splay.ar(sig.scramble);
        // sig = VadimFilter.ar(sig, 100, 0, 5);
        // sig.size.poll;
        sig = sig * Line.kr(0, 1, 1);
        Out.ar(0, sig * 0.8);
    }.play;
// });
)