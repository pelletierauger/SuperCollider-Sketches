MIDIClient.init;
MIDIIn.connect;
s.boot;
s.quit;

(
~pianoSamples = Array.new;
~pianoFolder = PathName.new("/Users/guillaumepelletier/Downloads/21055__samulis__vsco-2-ce-keys-upright-piano/");
~pianoFolder.entries.do({
    arg path;
    ~pianoSamples = ~pianoSamples.add(Buffer.read(s, path.fullPath));
});
)

(
~piano = {|i|
    if (i <= 111, {
        var note = i;
        var dynamic = 2;
        var octave = floor(note / 12) - 1;
        var degree = note - 24 % 12;
        var noteDeltas = [-1, 0,  1,  2, -1,  0,  1, -2, -1,  0,  1,  2];
        var pitch = noteDeltas[degree];
        var sampledNote = [1,  1,  1,  1,  2,  2,  2,  3,  3,  3,  3,  3];
        var sampleToGet = (octave - 1) * 3 + sampledNote[degree];
        var dynamicOffset = dynamic - 1 * 23;
        sampleToGet = sampleToGet + dynamicOffset;
        Synth.new(\piano, [
            \buf, ~pianoSamples[sampleToGet],
            \rate, pitch.midiratio,
            \pan, rrand(-0.75, 0.75),
            \out, 0
        ]);
    });
}
)

(
SynthDef(\piano, {
    arg buf = ~pianoSamples[0], rate = 1, spos = 0, pan = 0, amp = 1, out = ~limitBus;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([1, 0], [8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: 0, doneAction: 2);
    sig = sig * amp * 2 * env;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

(
~myOn = {arg src, chan, num, vel;
    ~piano.(num);
};
MIDIIn.addFuncTo(\noteOn, ~myOn);
)


(
MIDIIn.removeFuncFrom(\noteOn, ~noteOnFunc);
MIDIIn.removeFuncFrom(\noteOff, ~noteOffFunc);
MIDIIn.disconnectAll;
)
