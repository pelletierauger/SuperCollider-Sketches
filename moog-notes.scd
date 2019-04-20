(
SynthDef("Moog",{
    arg oscType =0, oscType2 = 1, pan = 0, level = 0.5, cutoff = 500, gain = 3.3, attack = 0.1, decay = 0.1, sust = 0.7, rel = 0.2, attackf = 0.1, decayf = 0.1, sustf = 0.9, relf = 0.2, gate = 1, freq =440, out = 0;

/*    var lfo = SinOsc.kr(0.5, mul: 0.5, add:1);
    var lfo2 = SinOsc.kr(12, mul: 0.5, add:1);

    var oscArray = [Saw.ar(freq ), SinOsc.ar(freq), Pulse.ar(freq), LFTri.ar(freq)];

    var oscArray2 = [Saw.ar(freq + lfo2), SinOsc.ar(freq + 1), Pulse.ar(freq + 1), LFTri.ar(freq)];


    var osc1 = Select.ar(oscType, oscArray);
    var osc2 = Select.ar(oscType2, oscArray2);
    var fade = XFade2.ar(osc1, osc2, pan , level * ampEnv);*/
    var filter;
    var sig2 = LFSaw.ar([freq, freq + 1] * 1.005);
    var crazyOsc = SinOsc.kr(0.5, phase: pi, mul: 0.5, add:0.5) * 3;
    var lfo = SinOsc.kr(0.5, phase: 0, mul: 0.5, add:1);
    var lfo2 = SinOsc.kr(0.5, phase: pi, mul: 0.5, add:1);
    var ampEnv = EnvGen.ar(Env.adsr(attack, decay, sust, rel), gate, doneAction:2);
    var filterEnv = EnvGen.ar(Env.adsr(attackf, decayf, sustf, relf), gate, doneAction:2);
    var sig = LFSaw.ar([freq + lfo, freq + lfo2]) * level * ampEnv;
    sig = sig * sig2;
    filter = MoogFF.ar(sig, cutoff * filterEnv * lfo, gain);
    filter = Balance2.ar(filter[0], filter[1], pan, 1);
    Out.ar(out, filter);
}).store;
)

w = {SinOsc.kr(0.5, phase: pi, mul: 0.5, add:0.5) * 3.9}.plot(2);
LFSaw
Saw
2pi
x = Synth.new("Moog", [\gain, 3.25, \attackf, 0.5, \sus, 2, \rel, 2, \rel2, f, \out, 0, \oscType, 3, \oscType2, 0, \cutoff, 4000]);
x.set(\gate, 0);
(

var sc1 = Scale.major.degrees.midiratio * ~toFreq.("G#3");
var sc2 = Scale.minor.degrees.midiratio * ~toFreq.("D#3");
~moogy.stop;
~moogy = Pbind(
    \instrument, "Moog",
//     \freq, Pseq([440, 440 * 5.midiratio, 440 * 7.midiratio], inf) * Pseq([0.5, 1].stutter(8), inf) * -3.midiratio,
//     \freq, ~toFreq.("G#4") * Pseq([0, -5].stutter(32).midiratio, inf) * Pseq([0, 4, 0, 5].stutter(2).midiratio, inf),

    \freq, Pseq([[sc1[0], sc1[2], sc1[3]].stutter(4),
    [sc2[0], sc2[2], sc2[3]].stutter(4)], inf),


//         \freq, Pseq([[sc1[0], sc1[3], sc1[5]].stutter(4),
//     [sc2[0], sc2[3], sc2[5]].stutter(4)], inf),

            \freq, Pseq([sc1[0], sc1[3], sc1[5], sc1[3],
    sc2[0], sc2[3], sc2[5], sc2[4]].stutter(4), inf) * Pseq([0.5, 1], inf),


    \dur, 0.125 * 2,
//     \dur, Prand([Pn(0.125, 8), Rest(0.125)], inf),
    \sust, 3,
    \sustf, 0.4,
    \relf, 2.0,
    \oscType, Pseq([0,0,0,0,0], inf),
    // \oscType, 2,
    \oscType2, Pseq([0,0,2,2,1], inf),
    \cutoff, Pseq([100,599,1000,20,800], inf),
    \cutoff, 1000,
    // \cutoff, Pseq([Pgeom(500, 1.1, 16), Pgeom(1000, 1.1, 16)], inf),
    \cutoff, Pseq([Pgeom(500, 1.1, 16)], inf),
    \pan, Pwhite(-0.5, 0.5, inf),
    \level, 0.3,
    \out, 0
).play(t, quant: 1);
)