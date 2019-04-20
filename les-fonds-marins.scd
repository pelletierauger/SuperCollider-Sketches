(
~sourceGroup = Group.new;
~fxGroup = Group.after(~sourceGroup);
~reverbBus = Bus.audio(s, 2);
)

(
SynthDef.new(\reverb, {
    arg in, out = 0;
    var sig, del;
    sig = In.ar(in, 2);


/*    del = CombC.ar(in: sig,
    maxdelaytime: 0.1,
    delaytime: [0.25, 0.26],
    decaytime: 20,
    mul: 1, add: 0);*/
    // del = LPF.ar(del, 600);

    del = JPverb.ar(
        sig,
        \t60.kr(10,           0.05),
        \damp.kr(0,          0.05),
        \size.kr(0.96,          0.05),
        \earlydiff.kr(0.95, 0.05),
        \mdepth.kr(5,        0.05),
        \mfreq.kr(0.1,         0.05),
        \lowx.kr(1,          0.05),
        \midx.kr(1,          0.05),
        \highx.kr(0.25,         0.05),
        \lowband.kr(500,     0.05),
        \highband.kr(2000,   0.05)
    );



	sig = sig + (del * 0.25);
    Out.ar(0, sig);
}).add;
)
~accordsfinaux.set(\gate, 0);
~accordsfinaux.set(\earlydiff, 0.95);
~accordsfinaux.set(\size, 0.96);
~accordsfinaux.set(\mdepth, 5);
~accordsfinaux.set(\mfreq, 0.1);
~accordsfinaux.set(\highx, 0.5);


(
~reverbSynth.free;
~reverbSynth = Synth.new(\reverb, [\in, ~reverbBus, \out, 0], ~fxGroup);
)


(
~cur = 1;
~li = [7, 5];
~fu = {
  ~cur = ~cur * -1;
  if (~cur > 0, {7;}, {7;});
};
~fu2 = {
  if (~cur > 0, {2;}, {0;});
};
)

(
/*~synthy.stop;
~synthy = Pbind(\instrument, \squeak,
    \dur, Pseq([0.05].stutter(2) ++ 3.5 - (0.05 * 2), inf),
    \freq, ~toFreq.("Bb4") * Pseq([
        0, 3, 8,
        0, 3, 7,
        0 - 2, 4 - 2, 7,
        Rest(), Rest(), Rest()
    ].midiratio, inf) * [0.5, 1] * Pseq([Pgeom(1, -1.midiratio, inf)], inf).stutter(12),
    \amp, 0.5,
    \rel, 10,
    \out, ~reverbBus,
    \atk, 0.5,
    \sustime, Pseq([0.5].stutter(6) ++ [3].stutter(3) ++ [0.5].stutter(3), inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \lfoFreq, Pwhite(2.7, 3.3, inf)
).play();*/
~synthy2.stop;
~synthy2 = Pbind(\instrument, \simplest,
    \dur, Pseq([0.05].stutter(2) ++ 3.5 - (0.05 * 2), inf),
    \freq, ~toFreq.("Bb4") * Pseq([
        0, 3, 8,
        0, 3, 7,
        -2, 2, 7,
        Rest(), Rest(), Rest()
    ].midiratio, inf) * [1] * Pseq([Pgeom(1, -1.midiratio, inf)], inf).stutter(12),
    \amp, 6,
    \rel, 10,
    \out, ~reverbBus,
    \atk, 0.5,
    \sustime, Pseq([0.5].stutter(6) ++ [3].stutter(3) ++ [0.5].stutter(3), inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \lfoFreq, Pwhite(2.7, 3.3, inf)
).play();
)



(
SynthDef.new(\simplest, {
    arg out, freq = 220, amp = 1, pan = 0, atk = 0.02, rel = 1, lfoFreq = 1;
    var sig, env, lfo, mod;
    lfo = SinOsc.kr(lfoFreq);
    rel = min(max(rel, 0.001), 10);
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    // mod = SinOsc.ar(freq * 8, 0, SinOsc.ar(0.1, 0, 1000));
    sig = LFTri.ar([freq, freq + 0.1]) * 0.1;

    // sig = sig + (Ringz.ar(sig * 0.1, [freq + 0.1, freq], 5, 0.01) * 0.0005);
    // sig = (sig * 0.1) + Ringz.ar(PinkNoise.ar(mul: 0.2), [freq + 0.1, freq], 15, 0.01);
    // sig = sig * LFTri.ar([freq + 0.1, freq] * 0.501);
    // sig = sig * LFSaw.ar([freq + 0.1, freq] * 1);
    sig = sig * env * amp * lfo;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)



(
~synthy2.stop;
~synthy2 = Pbind(\instrument, \simplest,
    \dur, Pseq([0.05].stutter(3) ++ 3.5 - (0.05 * 3), inf),
    \freq, ~toFreq.("Bb4") * Pseq([
        -4, 0, 3, 8,
        -5, 0, 3, 7,
        -5, -2, 2, 7,
        Rest(), Rest(), Rest(), Rest()
    ].midiratio, inf) * [1] * Pseq([Pgeom(1, -1.midiratio, inf)], inf).stutter(16),
    \amp, Pseq([4].stutter(4) ++ [5].stutter(4) ++ [6].stutter(4) ++ [0.5].stutter(4), inf),
    \rel, 10,
    \out, ~reverbBus,
    \atk, 0.5,
    \sustime, Pseq([0.5].stutter(8) ++ [3].stutter(4) ++ [0.5].stutter(4), inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \lfoFreq, Pwhite(2.7, 3.3, inf)
).play();
)