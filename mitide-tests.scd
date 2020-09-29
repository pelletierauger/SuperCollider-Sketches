{MiTides.ar(10, 0.2, 0.7, output_mode: 3)}.plot(1)

// mode: PHASES
{MiTides.ar(3, 0.2, output_mode: 2)}.plot(1)


(   // shape
{
    var shape = LFTri.ar(0.11).range(0,1);
    var out = MiTides.ar(100, shape, output_mode: 2, mul: 0.5);
    out[0]!2;
}.play
)


(   // slope
{
    var slope = LFTri.ar(0.11).range(0,1);
    var out = MiTides.ar(100, 0.5, slope, output_mode: 2, mul: 0.5);
    out[0]!2;
}.play
)


(   // phasing
{
    var shape = 0.2;
    var slope = 0.0;
    var shift = LFNoise1.ar(0.3).range(0,1);  // slightly shift phases
    var smooth = LFNoise1.kr(0.02).range(0.1, 0.9);
    var out = MiTides.ar(70, shape, slope, smooth, shift, output_mode: 2);
    Splay.ar(out);  // 4 channel output mixed to stereo
}.play
)


(   // nice chords + tremolo
{
    var shape = LFTri.ar(0.11).range(0,1);
    var slope = LFTri.ar(0.2).range(0,1);
    var chord = LFNoise1.ar(0.1).range(0.5,1);
    var smooth = SinOsc.ar(LFNoise1.kr(0.2).range(0.1,10)).range(0,0.5);
    var out = MiTides.ar(200, shape, slope, smooth, chord, output_mode: 3, mul: 0.5);
    Splay.ar(out);  // 4 channel output mixed to stereo
}.play
)



(   // amplitude mode
{
    var freq = 0.15;
    var shape = 0.2;
    var slope = 0.2;
    var level = LFTri.ar(0.1).range(0,1);
    var env = MiTides.ar(freq, shape, slope, 0.3, level, output_mode: 1, ramp_mode: 1);
    var sines = SinOsc.ar([200,300,500,900]);
    var out = sines * env;
    Splay.ar(out);  // 4 channel output mixed to stereo
}.play
)

(   // amplitude + trigger input
{
    var freq = LFNoise1.ar(0.8).range(0.2,10);
    var shape = 0.2;
    var slope = 0.2;
    var level = LFNoise1.ar(0.3).range(0,1);
    var trig = LFPulse.ar(2);
    var env = MiTides.ar(freq, shape, slope, 0.3, level, trig: trig, output_mode: 1, ramp_mode: 0);
    var sines = SinOsc.ar([200,300,500,700]);
    var out = sines * env;
    Splay.ar(out);  // 4 channel output mixed to stereo
}.play
)


(   // phasing envs
{
    var freq = 10; //LFNoise1.ar(0.8).range(0.2,10);
    var shape = 0.2;
    var slope = 0.5;
    var shift = LFTri.ar(0.1).range(0,1); //LFNoise1.ar(0.3).range(0,1);
    var trig = LFPulse.ar(5);
    var env = MiTides.ar(freq, shape, slope, 0.5, shift, trig: trig, output_mode: 2, ramp_mode: 0);
    var sines = SinOsc.ar([200,300,500,700]);
    var out = sines * env;
    Splay.ar(out);  // 4 channel output mixed to stereo
}.play
)


(   // gate
{
    var freq = 5;  // attack rate;
    var shape = LFTri.ar(0.13).range(0,1);
    var slope = 0.5;
    var smooth = LFTri.ar(0.1).range(0,1);
    var trig = LFPulse.ar(1);
    var env = MiTides.ar(freq, shape, slope, smooth, 0.8, trig: trig, output_mode: 0, ramp_mode: 0);
    var sine = PMOsc.ar(150, 300, 2);
    var out = sine * env[0];
    out!2
}.play
)


(   // Lightbath -- Loom 4 -- inspired...
{
    var mix, out, del;

    var bpm = 140;
    var period = (60 / bpm) * 6;
    var speed = 1.0 / period;
    var del_times = period / [6, 8];

    var trig = Impulse.kr(speed);
    var clock = Phasor.kr(trig);

    // oscs:
    var pit = TChoose.kr(trig, [67, 60, 65]);
    var shape = LFTri.kr(0.11).range(0,1);
    var slope = LFTri.kr(0.11).range(0.5,0.8);
    var smooth = LFNoise1.kr(0.07).range(0.25,0.7);
    var chord = LFNoise1.kr(0.03).range(0.0,0.5);

    var oscs = MiTides.ar(pit.midicps, shape, slope, smooth, chord);


    // envelopes:
    var envs = MiTides.ar(speed, 0.35, 0, 0.46, 0.92, clock: clock, ratio: 9, rate: 0);
    var scaler = LFNoise1.kr( [0.1, 0.07, 0.11, 0.05] );

    // mix:
    mix = oscs * envs * scaler;

    out = Splay.ar(mix, center: LFTri.kr(0.1));
    del = CombL.ar(out, 2, del_times, 6, mul: 0.5);
    out + del
}.play
)