(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    // if(~toms.isPlaying, {~toms.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    // if(~toms2.isPlaying, {~toms2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    // if(~tomsZ.isPlaying, {~tomsZ.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});

    ~har.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~har = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[0];
        var ch = Demand.kr(t, 0, Dseq([
            // [  0, 3, 7 ], [ 0, 5, 8 ]
            // [  3, 7, 12 ], [ 5, 8, 12]
            [  0, 3, 7 ], [ -4, 0, 5 ], [ -2, 1, 5 ], [ -2, 1, 7 ]
        ].stutter(16), inf));
        var sig = MiBraids.ar(~toMidi.("D#3") + ch!2 + [(0!3),(0.1!3)],
            timbre: 0.163 + ~lfo.(~nT.tempo * 0.25 * 0.25, 0, 0.25),
            color: 0.5,
            model: 6
        );
        sig = [sig[0].sum, sig[1].sum];
        sig = sig * dd.lag(0.05) * 0.05 * 1 * Line.kr(0, 1, 0.4);
        // sig = ~v.(sig, 100, 0, 5);
/*        sig = AnalogVintageDistortion.ar(
            input: sig,
            drivegain: 1, bias: 0, lowgain: 0.3, highgain: 0.4,
            shelvingfreq: 600, oversample: 0
        ) * 0.25;*/
        sig = ~v.(sig, 4000) + (sig * 0.05) * 2;
    }.play;
});
)