// https://ccrma.stanford.edu/~juhan/vas.html

{ BlitB3Square.ar(XLine.kr(1000, 20, 10)) }.play;

{ BlitB3Square.ar(MouseX.kr(20,1000,'exponential'),MouseY.kr(0.001,0.999)) }.play;

//comparison
//blit version is cheaper, but aliases once pushed over 4000 or so at 44100 SR
{ Pulse.ar(4000, 0.5) }.play;
{ BlitB3Square.ar(4000) }.play;


//spot the difference in CPU usage
{ Mix.fill(100, {Pan2.ar(0.1*BlitB3Square.ar( ((LFNoise0.kr(rrand(2,3))).range(0,36)+36).midicps), 1.0.rand2) }) }.play;

{ Mix.fill(100, {Pan2.ar(0.1*Pulse.ar( ((LFNoise0.kr(rrand(2,3))).range(0,36)+36).midicps, 0.5), 1.0.rand2) }) }.play;

(
{
    var sig = BlitB3Square.ar(220!2);
    LPF.ar(sig, 220);
}.play;
)


(
{
    var sig = BlitB3Square.ar(110!2, leak: SinOsc.ar(0.5).range(0.1, 0.99));
    LPF.ar(sig, 220);
    sig;
}.play;
)

(
{
    var freq = 110!2 * -12.midiratio;
    var op3 = BlitB3Tri.ar(freq * 0.5, leak: SinOsc.ar(0.4, pi).range(0.1, 0.99), leak2: 0.99);
    var op2 = BlitB3Tri.ar(freq, leak: SinOsc.ar(0.1, 2pi).range(0.1, 0.99), leak2: 0.99);
    var op1 = BlitB3Tri.ar(freq, leak: SinOsc.ar(0.1).range(0.1, 0.5), leak2: 0.99);
    var sig = op1 * op2 * op3;
    sig = op1;
    // sig = sig * op3;
    // sig = LFTri.ar(110!2);
    sig = HPF.ar(sig, 1600);
    sig = op2 * sig;
    sig;
}.play;
)

x = {MoogFF.ar(Mix(LeakDC.ar( Integrator.ar(BlitB3.ar(MouseX.kr(0.125,4)*[220,221,223,224], 0.125), 0.99)) ), MouseY.kr(200,10000,'exponential'),3) }.play;

{ BlitB3Tri.ar(XLine.kr(1000, 20, 10)) }.play;

//unfortunately, aliasing returns at higher frequencies (over 5000Hz or so) with a vengence
{ BlitB3Tri.ar(MouseX.kr(20,8000,'exponential').poll,0.99,MouseY.kr(0.001,0.99)) }.play;

//more efficient, some aliasing from 3000, but not so scary over 5000. Duller sound (less high harmonics included for lower fundamentals)
{ LFTri.ar(MouseX.kr(20,8000,'exponential').poll) }.play;


//comparison
//LFTri version cheaper, and less aliasing!
x = { LFTri.ar(4000) }.play;
x = { BlitB3Tri.ar(4000) }.play;

(
var dur = 1;
{
    var freq = 110!2 * -4.midiratio;
    var op3 = BlitB3Tri.ar(freq * 0.5, leak: SinOsc.ar(0.4, pi).range(0.1, 0.99), leak2: 0.99);
    var op2 = BlitB3Tri.ar(freq, leak: SinOsc.ar(0.1, 2pi).range(0.1, 0.99), leak2: 0.99);
    var op1 = BlitB3Tri.ar(freq, leak: 0.99, leak2: 0.99);
    var sig = LFTri.ar(freq) * 12;
    sig = op1 * 1.5;
    // sig = sig * op3;
    // sig = LFTri.ar(110!2);
    sig = LPF.ar(sig, Line.kr(15600, 50, dur, doneAction: 2));
// sig = op2 * sig;
    sig * Line.kr(1, 0, dur);
}.play;
)

(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    var dur = 8;
{
        var freq = (num.midicps)!2 * (-12).midiratio * [[1, 1.001], [1.001, 1]].choose;
    var op3 = BlitB3Tri.ar(freq * 8, leak: SinOsc.ar(0.2, pi).range(0.5, 0.9), leak2: 0.99);
    var op2 = BlitB3Tri.ar(freq, leak: SinOsc.ar(0.1, 2pi).range(0.5, 0.9), leak2: 0.99);
    var op1 = BlitB3Tri.ar(freq, leak: SinOsc.ar(0.1, 2pi).range(0.5, 0.9), leak2: 0.99);
    var sig = LFTri.ar(freq) * 12;
    var loaf = SinOsc.ar(6).range(0.1, 0.5);
        sig = op1 * 1.5 * op2 * (1 + (op3 * 0.5 + 0.5 * loaf));
    // sig = sig * op3;
    // sig = LFTri.ar(110!2);
    sig = LPF.ar(sig, Line.kr(15600, 50, dur, doneAction: 2));
// sig = op2 * sig;
        LeakDC.ar(sig * Line.kr(1, 0, dur) * 0.0125 * 4);
}.play;
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)



