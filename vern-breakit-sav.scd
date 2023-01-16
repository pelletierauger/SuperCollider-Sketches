// Les toms du verni qui envenime
(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0.5), {
    if(~toms2.isPlaying, {~toms2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~toms2 = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[1] * dd;
        var trig = t;
        var trig2 = t + DelayN.kr(t, 0.5, ~nT.beatDur / 8);
        var a = Demand.kr(t, 0, Dseq([1, 1].stutter(16), inf));
        var b = Demand.kr(t, 0, Dseq([0, 1].stutter(32), inf));
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, a, 0];
        var pat1 = [0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, a, a];
        var pat2 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var hh = Demand.kr(trig * block2, 0, Dseq([0.9, 1.1], inf));
        var scr = Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf));
        var sig = MiPlaits.ar(
            pitch: 22 + [0, 0, 0, 0] + 24,
            engine: 9,
            harm: [0.25, 0.4, 0.4, 1],
            timbre: [1, 1, 1, 1]-0.5,
            morph: 0.85 - [0, 0.1, 0.1, -0.2],
            trigger: (trig!3)++(trig2!1) * [block0, block1, block1, block2] * trigGate,
            decay: [0.9, 0.9, 0.9, 2] * 0.175,
            lpg_colour: [0.75, 0.75, 0.75, 0.5] * 1,
            // fm_mod: -0.95,
            // timb_mod: 1,
            morph_mod: -1
        ) * dd.lag(0.05);
        var v = 0;
        var sig3;
        var sig2 = [sig[1][v], sig[2][v]] * 1.5 * Line.kr(0, 1, ~nT.beatDur * 2);
        sig = [sig[0][v] * 2 + (sig[3][v] * 0.5 *2)]!2 + sig2;
        // sig2 = (MiWarpsx.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        // sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        // sig3 = [sig2, sig3] * 0.25;
        // sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500), 0, 5) * 8;
        // sig = sig + (sig3 * Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf)).lag(1));
        sig = sig + (~v.(sig, 3000, 0, 5) * 8);
        sig = VAKorg35.ar(sig, 2000, 0.125, 0.125, 0);
        sig = ~v.(sig, 4000);
        /*        sig = DCompressor.ar(
        input: sig,          sidechainIn: 0,        sidechain: 0,
        ratio: 4,            threshold: -40,        attack: 0.1,
        release: 100.1,      makeup: 0.5,           automakeup: 1
        );*/
        sig * 0.25;
    }.play(fadeTime: 0.01).register;
});

~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0.5), {
    if(~toms3.isPlaying, {~toms3.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~toms3 = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[1] * dd;
        var trig = t;
        var trig2 = t + DelayN.kr(t, 0.5, ~nT.beatDur / 8);
        var a = Demand.kr(t, 0, Dseq((0!16)++(0!16),inf));
        var pat0 = [1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, a, 0, a];
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, a, 0];
        var pat2 = [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] ++ (0!16);
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var hh = Demand.kr(trig * block2, 0, Dseq([0.9, 1.1], inf));
        var scr = Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf));
        var trs = (trig!3)++(trig2!1) * [block0, block1, block1, block2] * trigGate;
        var trs2 = DelayN.kr([trs[1],trs[2]],1,~nT.beatDur/32);
        var trs3 = [trs[0], trs[1]+trs2[0],trs[2]+trs2[1],trs[3]];
        var sig = MiPlaits.ar(
            pitch: 27 + [0, 12, 12, 24] + 12,
            engine: 9,
            harm: [0.25, 0.4, 0.4, 0.4],
            timbre: [1, 1, 1, 1],
            morph: 0.75 - [0, 0.2, 0, -0.2],
            trigger: trs3,
            decay: [0.9, 0.6, 0.6, 0.9] * 0.125,
            lpg_colour: [0.75, 0.75, 0.75, 1],
            // fm_mod: -0.5,
            // timb_mod: 0.5
            morph_mod: -1
        ) * dd.lag(0.05);
        var v = 1;
        var sig3;
        var sig2 = [sig[1][v], sig[2][v]] * 1.5 * Line.kr(0, 1, ~nT.beatDur * 2);
        sig = [sig[0][v] * 0 + (sig[3][v] * 0.5 * 0)]!2 + sig2;
        // sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        // sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        // sig3 = [sig2, sig3] * 0.25;
        sig = sig + (~v.(sig, 3000, 0, 5) * 8);
        // sig = sig + (CombC.ar(sig, 1, ~nT.beatDur/16, 4)*0.25);
        sig = VAKorg35.ar(sig, 4000, 0.125, 0.125, 0)*0.5;
        // sig = ~v.(sig, 7000);
        // sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500), 0, 5) * 8;
        // sig = sig + (sig3 * Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf)).lag(1));
        sig * 1;
    }.play(fadeTime: 0.01).register;
});

~nT.sched(~nT.timeToNextBeat(quant: 4), {

    if(~bass.isPlaying, {~bass.set(\gate, 0, \fadeTime, 0.1)});

    ~bass = {
        | trigGate = 1, envDur = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[1] * dd;
        var trig = t;
        var f = 22+12;
        var lfo = SinOsc.kr(0.1).range(0.1, 0.12);
        // var trig = Impulse.ar(~nT.tempo * 4) * trigGate;
        var dem = Demand.kr(trig, 0, Dseq(Pseries(0, 0.025, 16).asStream.nextN(16), inf));
        var lfo2 = SinOsc.kr(~nT.tempo*0.125, pi / 2).range(0.6, 0.2) - 0.00025;
        var dem2 = Demand.kr(trig, 0, Dseq([-7].stutter(20), inf));
        var dem3 = Demand.kr(trig, 0, Dseq([0.25,0.2].stutter(1), inf));
        var alg = 1;
        var sig = MiPlaits.ar(
            pitch: f + dem2,
            engine: 7,
            harm: lfo,
            morph: lfo2,
            trigger: trig,
            decay:dem3 * envDur,
            lpg_colour:1,
            // fm_mod:1,
            // timb_mod:0.5,
            // morph_mod:-1
        )[1] * 0.2!2;
        ~v.(sig, SinOsc.kr(
            ~nT.tempo*0.5).range((34+12+12).midicps, (34).midicps),0.5) * 12 * 8;
    }.play.register;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    if(~toms3.isPlaying, {~toms3.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    if(~bass.isPlaying, {~bass.set(\envDur, 3, \trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    if(~toms2.isPlaying, {~toms2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
});
)