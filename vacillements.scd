(
SynthDef(\help_dwgbowed, { |out=0, freq=440, amp=0.5,force=1, gate=1,pos=0.07,c1=0.25,c3=31,pan=0|
    var vib = Gendy1.kr(1,1,1,1,0.1, 4,mul:0.003,add:1);
    var son = DWGBowed.ar(freq*vib, amp,force, gate,pos,0.1,c1,c3);
    son = DWGSoundBoard.ar(son);
    son = BPF.ar(son, 118,1)+son;
    son = BPF.ar(son, 430,1)+son;
    son = BPF.ar(son, 490,1)+son;
    son = LPF.ar(son, 1000);
    Out.ar(out, Pan2.ar(son * 0.1, pan));
}).add;
)

//Use it.
(

Pbind(
    \instrument, \help_dwgbowed,
    \dur , 4,
    \octave, 2,
    \degree, Pseq([1,5,7+3].reverse, inf),
    \amp , Pseq([0.9,0.7,0.5],inf),
).play;
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    var f = ~toFreq.("C3");
    if(~bow.isPlaying, {~bow.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
    ~bow = {
        | out = 0, amp = 0.5, force = 1,
        gate = 1, pos = 0.07, c1 = 0.25, c3 = 31, pan = 0 |
        var imp = Impulse.kr(~nT.tempo * 0.25);
        var dem = Demand.kr(imp, 0, Dseq([0, 1, -2].midiratio, inf)).lag(0.25);
        var vib = Gendy1.kr(1,1,1,1,0.1, 4,mul:0.003,add:1);
        var son = DWGBowed.ar(f * vib * dem * [1, 1.001], amp,force, gate,pos,0.1,c1,c3);
        son = DWGSoundBoard.ar(son);
        son = BPF.ar(son, 118, 1) + son;
        son = BPF.ar(son, 430, 1) + son;
        son = BPF.ar(son, 490, 1) + son;
        son = LPF.ar(son, 1000);
        Out.ar(out, son * 0.025);
    }.play.register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    var f = ~toFreq.("C2");
    if(~bow2.isPlaying, {~bow2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
    ~bow2 = {
        | out = 0, amp = 0.5, force = 1,
        gate = 1, pos = 0.07, c1 = 0.25, c3 = 31, pan = 0, relGate = 0  |
        var amp2 = EnvGen.ar(
            envelope: Env([1, 1, 0], [0, 0.1], ['lin', -8], releaseNode: 1),
            gate: Trig.kr(relGate),
            doneAction: 0
        );
        var imp = Impulse.kr(~nT.tempo * 0.25);
        var dem = Demand.kr(imp, 0, Dseq([0, 1, -2].midiratio, inf)).lag(0.25);
        var vib = Gendy1.kr(1,1,1,1,0.1, 4,mul:0.003,add:1);
        var son = DWGBowed.ar(f * vib * dem * [1, 1.001], amp,force, gate,pos,0.1,c1,c3);
        var flux = LFSaw.kr(2).range(0, 1);
        var lfo = SinOsc.kr(4).range(199, 19);
        son = DWGSoundBoard.ar(
            inp: son * amp2,
            c1: 2, c3: 20, mix: 0.8,
            d1: 199, d2: 211, d3: 223, d4: 227,
            d5: 229, d6: 233, d7: 239, d8: 241
        );
        son = BPF.ar(son, 118, 1) + son;
        son = BPF.ar(son, 430, 1) + son;
        son = BPF.ar(son, 490, 1) + son;
        son = LPF.ar(son, 1000);
        Out.ar(out, son * 0.025);
    }.play.register;
});
)

~bow2.set(\relGate, 1);



(   // some bowing
~t.sched(~t.timeToNextBeat(quant: 4), {
    ~bloo.free;
    ~bloo = {
        | trigGate = 1 |
        var imp = Impulse.kr(~t.tempo * 0.25) * trigGate;
        var dem = Demand.kr(imp, 0, 32 + Dseq([0, 1, -2], inf)).lag(0.25);
            var mod = LFNoise1.kr(0.3, 0.5, 0.5);
        // mod = (imp * dem).lag(0.1);
        // mod = 0.5;
            MiElements.ar(
            gate: 1,
            pit: dem,
            contour: 0.5,
            bow_level: 1,
            bow_timb: mod,
            geom: 0.25,
            bright: 0.5,
            damp: 0.7,
            pos: 0.2,
            space: 0.3,
            model: 0,
            easteregg: 0
        ) * 0.25;
    }.play;
});
)



(   // easteregg: a hidden 2x2-op FM synth
if(~hiddenFM.isPlaying, {~hiddenFM.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

~hiddenFM = {
        var mod = LFNoise1.kr(0.3,0.5,0.5);
        var ratio = 0.25;
        var ratio2 = 0.25;
        var ratio3 = 0.51;
    var in = In.ar(~bu, 2);
    // in = SinOsc.ar(29.midicps);
    MiElements.ar(
        strike_in: in,
        gate:1,
        contour: 0.5,
        pit: 48,
        bow_level: 0.25,
        blow_level: 0.6,
        strike_level: 0.5,
        flow: 0.25,
        mallet: 0.51,
        bow_timb: 0.5,
        blow_timb: 0.3,
        strike_timb: 0.6,
        strength: 0.9,
        geom: 0.0,
        bright: 0.6,
        damp: 0.0,
        space: 0.7,
        easteregg: 1
    );
}.play.register;
)

(
~ou.free;
~ou = {
    Out.ar(~bu, SinOsc.ar(29.midicps));
};
)

// https://forum.mutable-instruments.net/t/easter-eggs-hidden-modes-in-mutable-instruments-modules/4948/110
// https://modwiggler.com/forum/viewtopic.php?p=1834852#1834852

(
~leadSqueak = {
    ~nT.sched(~nT.timeToNextBeat(quant: 4), {

        [~lead].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});});

        ~lead = {
            | trigGate = 1 |
            var envGate = EnvGate.new();
            var tempo = ~nT.tempo * 1;
            var basePulse = Impulse.ar(tempo) * trigGate;
            var swing = [2, 4] / 3;
            var swungTempo = Demand.ar(basePulse, 0, Dseq(swing * tempo, inf));
            var trig = Impulse.ar(tempo * [3] * 1) * trigGate;
            var block = Demand.ar(trig, 0, Dseq([0, 0, 1].rotate(1), inf));
            // var trig2 = Impulse.ar(swungTempo * 0.125 * 0.25 * 1) * trigGate;
            var dem = Demand.ar(trig * block, 0,
                Dseq(
                    (0!4) ++ (-2!4) ++ (-5!3) ++ (-4!1) ++ (-5!3) ++ (-5!1) ++
                    (0!3) ++ (5!1) ++ (-2!4) ++ (-5!3) ++ (-4!1) ++ (-5!3) ++ (-5!1)
                    , inf));
            var dem2 = Demand.ar(trig * block, 0,
                Dseq([0.01, 1, 1, 1].stutter(4), inf));
            var sig = MiPlaits.ar(24 + 24 + 24 + dem.lag(dem2) + [0, 0.05] - 0,
                engine: 11,
                harm: 0.25,
                timbre: 0.125,
                morph: SinOsc.kr(0.1).range(0.75, 0.8) - 0.1,
                trigger: trig * block * Demand.ar(trig, 0, Dseq(1!13 ++ (0!11), inf)),
                decay: 0.1,
                lpg_colour: 1,
                mul: 1.25
            );
            sig = [sig[0][0], sig[1][0]];
            sig = LPF.ar(sig, 2500) * 0.8 * 0.75 * 3;
            sig = sig * 1;
            // sig = sig.clip(-0.001, 0.001) * 16;
            sig = LPF.ar(sig, 2000) * 4;
            sig = MiElements.ar(
                blow_in: sig * 1,
                gate:1,
                contour: 0.25,
                pit: 48 + 0 + (dem.lag(dem2)!2),
                bow_level: 0.25,
                blow_level: 0.6,
                strike_level: 0.5,
                flow: 0.5,
                mallet: 0.51,
                bow_timb: 0.5,
                blow_timb: 0.3,
                strike_timb: 0.6,
                strength: 0.8,
                geom: 0.0,
                bright: 0.4,
                damp: 0.0,
                space: 0.1,
                easteregg: 1
            );
            sig.size.poll;
            Out.ar(0, sig * envGate);
            // Out.ar(~bu, sig * XLine.ar(0.001, 1, 0.005) * 0.75);
            // Out.ar(0, [sig[1], sig[0]] * XLine.ar(0.001, 1, 0.005) * 0.5);
        }.play.register;
    });
};
~leadSqueak.();
)

