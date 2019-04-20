"https://composerprogrammer.com/teaching/supercollider/sctutorial/3.4 Server-side Sequencing and Triggers.html"

{Impulse.ar(MouseX.kr(1,100))}.play;

{Dust.ar(MouseX.kr(1,100))}.play;

{ Stepper.ar(Impulse.ar(100), 0,1,10,1) }.plot(0.3,minval:0,maxval:10);


{ SinOsc.ar(Stepper.ar(Impulse.ar(1), 0,1,3,1)*100,0,0.1) }.play;
{ LFTri.ar(Stepper.ar(Impulse.ar(1), 0,1,3,1)*100 * 5.midiratio,0,0.1) }.play;
{ SinOsc.ar(Stepper.ar(Impulse.ar(1), 0,1,3,1)*100 * 16.midiratio,0,0.1) }.play;
{ LFTri.ar(Stepper.ar(Impulse.ar(1), 0,1,4,1)*100 * 12.midiratio,0,0.1) }.play;

p = ProxySpace.push(s);

p.fadeTime = 0.1;
p.fadeTime = 5;

~pulse = {Impulse.ar(440 * 1)};

~voice2 = { LFTri.ar(441 * 0.25) * SinOsc.ar(Stepper.ar(~pulse, 0, 1, 10, 1) * 100, 0, 0.1); };


~voice1 = { LFTri.ar(440 * 0.25) * SinOsc.ar(Stepper.ar(~pulse, 0, 1, 5, 1) * 360, 0, 0.1); };


~pulse2 = {Impulse.ar(3)};

~voice2 = { SinOsc.ar(Stepper.ar(~pulse2, 0, 1, 4, 1) * 55 * 4, 0, 0.3); };
~voice3 = { SinOsc.ar(Stepper.ar(~pulse2, 0, 1, 4, 1) * 55 * 4 * 7.midiratio, 0, 0.3); };

~voice3 = { SinOsc.ar(55 * [0, 4, 7][Stepper.ar(~pulse2, 0, 1, 4, 1)].midiratio, 0, 0.3); };


~nv = { Saw.ar(Select.kr(Stepper.kr(Impulse.kr(4,0.1),0,0,7,1),[72,63,67,72,55,62,63,60].midicps),0.1) };

~nv = { Saw.ar(Select.kr(Stepper.kr(Impulse.kr(MouseX.kr(1,40),0.1),0,0,7,1),[75,63,67,72,55,62,63,60].midicps),0.1) };

~nv.play;

(
~plot = {
	var source = SinOsc.ar(100);
	//plot both original signal, and the trigger pattern
	[source, Trig1.ar(source,0.001)]
}.plot(0.1);
)


p.pop;

440/8;

~nv.free;
~voice1.play;
~voice2.play;
~voice2.free(5);
~voice3.free(5);
~voice3.play;

[0, 4, 7][1];


{Latch.ar(SinOsc.ar(133), Impulse.ar(100))}.plot(0.5);
{LFTri.ar(440+(200*Latch.ar(SinOsc.ar(13.3), Impulse.ar(10))))*0.2}.play;

{EnvGen.ar(Env([0,1,0],[0.01,0.01]),Impulse.kr(50))}.plot(0.1);

{EnvGen.ar(Env([0,1,0,0.5,-0.4],0.01!4),Impulse.kr(25))}.plot(0.1);

p.push;
p.pop;

{300 + (SinOsc.ar(0.125, 0, 0.5, 0.5) * 400)}.plot(10);

~pulse = {Impulse.kr(0.125 * 2)};
~hearPulse = {~pulse.kr * 2};
~hearPulse.play;
~hearPulse.free;
~pulse2 = {Impulse.kr(0.5)};
~pulse3 = {Impulse.kr(2)};
(
~sylv = {
    arg fmFreq = 2;
    var fund = 110 * -10.midiratio * 4;
    var env = EnvGen.ar(Env(~melo.kr, 0.25!8, curve: \step, loopNode: 0), ~pulse);
    var envf = EnvGen.ar(Env(~arr.kr, 0.25!3), ~pulse2);
    var envAmp = EnvGen.ar(Env([0, 1, 0], 0.25!2), ~pulse3);
    var filFreq = 900 + (SinOsc.ar(0.25, 0, 0.5, 0.5) * 800);
    // envf.plot;
    var sig = SinOsc.ar(fund * env * 0.5) * LFTri.ar(fund * env * fmFreq + envf) * LFTri.ar(fund * env) * 0.4;
    sig = sig * envAmp;
    sig = LPF.ar(sig, filFreq);
    sig + (GVerb.ar(sig * 0.5) * 1) * 2;
};
)
~sylv.set(\fmFreq, 0.502 * 1);
~arr = {[0, 4, 0, 1] * 1};
~melo = {[9, 4, 7, 16, 19, 4, 7, 9].midiratio.reverse.scramble * -7.midiratio};
~sylv.play;
~sylv.free(5);

[0, 4, 7].midiratio;

currentEnvironment;
currentEnvironment == topEnvironment;
Environment.stack;
p.push;
p.pop;
(
~sylv2 = {
    arg fmFreq = 2;
    var fund = 110 * -10.midiratio * 2;
    var env = EnvGen.ar(Env([12, 4, 7, 16, 19, 24, 29, 12].midiratio.scramble, 0.25!8, curve: \step, loopNode: 0), ~pulse);
    var envf = EnvGen.ar(Env(~arr.kr, 0.25!3), ~pulse2);
    var envAmp = EnvGen.ar(Env([0, 1, 0], 0.25!2), ~pulse3);
    var filFreq = 900 + (SinOsc.ar(0.25, 0, 0.5, 0.5) * 800);
    // envf.plot;
    var sig = SinOsc.ar(fund * env * 0.5) * LFTri.ar(fund * env * fmFreq + envf) * LFTri.ar(fund * env) * 0.4;
    sig = sig * envAmp;
    sig = LPF.ar(sig, filFreq);
    sig + (GVerb.ar(sig * 0.5) * 1) * 2;
};
)
~sylv2.play;
~sylv2.free(5);
