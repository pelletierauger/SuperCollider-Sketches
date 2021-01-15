(
var sw = 0.01;
~sPA.stop;
~sPA = Pbind(
    \instrument, \sampler,
    \dur, Pseq([4, 3 - sw, 3 + sw, 4 - sw, 4 + sw, 2] / 4, inf),
    \spos, 0,
    \atk, 0.001,
    \susT, 0.6,
    \rel, 0.001,
    \rate, Pseq([-5, -5, -5, -5, -4, -4].midiratio, inf),
    \amp, Pseq([2, 1, 1.5, 1, 1.75, 1.5], inf) * 1.4,
    \pan, 0,
    \out, 0,
    \buf, ~softPluckA,
    \buf, Pseq([~softPluckA].stutter(4) ++ [~softPluckB].stutter(2), inf)
).play(~nT, quant: [5, 0]);
~sPC.stop;
~sPC = Pbind(
    \instrument, Pseq([\samplerBeeFlip, \samplerBee], inf),
    \dur, Pseq([4, 3 - sw, 3 + sw, 4 - sw, 4 + sw, 2] / 4, inf),
    \spos, 0.047,
    \atk, 0.001,
    \susT, 1.1,
    \rel, 0.001,
    \rate, -2.midiratio,
    \amp, Pseq([2, 1, 2, 1, 2, 1], inf) * 0.75,
    \pan, 0,
    \out, 0,
    \buf, ~softPluckC
).play(~nT, quant: [5, 0]);
[~noLow2].do({|i| i.set(\gate, 0, \fadeTime, 1)});

~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.25 + (~nT.beatDur * 0), {
    ~noLow2 = {
        var trig = Impulse.kr(1 / (~nT.beatDur * 5));
        var notes = Demand.kr(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.kr(trig, 0, Dseq([0.5, 0.9], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 12,
            timbre: dem2 * 0.5,
            color: 0.0 + dem2 + [0, 0.01],
            model: 4,
            resamp: 2,
            decim: 32,
            bits: 4,
            ws: 0
        );
        sig = HPF.ar(sig, 500);
        sig = LPF.ar(sig, 3000);
        sig * 0.75 * 0.5 * 0.4 * 4;
    }.play(fadeTime: 0.1);
});
)



(
~sPA.stop;
~sPA = Pbind(
    \instrument, \sampler,
    // \dur, 8 / (122/60),
    \dur, 1 / 4,
    \spos, 0,
    // \rel, 0.1,
    \atk, 0.001,
    \susT, 0.4 * 1,
    \rel, 0.001,
    \rate, 1 * Pseq([-5].midiratio.stutter(12) ++ [-4].midiratio.stutter(8), inf),
    \amp, Pseq([1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0], inf) * 1,
    \pan, 0,
    \out, 0,
    \buf, ~softPluckA,
    \buf, Pseq([~softPluckA].stutter(12) ++ [~softPluckB].stutter(8), inf)
).play(~nT, quant: [5, 0]);
// [1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0];
~sPC.stop;
~sPC = Pbind(
    // \instrument, \samplerBee,
    \instrument, Pseq([\samplerBeeFlip, \samplerBee], inf),
    // \dur, 8 / (122/60),
    \dur, 1 / 4,
    \spos, 0.05,
    // \rel, 0.1,
    \atk, 0.001,
    \susT, 1,
    \rel, 0.001,
    \rate, 1 * -2.midiratio,
    \amp, Pseq([1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0], inf) * 0.75,
    \pan, 0,
    \out, 0,
    \buf, ~softPluckC
    // \buf, Pseq([~softPluckA, ~softPluckA, ~softPluckB, ~softPluckB], inf)
).play(~nT, quant: [5, 0]);
/*~sPE.stop;
~sPE = Pbind(
    \instrument, \samplerBee,
    \dur, Pseq([1], inf),
    \spos, 0,
    \atk, 0.001,
    \susT, 0.2 * 2,
    \rel, 2,
    \rate, 0.25 * Pseq([-5, -7].midiratio.stutter(5), inf),
    \amp, 1.95,
    \pan, 0,
    \out, 0,
    \buf, Pseq([~softPluckB, ~softPluckB], inf)
).play(~nT, quant: [5, -0.05]);*/
)


(
~sPA.stop;
~sPA = Pbind(
    \instrument, \sampler,
    // \dur, 8 / (122/60),
    \dur, 1 / 4,
    \spos, 0,
    // \rel, 0.1,
    \atk, 0.001,
    \susT, 0.4 * 1,
    \rel, 0.001,
    \rate, 1 * Pseq([-5].midiratio.stutter(20), inf),
    \amp, Pseq([1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0], inf) * 1,
    \pan, 0,
    \out, 0,
    \buf, ~softPluckA,
    \buf, Pseq([~softPluckA], inf)
).play(~nT, quant: [5, 0]);
~sPC.stop;
~sPC = Pbind(
    // \instrument, \samplerBee,
    \instrument, Pseq([\samplerBeeFlip, \samplerBee], inf),
    // \dur, 8 / (122/60),
    \dur, 1 / 4,
    \spos, 0.05,
    // \rel, 0.1,
    \atk, 0.001,
    \susT, 1,
    \rel, 0.001,
    \rate, 1 * -2.midiratio,
    \amp, Pseq([1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0], inf) * 0.75,
    \pan, 0,
    \out, 0,
    \buf, ~softPluckC
    // \buf, Pseq([~softPluckA, ~softPluckA, ~softPluckB, ~softPluckB], inf)
).play(~nT, quant: [5, 0]);
)