~leadSqueak.();




c = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Projets Ableton Live/Avec l'AT2020 Project/Samples/Recorded/0001 7-Audio.aif");

d = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/Dehors/chirp-kit.wav");

1,30,882
90.882 * 44100 / c.numFrames
69.61  * 44100 / c.numFrames
71.99  * 44100 / c.numFrames
c.

~t = TempoClock.new.permanent_(true);
~t.tempo = 90/60;
~t.beatDur
13 * 60 + 0.97
(
~t.sched(~t.timeToNextBeat(quant: 4) + (~t.beatDur * -0.5), {
    [~monoSamp2].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});});

    ~monoSamp2 = {
        | trigGate = 1, rate = 1, spos = 13.097, pan = 0,
        amp = 1, atk = 0.001, susT = 1.5, rel = 0.01, out = 0 |
        var sig, env, lfo, t, buf, envGate, dem;
        envGate = EnvGate.new() * trigGate;
        buf = c;
        t = Impulse.kr(1);
        dem = Demand.kr(t, 0, Dseq([0, -5].stutter(4), inf));
        env = EnvGen.kr(Env([0, 1, 0], [0.001, 1], [2, 'lin', 'lin']), t);
        sig = PlayBuf.ar(
            numChannels: 2,
            bufnum: buf,
            rate: rate * BufRateScale.ir(buf),
            trigger: t,
            startPos: spos * BufSampleRate.ir(buf)
        );
        sig = sig * env * amp;
        sig = (sig * 0.4) + MiRings.ar(sig, pit: 32 + dem, model: 2, easteregg: 0);
        sig = Balance2.ar(sig[0], sig[1], pan, 1);
        Out.ar(out, sig * envGate);
    }.play.register;
});
)


