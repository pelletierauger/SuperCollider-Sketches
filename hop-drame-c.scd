(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    if(~toms.isPlaying, {~toms.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
if(~toms2.isPlaying, {~toms2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
if(~tomsZ.isPlaying, {~tomsZ.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});

    ~har.free;
    ~har = {
        var t = Impulse.kr(~nT.tempo / 16);
        var ch = Demand.kr(t, 0, Dseq([
            // [  0, 3, 7 ], [ 0, 5, 8 ]
            // [  3, 7, 12 ], [ 5, 8, 12]
            [  0, 3, 7 ], [ -4, 0, 5 ], [ -2, 1, 5 ], [ -2, 1, 7 ]
        ], inf));
        var sig = MiBraids.ar(~toMidi.("D#4") + ch,
            timbre: 0.163 + (SinOsc.kr(~nT.tempo * 2).unipolar * 0.5),
            color: 0.5,
            model: 6
    ).sum * 0.05 * 1 * Line.kr(0, 1, 0.4);
        VadimFilter.ar(VadimFilter.ar(sig, 200, 0, 5), 2000, 0, 1)  * 2 ! 2;}.play;
});
)