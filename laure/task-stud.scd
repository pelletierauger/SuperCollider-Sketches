(
~base = ~nT.beats;
~drums = Task {
    {
        // ~drum.();
            ("timeToNextBeat: " ++ ~nT.timeToNextBeat.asString).postln;
        "yarp".postln;
        (~nT.beats - ~base).round.postln;
        16.wait;
    }.loop;
}.start(~nT, quant: [16]);
)
~drums.stop;

~nT