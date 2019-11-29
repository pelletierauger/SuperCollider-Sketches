(
Event.addEventType(\playWobblyPiano, {
    var no = ~num;
    topEnvironment.use({~wobblyPiano.(no);});
})
)

(
~wobblyPiano = {|i|
    if (i <= 111, {
        var note = i;
        var dynamic = 1;
        var octave = floor(note / 12) - 1;
        var degree = note - 24 % 12;
        var noteDeltas = [-1, 0,  1,  2, -1,  0,  1, -2, -1,  0,  1,  2];
        var pitch = noteDeltas[degree];
        var sampledNote = [1,  1,  1,  1,  2,  2,  2,  3,  3,  3,  3,  3];
        var sampleToGet = (octave - 1) * 3 + sampledNote[degree];
        var dynamicOffset = dynamic - 1 * 23;
        sampleToGet = sampleToGet + dynamicOffset;
        Synth.new(\wobPiano, [
            \buf, ~pianoSamples[sampleToGet],
            \rate, pitch.midiratio,
            \pan, rrand(-0.75, 0.75),
            \out, ~reverbBus
        ]);
    });
}
)

(
SynthDef(\wobPiano, {
    arg buf = ~pianoSamples[0], rate = 1, spos = 0, pan = 0, amp = 1, out = ~limitBus;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: 2000, doneAction: 2);
    sig = sig * amp * 20 * env * SinOsc.kr(3);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)
