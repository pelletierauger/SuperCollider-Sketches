(
SynthDef.new(\nestri, {
        arg out, freq = 220, amp = 1, pan = 0, atk = 0.02, rel = 5;
    var sig, env;
    rel = min(max(rel, 0.001), 10);
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = Nes2Triangle.ar(
        trig: Impulse.kr(1),
        start: LFPulse.kr(0.8, 0, #[0.6, 0.5]),
        counter: LFSaw.kr(0.2, 0, 63.5, 63.5),
        freq: [freq, freq + 1],
        vbl: 0
    );
    sig = sig * env * amp;
    sig = LPF.ar(sig, 2000);
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig * 4);
}).add;
)

Synth.new(\nestri, [\rel, 0.1, \freq, 880]);


(
~pianoB.stop;
~pianoB = Pbind(
    \instrument, \nestri,
    \dur, Pseq([1] * 0.5 * 8, inf),
    \freq, Pseq(440 * [12, 24].midiratio, inf),
    \amp, 0.08 * 4
).play();
)

(
~pianoA.stop;
~pianoA = Pbind(
    \instrument, \nestri,
    \dur, Pseq([1] * 0.5 * 8, inf),
    \freq, Pseq(440 * [-24].midiratio, inf),
    \amp, 0.08 * 1
).play();
)


(
~pianoC.stop;
~pianoC = Pbind(
    \instrument, \nestri,
    \dur, Pseq([1] * 0.5 * 8, inf),
    \freq, Pseq(440 * [-19].midiratio, inf),
    \amp, 0.08 * 1
).play();
)



w = {Nes2Noise.ar(Impulse.kr(2), 1, MouseX.kr(0, 1), MouseY.kr(0, 15)) * 0.1}.play
{Nes2Noise.ar(Impulse.kr(10), 0, 1, 10, MouseX.kr(0, 1), MouseY.kr(0, 15))}.play
{Nes2Noise.ar(Impulse.kr(2), 0, 0, 10, 0, MouseX.kr(0, 15), MouseY.kr(0, 31)) * 0.1}.play

{Nes2Noise.ar(Impulse.kr(4), SinOsc.kr([11, 8], 0, 0.5, 0.5)>SinOsc.kr(0.2, 0, 0.5, 0.5), 0, SinOsc.kr(0.1, pi, 0.5, 0.5)>0.1, 1, SinOsc.kr(0.25, 0, 20, 20).round(5)+1, 31) * 0.1}.play

w = {Nes2Noise.ar(Dust.kr(30), 0, 0, LFNoise0.kr(3, 3.5, 3.5), LFNoise0.kr(3, 0.5, 0.5), LFNoise0.kr(3, 3, 4), LFNoise0.kr(0.3, 15.5, 15.5)).dup * 0.05}.play


w = {LPF.ar(Nes2Noise.ar(Dust.kr(30), 0, 0, LFNoise0.kr(3, 3.5, 3.5), LFNoise0.kr(3, 0.5, 0.5), LFNoise0.kr(3, 3, 4), LFNoise0.kr(0.3, 15.5, 15.5)).dup, 1000) * 0.8}.play

w.set(\gate, 0, \fadeTime, 10);