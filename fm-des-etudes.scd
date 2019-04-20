{ SinOsc.ar( 440 * SinOsc.ar(1), 0, 0.4) }.play;


{ SinOsc.ar( 440, 0, 0.4 * SinOsc.ar(1)) }.play;
// or perhaps using LFPulse (which outputs 1 and 0s if the amp is 1)
{ SinOsc.ar( 440, 0, 0.4 * LFPulse.ar(2)) }.play;

(
{
    var modulator, carrier;
    modulator = SinOsc.ar(MouseY.kr(20, 5), 0, MouseX.kr(5, 20));
    carrier = SinOsc.ar(440 + modulator, 0, 1);
    carrier ! 2 // the output
}.play;
)


// LFSaw
{ SinOsc.ar(LFSaw.kr(4, 0, 200, 400), 0, 0.7) }.play

// LFTri
{ SinOsc.ar(LFTri.kr(4, 0, 200, 400), 0, 0.7) }.play
{ Saw.ar(LFTri.kr(4, 0, 200, 400), 0.7) }.play

// LFPar
{ SinOsc.ar(LFPar.kr(0.2, 0, 400,800),0, 0.7) }.play

// LFCub
{ SinOsc.ar(LFCub.kr(0.2, 0, 400,800),0, 0.7) }.play

// LFPulse
{ SinOsc.ar(LFPulse.kr(3, 1, 0.3, 200, 200),0, 0.7) }.play
{ SinOsc.ar(LFPulse.kr(3, 1, 0.3, 2000, 200),0, 0.7) }.play

// LFOs can also perform at audio rate
{ LFPulse.ar(LFPulse.kr(3, 1, 0.3, 200, 200),0, 0.7) }.play
{ LFSaw.ar(LFSaw.kr(4, 0, 200, 400), 0, 0.7) }.play
{ LFTri.ar(LFTri.kr(4, 0, 200, 400), 0, 0.7) }.play
{ LFTri.ar(LFSaw.kr(4, 0, 200, 800), 0, 0.7) }.play


{SinOsc.ar(440 + SinOsc.ar(MouseX.kr(2,2000,1), 0, MouseY.kr(1,1000)), 0, 0.1)!2}.freqscope;

{SinOsc.ar(220 + SinOsc.ar(440 * 1, 0, SinOsc.ar(0.1, 0, 1000)), 0, 0.1)!2}.freqscope;


(
{
    var modmin1 = SinOsc.ar(440 * 1, 0, 10000);
    var mod0 = SinOsc.ar(440 + modmin1 * 0.25, 0, 0.5, 0.5) * 1000;
    var mod1 = SinOsc.ar(0.1, 0, mod0);
    var mod2 = SinOsc.ar(440 * 1, 0, mod1);
    LFTri.ar(220 + mod2 * 4.midiratio, 0, 0.1)!2;
}.freqscope;
)

(
{ var freq, ratio, modulator, carrier;
freq = LFNoise0.kr(4, 20, 60).round(1).midicps;
ratio = MouseX.kr(1,4);
modulator = SinOsc.ar(freq * ratio, 0, MouseY.kr(0.1,10));
carrier = SinOsc.ar(freq + (modulator * freq), 0, 0.5);
carrier
}.play
)
(
// let's fork it and create a perc Env!
{
    40.do({
            { var freq, ratio, modulator, carrier;
            freq = rrand(60, 72).midicps;
            ratio = MouseX.kr(0.5,2);
            modulator = SinOsc.ar(freq * ratio, 0, MouseY.kr(0.1,10));
            carrier = SinOsc.ar(freq + (modulator * freq), 0, 0.5);
            carrier * EnvGen.ar(Env.perc(0, 1), doneAction:2)
        }.play;
        0.5.wait;
    });
}.fork
)