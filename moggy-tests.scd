~kalimbaBuf = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/p5/Signes-Vitaux-3/SuperCollider/kalimba.aif");
~kalimbaBuf.numFrames;
~kalimbaBuf.numChannels;
7144448/14400/2/60;
(
SynthDef(\kalimba, {
    arg buf = ~kalimbaBuf, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, ~kalimbaBuf, rate * BufRateScale.ir(buf), startPos: spos * 1002701);
    sig = sig * env;
    sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

(
~kalimba.stop;
~kalimba = Pbind(
    \instrument, \kalimba,
    \dur, 1,
    \spos, Pseq([0.1, 0.12], inf),
    \rel, 1.7,
//     \atk, 0.7,
    \rate, 1 * Pseq([0].stutter(4).midiratio, inf),
    \amp, 10,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, ~reverbBus
).play(t, quant: 1);
)

(
~kalimba2.stop;
~kalimba2 = Pbind(
    \instrument, \kalimba,
    \dur, 1/2,
    \spos, Pseq([0.46, 0.569], inf),
    \rel, 1.75,
//     \atk, 0.1,
    \rate, 1 * Pseq([0].stutter(16).midiratio, inf),
    \amp, 10,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, ~reverbBus
).play(t, quant: 1);
)



(
~eliBus = Bus.audio(s,2);
SynthDef(\reverb_ef, {
        arg	amp=1, lPos=0, mix=0.085, revTime=1.8, preDel=0.1, in, out;
        var sig, verbSig, totalSig, outSig;
    //no wacky values please
        mix = mix.clip(0,1);
        sig = In.ar(in, 2);
//pre-delay
        verbSig = DelayN.ar(sig, preDel, preDel);
        totalSig = 0;
        12.do{
            verbSig = AllpassN.ar(verbSig, 0.06, {Rand(0.001,0.06)}!2, revTime);
            verbSig = LPF.ar(verbSig, 4500);
            totalSig = totalSig + verbSig;
};
		//dry/wet mix
        totalSig = XFade2.ar(sig, totalSig, mix.linlin(0,1,-1,1));
        outSig = totalSig * amp;
        Out.ar(out, outSig);
}).add;
)

(
~eliSynth.free;
~eliSynth = Synth.new(\reverb_ef, [\in, ~eliBus, \out, 0], ~fxGroup);
)

(
SynthDef(\filtSaw, {
arg     freq=440, detune=3.0, atk=6, sus=4, rel=6, curve1=1, curve2=(-1),
minCf=30, maxCf=6000, minRq=0.005, maxRq=0.04,
minBpfHz=0.02, maxBpfHz=0.25,
lowShelf=220, rs=0.85, db=6,
gate=1, amp=1, spread=1.0, out=0;
var sig, env;
env = EnvGen.kr(Env([0,1,1,0],[atk,sus,rel],[curve1,0,curve2]), gate, levelScale:amp, doneAction:2);
sig = Saw.ar(
freq +
LFNoise1.kr({LFNoise1.kr(0.5).range(0.15,0.4)}!8).range(detune.neg,detune));
sig = BPF.ar(
sig,
LFNoise1.kr({LFNoise1.kr(0.13).exprange(minBpfHz,maxBpfHz)}!8).exprange(minCf, maxCf),
LFNoise1.kr({LFNoise1.kr(0.08).exprange(0.08,0.35)}!8).range(minRq, maxRq)
);
sig = BLowShelf.ar(sig, lowShelf, rs, db);
sig = SplayAz.ar(4, sig, spread);
sig = sig * env * 2;
Out.ar(out, sig);
}).add;
)

(
var cfLo, trnsp;
trnsp = rrand(-7,7);
cfLo = (([23,35,47,50,52,59,61,63,64,76,78].choose) + trnsp).midicps * ((1..8).choose);
Synth(\filtSaw, [
    \freq, 220,
    \detune, 0,
    \minBpfHz, 0.01,
    \maxBpfHz, 220.expexp(1.0,16.0,0.1,16.0),
    \minRq, 0.003,
    \maxRq, exprand(0.008,0.08),
    \minCf, cfLo,
    \maxCf, cfLo * [1,1.1,1.5].wchoose([0.87,0.1,0.03]),
    \amp, exprand(0.15,0.25),
    \atk, exprand(0.7,8),
    \atk, 0.001,
    \rel, 1,
    \sus, rrand(6,10.0),
    \spread, exprand(1.5,8.0),
    \out, ~eliBus,
]);
)

(
// {[1,2,3,4,6,8,12,16].wchoose([7,6,5,4,3,3,1].normalizeSum)};
)



(
SynthDef("Moog",{
    arg oscType =0, oscType2 = 1, pan = 0, level = 0.5, cutoff = 500, gain = 3.3, attack = 0.1, decay = 0.1, sust = 0.7, rel = 0.2, attackf = 0.1, decayf = 0.1, sustf = 0.9, relf = 0.2, gate = 1, freq =440, out = 0;
    var oscArray = [Saw.ar(freq ), LFTri.ar(freq * 0.501), Pulse.ar(freq)];
    var oscArray2 = [Saw.ar(freq), SinOsc.ar(freq), Pulse.ar(freq)];
    var sig3 = Pulse.ar(freq * 1.001);
    var ampEnv = EnvGen.ar(Env.adsr(attack, decay, sust, rel), gate, doneAction:2);
    var filterEnv = EnvGen.ar(Env.adsr(attackf, decayf, sustf, relf), gate, doneAction:2);
    var osc1 = Select.ar(oscType, oscArray);
    var osc2 = Select.ar(oscType2, oscArray2);
    // var fade = XFade2.ar(osc1, osc2, pan , level * ampEnv);
    var fade = osc1 * osc2 * sig3 * level * ampEnv;
    var filter = osc1 * MoogFF.ar(fade, cutoff * filterEnv, gain);
    filter = Balance2.ar(filter, filter, pan, 1);
    Out.ar(out, filter);
}).store;
)
LFSaw
Saw

x = Synth.new("Moog", [\attackf, 2, \rel, 1.5, \relf, 2, \out, 0, \oscType, 1, \oscType2, 0, \cutoff, 2000]);
x.set(\gate, 0);

y = Synth.new("Moog", [\level, 2, \freq, ~toFreq.("F4"), \attackf, 2, \rel, 1.5, \relf, 2, \out, 0, \oscType, 1, \oscType2, 0, \cutoff, 2000]);
y.set(\gate, 0);

z = Synth.new("Moog", [\level, 2, \attack, 0.75, \freq, ~toFreq.("F4") * 4.midiratio, \attackf, 2, \rel, 1.5, \relf, 2, \out, 0, \oscType, 1, \oscType2, 0, \cutoff, 2000]);
z.set(\gate, 0);
(
var sc1 = Scale.major.degrees.midiratio * ~toFreq.("F3");
var sc2 = Scale.minor.degrees.midiratio * ~toFreq.("D3");
~moogy.stop;
~moogy = Pbind(
    \instrument, "Moog",
//     \freq, Pseq([440, 440 * 5.midiratio, 440 * 7.midiratio], inf) * Pseq([0.5, 1].stutter(8), inf) * -3.midiratio,
//     \freq, ~toFreq.("G#4") * Pseq([0, -5].stutter(32).midiratio, inf) * Pseq([0, 4, 0, 5].stutter(2).midiratio, inf),

    \freq, Pseq([[sc1[0], sc1[2], sc1[3]].stutter(4),
    [sc2[0], sc2[2], sc2[3]].stutter(4)], inf),


    \freq, Pseq([[sc1[0], sc1[3], sc1[5]].stutter(4),
    [sc2[0], sc2[3], sc2[5]].stutter(4)], inf),

            \freq, Pseq([sc1[0], sc1[3], sc1[5], sc1[3],
    sc2[0], sc2[3], sc2[5], sc2[4]].stutter(4), inf) * Pseq([0.5, 1], inf),

    \freq, ~toFreq.("F#4") * Pseq([Prand([0, 4, 7, 11, 14].midiratio, 1)], inf),

    \dur, Prand([0.25, 0.25, 0.25, 0.125, 0.125, Rest(2)], inf),
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
    \cutoff, Pseq([Pgeom(600, 1.1, 20)], inf),
    \pan, Pwhite(-0.5, 0.5, inf),
    \level, 0.5,
    \out, 0
).play(quant: 1);
)

(
SynthDef(\drums, {
|out = 0, bassLevel = 0 , snareLevel = 0, hatLevel = 0, tomLevel = 0, pan1 = 0, pan2 = 0, pan3 = 0, pan4 = 0|
var env1, env2, env3, env4, bass, snare, hat, tom, bassOut, snareOut, hatOut, tomOut, mixer;
env1 = EnvGen.kr(Env.perc(0.001, 0.2, 1, -4), 1, doneAction:2);
env2 = EnvGen.kr(Env.perc(0.001, 0.5, 1, -1), 1, doneAction:2);
env3 = EnvGen.kr(Env.perc(0.002, 0.3, 1, -2), 1, doneAction:2);
env4 = EnvGen.kr(Env.perc(0.001, 0.1, 1, -5), 1, doneAction:2);
bass = SinOsc.ar(80) + Crackle.ar(1, 0.5);
bassOut = Pan2.ar(bass*env1, pan1, bassLevel);
snare = SinOsc.ar(120) - WhiteNoise.ar(0.5, 0.5);
snareOut = Pan2.ar(snare*env4, pan2, snareLevel);
hat = Klank.ar(Ref([
    [ 6563, 9875 ],
    [ 0.6, 0.5 ],
    [ 0.002, 0.003]
    ]), PinkNoise.ar(1));
hatOut = Pan2.ar(hat*env3, pan2, hatLevel);
tom = SinOsc.ar(440);
tomOut = Pan2.ar(tom*env4, pan4, tomLevel);
mixer = Mix.new([bassOut, snareOut, hatOut, tomOut]);
Out.ar(out, mixer);
}).store
)

(
SynthDef("lpfandmideq", { arg out;
var audio, efx, f;
f = SinOsc.kr(3, 0, 24, 84).midicps;
audio = In.ar(20,2);
efx= MidEQ.ar(LPF.ar(audio, f), f, 0.5, 18, 0.6);
Out.ar(out, efx);
}).store;
)

(
a = Synth.after(1, "lpfandmideq");
)

(
p.stop;
a = Pseq ([1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0]);
b = Pseq ([0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0]);
c = Pseq ([0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0]);
d = Pseq ([0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1]);
e = Pwhite (0.14, 0.16, inf);
p = Pbind(
\instrument, \drums,
\out, 20,
\dur, e,
\bassLevel, Pseq ([a], inf),
\snareLevel, Pseq ([b], inf),
\hatLevel, Pseq ([c], inf),
\tomLevel, Pseq ([d], inf)
).play;
)

