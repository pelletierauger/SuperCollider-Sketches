// MiElements

( // strike input, playing chords (model: strings)
{
    var trig = Impulse.ar(2, 0.01);
    var input = RLPF.ar(trig, 440, 0.1, 7);
    var dem = Demand.ar(trig, 0, Dseq([0.9, 0.3].stutter(4), inf));
    g = dem;
    MiElements.ar(0, trig, pit: 45, geom: g, bright: 0.5, damp: 0.9, model: 2) * 2.5;
}.play
)
( // strike input, playing chords (model: strings)
{
    var trig = Impulse.ar(2, 0.01);
    var input = RLPF.ar(trig, 440, 0.1, 7);
    var dem = Demand.ar(trig, 0, Dseq([0.6, 0.65].stutter(4), inf));
    g = dem;
    MiElements.ar(0, trig, pit: 45, geom: g, bright: 0.5, damp: 0.9, model: 2) * 2.5;
}.play
)
(0..5)
(0..10) / 10
( // strike input, playing chords (model: strings)
{
    var trig = Dust.ar(2);
    var input = RLPF.ar(trig, 440,0.1,7);
    var g = LFNoise1.kr(0.1,0.5,0.5);
    MiElements.ar(0, input, 53, geom: g, bright:0.5, damp:0.9, model:2);
}.play
)

// elements/dsp/voice.cc


/*
In the strings model (2), the resonator plays chords
that can be selected using the geom parameter.
In this model, geom can only have 11 different values:
0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, and 1.0.
Values in between these can be used, but they will be quantized
to the closest lower value.
These 11 values of geom represent 11 different chords, each made of 5 strings.
Below you can see what those chords are.
Each value of geom is paired with an array of 5 pitches and a description.
In the pitches arrays, the values represent the distances in semitones
between a note and the fundamental frequency as defined by the pit parameter.

geom   Resulting five strings chord    Description

0.0    [0.0, -12.0, 0.0, 0.01, 12.0]   Octaves only. One detuned fundamental.
0.1    [0.0, -12.0, 3.0, 7.0, 10.0]    Minor seventh chord.
0.2    [0.0, -12.0, 3.0, 7.0, 12.0]    Minor chord. An octave on top.
0.3    [0.0, -12.0, 3.0, 7.0, 14.0]    Minor chord. A ninth on top.
0.4    [0.0, -12.0, 3.0, 7.0, 17.0]    Minor chord. A fourth on top.
0.5    [0.0, -12.0, 7.0, 12.0, 19.0]   Octaves and fifths.
0.6    [0.0, -12.0, 4.0, 7.0, 17.0]    Major chord. A fourth on top.
0.7    [0.0, -12.0, 4.0, 7.0, 14.0]    Major chord. A ninth on top.
0.8    [0.0, -12.0, 4.0, 7.0, 12.0]    Major chord. An octave on top.
0.9    [0.0, -12.0, 4.0, 7.0, 11.0]    Major seventh chord.
1.0    [0.0, -12.0, 5.0, 7.0, 12.0]    Octaves, a fourth, and a fifth.

Below is a chord progression played with geom and a Demand rate pattern.

*/
(
{
    var trig = Impulse.ar(4, 0.01);
    var chords = Demand.ar(trig, 0, Dseq([0.9, 0.7, 0.2, 0.3].stutter(8), inf));
    var bright = Demand.ar(trig, 0, Dseq((1..8) * 0.1, inf));
    MiElements.ar(0, trig,
        pit: 45,
        geom: chords,
        bright: bright,
        damp: 0.8,
        pos: 1.0 - bright,
        model: 2
    );
}.play;
)