(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
var max = 60.0;
var dur = 4;
var flipPan = [[1, 1.001], [1.001, 1]].choose;
    var note = num.midicps!2 * flipPan;
{
    var op3 = SinOsc.ar(note) * SinOsc.kr(3).range(0.25, 1);
    var op2 = SinOsc.ar(note * 1, op3 % 2pi) * Line.ar(0, max, dur);
    var op1 = SinOsc.ar(note, op2 % 2pi) * XLine.ar(0.1,0.0001, dur, 1, 0, 2);
        // LPF.ar(op1, 600) * 2;
    var sig = LPF.ar(op1, Line.kr(15600, 50, dur, doneAction: 2));
        op1 * 0.1;
}.play;
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)



(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    var dur = 2;
{
        var freq = (num.midicps)!2 * (-12).midiratio * [[1, 1.001], [1.001, 1]].choose;
    var op3 = BlitB3Tri.ar(freq * 0.25, leak: SinOsc.ar(0.4, pi).range(0.1, 0.9), leak2: 0.99);
    var op2 = BlitB3Tri.ar(freq, leak: SinOsc.ar(0.1, pi).range(0.1, 0.9), leak2: 0.99);
    var op1 = BlitB3Tri.ar(freq, leak: SinOsc.ar(0.1, 2pi).range(0.1, 0.9), leak2: 0.99);
    var sig = LFTri.ar(freq) * 12;
    var loaf = SinOsc.ar(6).range(0.1, 0.9);
        sig = op1 * 1.5 * op2 * (1 + (op3 * 0.5 + 0.5 * loaf));
    // sig = sig * op3;
    // sig = LFTri.ar(110!2);
    sig = LPF.ar(sig, Line.kr(5600, 50, dur, doneAction: 2));
// sig = op2 * sig;
        LeakDC.ar(sig * Line.kr(1, 0, dur) * 0.0125 * 4);
}.play;
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)


(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    var dur = 4;
{
        var freq = (num.midicps)!2 * (-12).midiratio * [[1, 1.001], [1.001, 1]].choose;
    var op3 = BlitB3Square.ar(freq * 8, leak: SinOsc.ar(0.4, pi).range(0.1, 0.9));
    var op2 = BlitB3Square.ar(freq, leak: SinOsc.ar(0.1, pi).range(0.1, 0.9));
    var op1 = BlitB3Square.ar(freq, leak: SinOsc.ar(0.1, 2pi).range(0.1, 0.9));
    var sig = LFTri.ar(freq) * 12;
    var loaf = SinOsc.ar(6).range(0.1, 0.9);
        sig = op1 * 1.5 * op2 * (1 + (op3 * 0.5 + 0.5 * loaf));
        // sig = op1 * op2;
    // sig = sig * op3;
    // sig = LFTri.ar(110!2);
    sig = LPF.ar(sig, Line.kr(600, 50, dur, doneAction: 2));
// sig = op2 * sig;
        LeakDC.ar(sig * Line.kr(1, 0, dur) * 0.0125 * 16 * 2);
}.play;
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)

// short and punchy
(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    var dur = 2;
{
        var freq = (num.midicps)!2 * (-12).midiratio * [[1, 1.001], [1.001, 1]].choose;
    var op3 = BlitB3Square.ar(freq * 8, leak: SinOsc.ar(0.4, pi).range(0.1, 0.9));
    var op2 = BlitB3Square.ar(freq, leak: SinOsc.ar(0.1, pi).range(0.1, 0.9));
    var op1 = BlitB3Square.ar(freq, leak: SinOsc.ar(0.1, 2pi).range(0.1, 0.9));
    var sig = LFTri.ar(freq) * 12;
    var loaf = SinOsc.ar(6).range(0.1, 0.9);
        sig = op1 * 1.5 * op2 * (1 + (op3 * 0.5 + 0.5 * loaf));
        // sig = op1 * op2;
    // sig = sig * op3;
    // sig = LFTri.ar(110!2);
    sig = LPF.ar(sig, Line.kr(600, 50, 0.5, doneAction: 2));
// sig = op2 * sig;
        LeakDC.ar(sig * Line.kr(1, 0, dur) * 0.0125 * 16);
}.play;
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)

(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    var dur = 1;
{
        var freq = (num.midicps)!2 * (0).midiratio * [[1, 1.001], [1.001, 1]].choose;
    var op3 = BlitB3Saw.ar(freq * 2, leak: SinOsc.ar(0.1, 2pi).range(0.1, 0.9));
    var op2 = BlitB3Saw.ar(freq, leak: SinOsc.ar(0.1, pi).range(0.1, 0.9));
    var op1 = BlitB3Saw.ar(freq, leak: SinOsc.ar(0.1, 2pi).range(0.1, 0.9));
    var sig = LFTri.ar(freq) * 12;
    var loaf = SinOsc.ar(6).range(0.01, 0.99);
        sig = op1 * 1.5 * op2 * (1 - (op3 * 0.5 + 0.5 * loaf));
        // sig = op1 * op2;
    // sig = sig * op3;
    // sig = LFTri.ar(110!2);
        sig = sig + (LPF.ar(sig, 150) * 10);
    sig = LPF.ar(sig, Line.kr(600, 150, 0.11));
// sig = op2 * sig;
        LeakDC.ar(sig * Line.kr(1, 0, 0.2, doneAction: 2) * 0.8);
}.play;
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)