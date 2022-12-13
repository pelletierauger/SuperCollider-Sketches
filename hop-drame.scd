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
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    ~har.free;
    ~har = {
        var t = Impulse.kr(~nT.tempo / 32);
        var ch = Demand.kr(t, 0, Dseq([
            [  0, 3, 7 ], [ 0, 5, 8 ]
        ], inf));
        MiBraids.ar(~toMidi.("D#3") + ch.lag(Line.kr(0,0.5,5)),
            timbre: 0.63 - (SinOsc.kr(0.1).unipolar * 0),
            color: 0.25,
            model: 4
    ).sum * 0.2 * Line.kr(0, 1, 0.4) !2;}.play;
});
)