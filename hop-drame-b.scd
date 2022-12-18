[  0, 3, 7 ], [ -2, 3, 7 ], [ -2, 1, 7 ], [ -4, 1, 5 ]
(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    ~har.free;
    ~har = {
        var t = Impulse.kr(~nT.tempo / 32);
        var ch = Demand.kr(t, 0, Dseq([[  0, 3, 7 ], [ -4, 0, 5 ]], inf));
        MiBraids.ar(~toMidi.("D#3") + ch,
            timbre: 0.5,
            color: 0.5,
            model: 0
    ).sum * 0.1 !2;}.play;
});
)

~chords
(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    ~har.free;
    ~har = {
        var t = Impulse.kr(~nT.tempo / 32);
        var ch = Demand.kr(t, 0, Dseq([
            [  0, 3, 7 ], [ -4, 0, 5 ], [ -2, 1, 5 ], [ -2, 1, 7 ]
        ], inf));
        var sig = MiBraids.ar(~toMidi.("D#3") + ch,
            timbre: 0.5,
            color: 0.5 + (SinOsc.kr(3).unipolar * 0.5),
            model: 0
    ).sum * 0.2;
        // sig ! 2;
        VadimFilter.ar(sig, 4000 * SinOsc.kr(0.1).unipolar + 6000, 0, 1) ! 2;
    }.play;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    ~har.free;
    ~har = {
        var t = Impulse.kr(~nT.tempo / 32);
        var ch = Demand.kr(t, 0, Dseq([
            [  0, 3, 7 ], [ -4, 0, 5 ], [ -2, 1, 5 ], [ -2, 1, 7 ]
        ], inf));
        var sig = MiBraids.ar(~toMidi.("D#2") + ch,
            timbre: 0.5,
            color: 0.5 + (SinOsc.kr(3).unipolar * 0.5),
            model: 0
    ).sum * 0.2;
        VadimFilter.ar(sig, 4000 * SinOsc.kr(0.1).unipolar + 2000, 0, 1) ! 2;
    }.play;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    ~har.free;
    ~har = {
        var t = Impulse.kr(~nT.tempo / 32);
        var ch = Demand.kr(t, 0, Dseq([
            // [  0, 3, 7 ], [ 0, 5, 8 ]
            [  3, 7, 12 ], [ 5, 8, 12]
        ], inf));
        MiBraids.ar(~toMidi.("D#3") + ch.lag(Line.kr(0,0.5,5)),
            timbre: 0.63 - (SinOsc.kr(0.1).unipolar * 0),
            color: 0.25,
            model: 6
    ).sum * 0.05 * Line.kr(0, 1, 0.4) !2;}.play;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    ~har.free;
    ~har = {
        var t = Impulse.kr(~nT.tempo / 16);
        var ch = Demand.kr(t, 0, Dseq([
            // [  0, 3, 7 ], [ 0, 5, 8 ]
            // [  3, 7, 12 ], [ 5, 8, 12]
            [  0, 3, 7 ], [ -4, 0, 5 ], [ -2, 1, 5 ], [ -2, 1, 7 ]
        ], inf));
        var sig = MiBraids.ar(~toMidi.("D#4") + ch,
            timbre: 0.63 - (SinOsc.kr(0.1).unipolar * 0),
            color: 0.25,
            model: 6
    ).sum * 0.025 * 1 * Line.kr(0, 1, 0.4);
        VadimFilter.ar(sig, 200, 0, 5)  * 1 ! 2;}.play;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    ~har.free;
    ~har = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        // var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[0];
        // var trig = t;
        var ch = Demand.kr(t, 0, Dseq([
            // [  0, 3, 7 ], [ 0, 5, 8 ]
            [  3, 7, 12 ], [ 5, 8, 12]
            // [  0, 3, 7 ], [ -4, 0, 5 ], [ -2, 1, 5 ], [ -2, 1, 7 ]
        ].stutter(16), inf));
        var sig = MiBraids.ar(~toMidi.("D#4") + ch,
            timbre: 0.163 + (SinOsc.kr(~nT.tempo * 2).unipolar * 0.5),
            color: 0.5,
            model: 6
    ).sum * 0.025 * 1 * Line.kr(0, 1, 0.4);
        VadimFilter.ar(sig, 200, 0, 5)  * 1 ! 2;}.play;
});
)