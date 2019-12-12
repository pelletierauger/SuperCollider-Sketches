(
var f = 220 * 0.midiratio;
{SinOsc.ar(f, (SinOsc.ar(f * 6 * [1, 1.001]) * Line.kr(0, 1, 10))) * 0.1}.play;
)


(
var f = 220 * -5.midiratio;
{
    var osc = SinOsc.kr(0.1).range(0.5, 10);
    var op1 = SinOsc.ar(f * 3 * [1, 1.001]) * SinOsc.kr(0.5, pi/2) * 0.8 * Line.kr(1, 0, 2);
    var op2 = SinOsc.ar(f * 6 * [1.001, 1], op1 * 16) * SinOsc.kr(0.5) * 0.8;
    SinOsc.ar(f, op1 + op2) * 0.4;
}.play;
)

(
var f = 220 * -24.midiratio;
{
    var op1 = SinOsc.ar(f * 0.25);
    var op2 = SinOsc.ar(f * 8, op1 * 64);
    var op3 = SinOsc.kr(0.1).range(0.25, 2);
    var sig = SinOsc.ar(f * [1, 1.001], op1 * op2 * 1 * op3) * 0.1;
    // HPF.ar(sig, 100);
    sig;
}.play;
)

220 * -36.midiratio;
(
var f = 200;
{SinOsc.ar(f, (SinOsc.ar(f * 3) * 1))}.play;
)

{ SinOscFB.ar([400,301], MouseX.kr(0,4),0.3); }.scope;
(
{
    var sig1 = SinOsc.ar(440) * SinOsc.kr(4, pi/2) * 0.1;
    var sig2 = SinOsc.ar(440) * SinOsc.kr(4) * 0.1;
    Balance2.ar(sig1, sig2);
}.play;
)


FM7


(
var f = 880;
var ctlMatrix = [
  [ f * 1, 0, 0.99],
  [ f * 3, 0, 0.87],
  [ f * 5, 0, 0.79],
  [ f * 7, 0, 0.75],
  [ f * 9, 0, 0.72],
  [ f * 11, 0, 0.71]
];
var modMatrix = [
    [0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 1]
];
{
    // var fm = FM7.arAlgo(31, ctlMatrix, 1) * 0.5;
    var fm = FM7.ar(ctlMatrix, modMatrix);
    // Splay.ar(fm, spread:0);
    Mix(fm);
    // fm;
}.play;
)

FreqScope.new(800, 600, 0, server: s);



(
var f = 220 * -24.midiratio;
{
    var op1 = SinOsc.ar(f * 0.25);
    var op2 = SinOsc.ar(f * 8, op1 * 64);
    var op3 = SinOsc.kr(0.1).range(0.25, 2);
    var sig = SinOsc.ar(f * [1, 1.001], op1 * op2 * 1 * op3) * 0.1;
    // HPF.ar(sig, 100);
    sig;
}.play;
f = f * 2;
{
    var op1 = SinOsc.ar(f * 0.25);
    var op2 = SinOsc.ar(f * 8, op1 * 64);
    var op3 = SinOsc.kr(0.1).range(0.25, 2);
    var sig = SinOsc.ar(f * [1, 1.001], op1 * op2 * 1 * op3) * 0.1 * 0.125;
    // HPF.ar(sig, 100);
    sig;
}.play;
)




// La boue près d’un château médiéval
(
var f = 220 * -24.midiratio;
{
    var op1 = SinOsc.ar(f * 0.25);
    var op2 = SinOsc.ar(f * 8, op1 * 64);
    var op3 = SinOsc.kr(0.1).range(0.25, 2);
    var sig = SinOsc.ar(f * [1, 1.001], op1 * op2 * 1 * op3) * 0.1;
    // HPF.ar(sig, 100);
    sig;
}.play;
)

(
var f = 220 * -7.midiratio;
{
    var op1 = SinOsc.ar(f * 0.25);
    var op2 = SinOsc.ar(f * 8, op1 * 64);
    var op3 = SinOsc.kr(0.1, op1 * 2).range(0.25, 2);
    var sig = SinOsc.ar(f * [1, 1.001], op1 * op2 * 1 * op3) * 0.1;
    // HPF.ar(sig, 100);
    sig;
}.play;
)



(
var f = 220 * -12.midiratio;
{
    var op1 = SinOsc.ar(f * 1);
    var op2 = SinOsc.ar(f * 2, op1 * 64);
    var op3 = SinOsc.kr(0.1, op1 * 1).range(0.25, 1);
    var sig = SinOsc.ar(f * [1, 1.001], op1 * op2 * 1 * op3) * 0.1;
    // HPF.ar(sig, 100);
    sig;
}.play;
)


(
var f = 220 * -24.midiratio;
{
    var op1 = SinOsc.ar(f * 0.25);
    var op2 = SinOsc.ar(f * 8, op1 * 64);
    var op3 = SinOsc.kr(0.1).range(0.25, 2);
    var sig = SinOsc.ar(f * [1, 1.001], op1 * op2 * 1 * op3) * 0.1;
    // HPF.ar(sig, 100);
    sig;
}.play;
)
220 * -24.midiratio;

(
// var m = UnaryOpFunction.midiratio;
)


(
{var si=SinOsc,f=55,op1=si.ar(f/4);si.ar(f*[1,1.001],op1*si.ar(f*8,op1*64)*si.kr(0.1).range(1/4,2))*0.1}.play;
)


(
var f = 220 * -12.midiratio;
{
    var op1 = SinOsc.ar(f * 1);
    var op2 = SinOsc.ar(f * 2, op1 * 64);
    var op3 = SinOsc.kr(0.1, op1 * 1).range(0.25, 1);
    var sig = SinOsc.ar(f * [1, 1.001], op1 * op2 * 1 * op3) * 0.1;
    // HPF.ar(sig, 100);
    var env = Env.circle([0, 1, 0], [0.01, 0.05, 1]).kr;
    sig * env;
}.play;
)


(
var f = 220 * -24.midiratio;
{
    var op1 = SinOsc.ar(f * 0.25);
    var op2 = SinOsc.ar(f * 8, op1 * 64);
    var op3 = SinOsc.kr(0.1).range(0.25, 2);
    var sig = SinOsc.ar(f * [1, 1.001], op1 * op2 * 1 * op3) * 0.1;
    // HPF.ar(sig, 100);
    var env = Env.circle([0, 1, 0], [0.01, 0.15, 2]).kr;

    (sig * 0.5) + HPF.ar(GVerb.ar(sig * env,10,10), 400);
}.play;
)