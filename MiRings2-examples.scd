// basics
x = { MiRings2.ar(Impulse.ar(2),  pit: 31 - 5 + 12) * 8}.play
y = { MiRings2.ar(PinkNoise.ar(0.1), pit: 31 - 5 + 12) }.play
x.free
y.free

// using the 'trig' input to excite the resonator
{MiRings2.ar(trig: Dust.kr(0.7), pit: 33, model: 1)}.play

// using the 'pit' input to set MIDI pitch and excite the resonator
{MiRings2.ar(pit: LFNoise0.kr(2).range(30, 50), model: 2)}.play


more:

(  // sympathetic strings (have to love it...)
{
    var trig = Dust.kr(1);
    var pit = Latch.kr(WhiteNoise.kr(), trig).range(30, 60).round;
    var struct = LFNoise2.kr(0.4).range(0,1);

    MiRings2.ar(0, 0, pit, struct, 0.5, 0.7, 0.25, model: 1, poly: 4)
}.play
)


(   // inharmonic string
{
    var trig = Dust.kr(3);
    var trigPit = Dust.kr(0.5);
    var pit = Latch.kr(WhiteNoise.kr(), trigPit).range(30, 60);
    var struct = Latch.kr(PinkNoise.kr(), trig).range(0.1,1);

    MiRings2.ar(0, trig, pit, struct, 0.5, 0.8, model: 2, poly: 4)
}.play
)


(   // simple vibrato
{
    var trig = Dust.kr(0.5);
    var pit = Latch.kr(WhiteNoise.kr(), trig).range(36, 48);
    var vib = SinOsc.kr(3);

    MiRings2.ar(0,0, pit+vib, 0.2, model: 0)
}.play
)


(  // some more vibrato
{
    var note = 48;
    var input = Saw.ar(note.midicps, 0.1);
    var trig = Dust.kr(0.3);
    var pit = Latch.kr(PinkNoise.kr(3), trig);
    var vib = SinOsc.kr(5, 0, LFNoise2.kr(0.2).clip(0,1));

    MiRings2.ar(input, trig, note+pit+vib, 0.2, 0.6, 0.9, intern_exciter: 1)
}.play
)