(
~t.sched(~t.timeToNextBeat(quant: 4), {
    [~monoSamp].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 15)});});

    ~monoSamp = {
        | trigGate = 1, rate = 1, spos = 21.097, pan = 0,
        amp = 1, atk = 0.001, susT = 1.5, rel = 0.01, out = 0 |
        var sig, env, lfo, t, buf, envGate, dem;
        envGate = EnvGate.new();
        buf = c;
        t = Impulse.kr(1) * trigGate;
        dem = Demand.kr(t, 0, Dseq([0, -5].stutter(4), inf));
        env = EnvGen.kr(Env([0, 1, 0], [0.001, 1], [2, 'lin', 'lin']), t);
        sig = PlayBuf.ar(
            numChannels: 2,
            bufnum: buf,
            rate: rate * BufRateScale.ir(buf),
            trigger: t,
            startPos: spos * BufSampleRate.ir(buf)
        );
        sig = sig * env * amp;
        sig = (sig * 0.4) + MiRings.ar(sig, pit: 32 + dem, model: 2, easteregg: 0);
        sig = Balance2.ar(sig[0], sig[1], pan, 1);
        Out.ar(out, sig * envGate);
    }.play.register;
});
)


(
~t.sched(~t.timeToNextBeat(quant: 4), {
    [~monoSamp].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 15)});});

    ~monoSamp = {
        | trigGate = 1, rate = 1, spos = 21.097, pan = 0,
        amp = 1, atk = 0.001, susT = 1.5, rel = 0.01, out = 0 |
        var sig, env, lfo, t, buf, envGate, dem;
        envGate = EnvGate.new();
        buf = c;
        t = Impulse.kr(1) * trigGate;
        dem = Demand.kr(t, 0, Dseq([0, -5].stutter(4), inf));
        env = EnvGen.kr(Env([0, 1, 0], [0.001, 1], [2, 'lin', 'lin']), t);
        sig = PlayBuf.ar(
            numChannels: 2,
            bufnum: buf,
            rate: rate * BufRateScale.ir(buf),
            trigger: t,
            startPos: spos * BufSampleRate.ir(buf)
        );
        sig = sig * env * amp;
        sig = (LPF.ar(sig, 2000) * 0.9) + MiRings.ar(
            sig,
            pit: 32 + dem,
            struct: 0.5,
            bright: 0.9,
            damp: 0.9,
            model: 2,
            easteregg: 0
        );
        sig = Balance2.ar(sig[0], sig[1], pan, 1);
        Out.ar(out, sig * envGate);
    }.play.register;
});
)


(
[~monoSamp, ~monoSamp2].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 15)});});
~bloo.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
)