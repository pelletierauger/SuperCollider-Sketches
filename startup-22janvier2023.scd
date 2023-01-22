// The ~toFreq function below is borrowed (and slightly adapted) from Derek Kwan.
// The original function can be found here:
// https://github.com/derekxkwan/sc-miscellany/blob/master/note-to-midi.scd
// Both the original and my fork are free software
// licensed under the GNU General Public License v3.0.

(
~toMidi = {|note|
    var cleaned = note.asString.toLower;
    var octave_pair = cleaned.findRegexp("[0-9]+");
    var octave = if(octave_pair.size > 0, octave_pair[0][1], 4).asInt;
    var my_note = if(octave_pair.size > 0, cleaned.copyFromStart(octave_pair[0][0] - 1), cleaned);
    var note_name = my_note[0].asString;
    var midinote = 0;
    var detune = 0;
    if(my_note.size > 1,
        switch(my_note.copyToEnd(1),
            "b", {detune = -1},
            "bb", {detune = -2},
            "#", {detune = 1},
            "##", {detune = 2}
    ));
    switch(note_name,
        "c", {midinote = 12},
        "d", {midinote = 14},
        "e", {midinote = 16},
        "f", {midinote = 17},
        "g", {midinote = 19},
        "a", {midinote = 21},
        "b", {midinote = 23}
    );
    midinote = (midinote + (octave.clip(0,99999) * 12)) + detune;
};
~toFreq = {|note|
    ~toMidi.(note).midicps;
};
~toNote = {|num|
    var notes = [
        ["C"], ["C#", "Db"], ["D"], ["D#", "Eb"],
        ["E"], ["F"], ["F#", "Gb"], ["G"] ,
        ["G#", "Ab"], ["A"], ["A#", "Bb"], ["B"]];
    var oct = (num / 12).floor;
    var noteName = notes[num - (oct * 12)];
    noteName.collect({|i, item| i ++ (oct - 1)});
};
~recordingFolder = thisProcess.platform.recordingsDir;
~recFolder = thisProcess.platform.recordingsDir;
~rec = thisProcess.platform.recordingsDir;
~ro = {~rec.openOS};
Server.local.options.memSize = 2.pow(20);
Server.local.options.memoryLocking = true;
Server.local.options.sampleRate = 48000;
Safety(s).disable;
~lfo = {|f,b=0,e=1|SinOsc.kr(f).unipolar.linlin(0,1,b,e)};
~v = {|in,f=500,r=0,t=1|VadimFilter.ar(in,f,r,t)};
// ClockBus
~nT = TempoClock.new(1).permanent_(true);
~cb = Bus.control(s, 2);
~tks = {
    |i = 0, gate = 1|
    // tr reads control rate impulse from ~cb.
    var tr = In.kr(~cb, 2) * gate;
    // d goes from 0 to 1 once the first downbeat plays.
    var d = Demand.kr(tr[0], 0, Dseq([1]));
    // t starts to send triggers once d is 1.
    var t = tr[i] * d;
    [t, d];
};
SynthDef.new(\tick, {
    arg beat, subd;
    var sig = Impulse.kr(0.01);
    Line.kr(0, 1, 0.1, doneAction: 2);
    Out.kr(~cb, sig * [beat, subd]);
}).add;
~ticking = {
    ~ticks.stop;
    ~ticks = Pbind(
        \instrument, \tick,
        \dur, 0.25,
        \beat, Pseq([1, 0, 0, 0], inf),
        \subd, Pseq([1, 1, 1, 1], inf)
    ).play(~nT, quant: 4);
};
CmdPeriod.remove(~ticking);
CmdPeriod.add(~ticking);
~ticking.();
~div8 = {
    | in |
    in + DelayN.kr(in, ~nT.beatDur / 8, ~nT.beatDur / 8);
};
~div16 = {
    | in |
    in + DelayN.kr(in, ~nT.beatDur, ~nT.beatDur / 16 * (1..3)).sum;
};
~div32 = {
    | in |
    in + DelayN.kr(in, ~nT.beatDur, ~nT.beatDur / 32 * (1..7)).sum;
};
)