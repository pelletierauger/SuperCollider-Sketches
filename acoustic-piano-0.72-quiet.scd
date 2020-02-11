(
var pianoSamples, pianoFolder, makeLookUp, indices, pitches;

pianoSamples = Array.new;
pianoFolder = PathName.new("/Users/guillaumepelletier/Downloads/21055__samulis__vsco-2-ce-keys-upright-piano/");
pianoFolder.entries.do({
    |path, i|
    if (i < 46, {
        pianoSamples = pianoSamples.add(Buffer.read(s, path.fullPath));
    });
});

makeLookUp = {
    |note, dynamic|
    var octave = floor(note / 12) - 1;
    var degree = note - 24 % 12;
    var noteDeltas = [-1, 0,  1,  2, -1,  0,  1, -2, -1,  0,  1,  2];
    var pitch = noteDeltas[degree].midiratio;
    var sampledNote = [1,  1,  1,  1,  2,  2,  2,  3,  3,  3,  3,  3];
    var sampleToGet = (octave - 1) * 3 + sampledNote[degree];
    var dynamicOffset = dynamic - 1 * 23;
    sampleToGet = sampleToGet + dynamicOffset;
    [sampleToGet, pitch];
};
indices = 2.collect({|j| (20..110).collect({|i| makeLookUp.(i, j + 1)[0]})}).flat;
pitches = 2.collect({|j| (20..110).collect({|i| makeLookUp.(i, j + 1)[1]})}).flat;

Event.addEventType(\pianoEvent, {
    var index;
    if (~num.isNil, {~num = 60}, {~num = floor(min(max(20, ~num), 110))});
    if (~dyn.isNil, {~dyn = 0}, {~dyn = floor(min(max(0, ~dyn), 1))});
    index = ~num - 20 + (~dyn * 91);
    ~buf = pianoSamples[indices[index]];
    ~rate = pitches[index];
    ~instrument = \pianoSynth;
    ~type = \note;
    currentEnvironment.play;
});

SynthDef(\pianoSynth, {
    arg buf = pianoSamples[0], rate = 1, spos = 0, pan = 0, amp = 1, out = 0, atk = 0, sus = 0, rel = 8;
    var sig, env;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, sus, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos, doneAction: 2);
    sig = sig * amp * 18 * env;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)
