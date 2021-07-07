(
var pianoSamples, pianoFolder, makeLookUp, indices, pitches, dynAmnt, maxDyn, maxNote,
packLocation = "/Users/guillaumepelletier/Downloads/21055__samulis__vsco-2-ce-keys-upright-piano/",
quiet = false;
~playedNotes = Array.fill(110 - 20, {Array.fill(3)});
MIDIClient.init;
MIDIIn.connect;
dynAmnt = if (quiet, {2}, {3});
maxDyn = if (quiet, {1}, {2});
maxNote = if (quiet, {46}, {1e2});
pianoSamples = Array.new;
pianoFolder = PathName.new(packLocation);
pianoFolder.entries.do({
    |path, i|
    if (i < maxNote, {
        pianoSamples = pianoSamples.add(Buffer.read(s, path.fullPath));
    });
});

makeLookUp = {
    |note, dynamic|
    var octave = floor(note / 12) - 2;
    var degree = note % 12;
    var sampledNote = [1,  1,  1,  1,  2,  2,  2,  3,  3,  3,  3,  3];
    var noteDeltas = [-1, 0,  1,  2, -1,  0,  1, -2, -1,  0,  1,  2];
    var dynamicOffset = dynamic * 23;
    var sampleToGet = octave * 3 + sampledNote[degree] + dynamicOffset;
    var pitch = noteDeltas[degree];
    [sampleToGet, pitch];
};
indices = dynAmnt.collect({|j| (20..110).collect({|i| makeLookUp.(i, j)[0]})}).flat;
pitches = dynAmnt.collect({|j| (20..110).collect({|i| makeLookUp.(i, j)[1]})}).flat;

Event.addEventType(\pianoEvent, {
    var index;
    if (~num.isNil, {~num = 60}, {~num = min(max(20, ~num), 110)});
    if (~dyn.isNil, {~dyn = 0}, {~dyn = floor(min(max(0, ~dyn), maxDyn))});
    index = floor(~num) - 20 + (~dyn * 91);
    ~buf = pianoSamples[indices[index]];
    ~rate = (pitches[index] + frac(~num)).midiratio;
    ~instrument = \pianoSynth;
    ~type = \note;
    currentEnvironment.play;
});

SynthDef(\pianoSynth, {
    arg buf = pianoSamples[0], releaseGate = 0, rate = 1, spos = 0,
    pan = 0, amp = 1, out = 0, atk = 0, rel = 0.1;
    var sig, env;
    env = EnvGen.kr(
        Env(
            levels: [1, 1, 0],
            times: [atk, rel],
            releaseNode: 2
        ),
        gate: Trig.kr(releaseGate),
        doneAction: 2
    );
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos);
    sig = sig * amp * 18 * env;
    sig = LPF.ar(sig, 3000);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;

MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    var v = vel.linlin(0, 64, 1, 0);
    var v2 = (abs(vel - 64) / 64).linlin(0, 1, 1, 0);
    var v3 = vel.linlin(64, 127, 0, 1);
    var dyn = 0;
    var index = floor(num) - 20 + (dyn * 91);
    var buf = pianoSamples[indices[index]];
    var rate = (pitches[index] + frac(num)).midiratio;
    ~playedNotes[num - 20][0] = Synth.new(\pianoSynth, [rate: rate, dyn: 0, buf: buf, amp: v]);

    dyn = 1;
    index = floor(num) - 20 + (dyn * 91);
    buf = pianoSamples[indices[index]];
    rate = (pitches[index] + frac(num)).midiratio;
    ~playedNotes[num - 20][1] = Synth.new(\pianoSynth, [rate: rate, dyn: 1, buf: buf, amp: v2]);

    dyn = 2;
    index = floor(num) - 20 + (dyn * 91);
    buf = pianoSamples[indices[index]];
    rate = (pitches[index] + frac(num)).midiratio;
    ~playedNotes[num - 20][2] = Synth.new(\pianoSynth, [rate: rate, dyn: 2, buf: buf, amp: v3]);


};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
MIDIIn.removeFuncFrom(\noteOff, ~noteOff);
~noteOff = {
    arg src, chan, num, vel;
    // ~playedNotes[num - 20][0].isNil.postln;
    ~playedNotes[num - 20][0].set(\releaseGate, 1);
    ~playedNotes[num - 20][1].set(\releaseGate, 1);
    ~playedNotes[num - 20][2].set(\releaseGate, 1);
};
MIDIIn.addFuncTo(\noteOff, ~noteOff);
)

(
var key = 62;
var notes = key + ([0, 3, 7, 10] ++ [-5, 2, 3, 9]);
~pianoRiff.stop;
~pianoRiff = Pbind(
    \type, \pianoEvent,
    \dur, Pseq(0.5!1 ++ (0.25!3), inf),
    \num, Pseq(notes, inf),
    \dyn, Pseq([1, 0, 0, 1], inf),
    \amp, Pseq([0.5, 2, 2, 0.5], inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 4
).play(quant: [2]);
)

(
var key = 62 + 36;
var notes = key + [2, -5, 0, -2];
~pianoRiff2.stop;
~pianoRiff2 = Pbind(
    \type, \pianoEvent,
    \dur, Pseq([0.25, 1.75], inf),
    \num, Pseq(notes, inf),
    \dyn, Pseq([1, 1, 1, 1], inf),
    \amp, Pseq([0.5, 1, 1, 0.5], inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 4
).play(quant: [2]);
)

(
~pianoRiff.stop;
~pianoRiff2.stop;
)