~nT = TempoClock.new(1.2).permanent_(true);
~nT.tempo;
~nT.tempo = 1.2;

(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0.5), {
    // ~x3b.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
/*    ~x3bbb.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~guitOld.stop;
    ~guitOldB.stop;
    if(~toms2.isPlaying, {~toms2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
 */
    if(~toms.isPlaying, {~toms.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~toms = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[1] * dd;
        var trig = t;
        var trig2 = t + DelayN.kr(t, 0.5, ~nT.beatDur / 8);
        var a = Demand.kr(trig, 0, Drand([1,0],inf));
        var b = Demand.kr(trig, 0, Drand([1,0],inf));
        var c = Demand.kr(trig, 0, Drand([1,0],inf));
        var d = Demand.kr(trig, 0, Drand([1,0],inf));
        var e = Demand.kr(trig, 0, Dwrand([1,0],[0.1, 0.9],inf));
        var pat0 = [1, c, 0, a, 0, 0, a, 0, 1, b, 0, 1, 0, 0, 1, 0];
        var pat1 = [0, d, 1, b, 1, 0, b, 1, 0, 1, 0, 0, 1, 0, 0, 0];
        var pat2 = [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1];
        var pat3 = [0, e];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var block3 = Demand.kr(trig2, 0, Dseq(pat3, inf));
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var hh = Demand.kr(trig * block2, 0, Dseq([0.9, 1.1], inf));
        var scr = Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf));
        var sig = MiPlaits.ar(
            pitch: 27 + [0, 12, 12, 24] + 12,
            engine: 9,
            harm: [0.25, 0.4, 0.4, 0.25],
            timbre: [1, 1, 1, 1],
            morph: 0.75 - [0, 0.2, 0, -0.1],
            trigger: (trig!3)++(trig2!1) * [block0, block1, block1, block2] + [trig2*block3,0,0,0] * trigGate,
            decay: [0.9, 0.6, 0.6, hh] * 0.125,
            lpg_colour: [0.75, 0.75, 0.75, 1],
            // fm_mod: -0.5,
            // timb_mod: 0.5
            morph_mod: -1
        );
        var v = 0;
        var sig3;
        var sig2 = [sig[1][v], sig[2][v]] * 1.5 * Line.kr(0, 1, ~nT.beatDur * 2);
        sig = [sig[0][v] * 2 + (sig[3][v] * 0.15)]!2 + sig2;

        sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        sig3 = [sig2, sig3] * 0.5;
        sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500) - 400, 0, 5) * 8;
        sig = sig + (sig3 * Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf)).lag(1));
        sig * 0.65;
    }.play(fadeTime: 0.01).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0.5), {
    // ~x3b.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
/*    ~x3bbb.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~guitOld.stop;
    ~guitOldB.stop;
    if(~toms2.isPlaying, {~toms2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
 */
    if(~toms.isPlaying, {~toms.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~toms = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[1] * dd;
        var trig = t;
        var trig2 = t + DelayN.kr(t, 0.5, ~nT.beatDur / 8);
        var a = Demand.kr(trig, 0, Drand([1,0],inf));
        var b = Demand.kr(trig, 0, Drand([1,0],inf));
        var c = Demand.kr(trig, 0, Drand([1,0],inf));
        var d = Demand.kr(trig, 0, Drand([1,0],inf));
        var e = Demand.kr(trig, 0, Dwrand([1,0],[0.1, 0.9],inf));
        var f = Demand.kr(trig, 0, Dwrand([1,0],[0.1, 0.9],inf));
        var pat0 = [1, c, 0, a, 0, 0, a, 0, 1, b, 0, 1, 0, 0, 1, 0];
        var pat1 = [0, d, 1, b, 1, 0, b, 1, 0, 1, 0, 0, 1, 0, 0, 0];
        var pat2 = [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1];
        var pat3 = [0, e];
        var pat4 = [0, f];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var block3 = Demand.kr(trig2, 0, Dseq(pat3, inf));
        var block4 = Demand.kr(trig2, 0, Dseq(pat4, inf));
        var sn = block4*0.3;
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var hh = Demand.kr(trig * block2, 0, Dseq([0.9, 1.1], inf));
        var scr = Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf));
        var sta = Demand.kr(t, 0, Dseq([1, 0, 0, 0], inf));
        var sto = Demand.kr(sta, 0, Dwrand([0, 1], [0.05, 0.95], inf));
        var si = 1 - sto * 0.5;
        var sig = MiPlaits.ar(
            pitch: 27 + [0, 12, 12, 24] + 12,
            engine: 9,
            harm: [0.25, 0.4, 0.4, 0.25],
            timbre: [1, 1, 1, 1],
            morph: 0.75 - [0, 0.2, 0, -0.1],
            trigger: (trig!3)++(trig2!1) *
            [block0, block1, block1, block2] +
            [trig2*block3,trig2*block4,trig2*block4,0] * trigGate * sto,
            decay: [0.9, 0.6+block4, 0.6+block4, hh] * 0.125 + (1 - sto),
            lpg_colour: [0.75, 0.75, 0.75, 1],
            // fm_mod: -0.5,
            // timb_mod: 0.5
            morph_mod: -1
        ) * dd.lag(0.1);
        var v = 0;
        var sig3;
        var sig2 = [sig[1][v], sig[2][v]] * 1.5 * Line.kr(0, 1, ~nT.beatDur * 2);
        sig = [sig[0][v] * 2 + (sig[3][v] * 0.15)]!2 + sig2;

        sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25 + (si*0.7), algo: 1, timb: 0.4 + si)[0]);
        sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25 + (si*0.7), algo: 1, timb: 0.4 + si)[0]);
        sig3 = [sig2, sig3] * 0.5;
        sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500) - 400, 0, 5) * 8;
        sig = sig + (sig3 * Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf)).lag(1));
        sig * 0.65 * dd.lag(0.1);
    }.play(fadeTime: 0.01).register;
});
)




~nT.tempo = 1.2

(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0.5), {
    // ~x3b.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
/*    ~x3bbb.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~guitOld.stop;
    ~guitOldB.stop;
    if(~toms2.isPlaying, {~toms2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
 */
    if(~toms.isPlaying, {~toms.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~toms = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[1] * dd;
        var trig = t;
        var trig2 = t + DelayN.kr(t, 0.5, ~nT.beatDur / 8);
        var a = Demand.kr(trig, 0, Drand([1,0],inf));
        var b = Demand.kr(trig, 0, Drand([1,0],inf));
        var c = Demand.kr(trig, 0, Drand([1,0],inf));
        var d = Demand.kr(trig, 0, Drand([1,0],inf));
        var e = Demand.kr(trig, 0, Dwrand([1,0],[0.1, 0.9],inf));
        var f = Demand.kr(trig, 0, Dwrand([1,0],[0.1, 0.9],inf));
        var pat0 = [1, c, 0, a, 0, 0, a, 0, 1, b, 0, 1, 0, 0, 1, 0];
        var pat1 = [0, d, 1, b, 1, 0, b, 1, 0, 1, 0, 0, 1, 0, 0, 0];
        var pat2 = [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1];
        var pat3 = [0, e];
        var pat4 = [0, f];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var block3 = Demand.kr(trig2, 0, Dseq(pat3, inf));
        var block4 = Demand.kr(trig2, 0, Dseq(pat4, inf));
        var sn = block4*0.3;
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var hh = Demand.kr(trig * block2, 0, Dseq([0.9, 1.1], inf));
        var scr = Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf));
        var sta = Demand.kr(t, 0, Dseq([1, 0, 0, 0], inf));
        var sto = Demand.kr(sta, 0, Dwrand([0, 1], [0.05, 0.95], inf));
        var si = 1 - sto * 0.5;
        var sig = MiPlaits.ar(
            pitch: 27 + [0, 12, 12, 24] + 12,
            engine: 9,
            harm: [0.25, 0.4, 0.4, 0.25],
            timbre: [1, 1, 1, 1],
            morph: 0.75 - [0, 0.2, 0, -0.1],
            trigger: (trig!3)++(trig2!1) *
            [block0, block1, block1, block2] +
            [trig2*block3,trig2*block4,trig2*block4,0] * trigGate * sto,
            decay: [0.9, 0.6+block4, 0.6+block4, hh] * 0.25 + (1 - sto),
            lpg_colour: [0.75, 0.75, 0.75, 1],
            // fm_mod: -0.5,
            // timb_mod: 0.5
            morph_mod: -1
        ) * dd.lag(0.1);
        var v = 0;
        var sig3;
        var sig2 = [sig[1][v], sig[2][v]] * 1.5 * Line.kr(0, 1, ~nT.beatDur * 2);
        sig = [sig[0][v] * 2 + (sig[3][v] * 0.15)]!2 + sig2;

        sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25 + (si*0.7), algo: 1, timb: 0.4 + si)[0]);
        sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25 + (si*0.7), algo: 1, timb: 0.4 + si)[0]);
        sig3 = [sig2, sig3] * 0.5;
        sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500) - 400, 0, 5) * 8;
        sig = sig + (sig3 * Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf)).lag(1));
        sig * 0.65 * dd.lag(0.1);
    }.play(fadeTime: 0.01).register;
});
)



(
j.free;
j = {
    var safeEnv = EnvGen.kr(Env([0,0,1], [0.009,0.001]));
    var sig = MiBraids.ar(22+12, 0.5, ~lfo.([3,3.1],0.5,0.55), model: 14);
    ~v.(sig,500) * 0.6 * Line.kr(0,1,0.125) * safeEnv;
}.play;
)

// --------------------------------------------------------------------
// Le scuttle low et sinistre
// --------------------------------------------------------------------

(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0.5), {
    // ~x3b.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
/*    ~x3bbb.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~guitOld.stop;
    ~guitOldB.stop;
    if(~toms2.isPlaying, {~toms2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
 */
    if(~toms.isPlaying, {~toms.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~toms = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[1] * dd;
        var trig = t;
        var trig2 = t + DelayN.kr(t, 0.5, ~nT.beatDur / 8);
        var a = Demand.kr(trig, 0, Drand([1,0],inf));
        var b = Demand.kr(trig, 0, Drand([1,0],inf));
        var c = Demand.kr(trig, 0, Drand([1,0],inf));
        var d = Demand.kr(trig, 0, Drand([1,0],inf));
        var e = Demand.kr(trig, 0, Dwrand([1,0],[0.1, 0.9],inf));
        var f = Demand.kr(trig, 0, Dwrand([1,0],[0.1, 0.9],inf));
        var pat0 = [1, c, 0, a, 0, 0, a, 0, 1, b, 0, 1, 0, 0, 1, 0];
        var pat1 = [0, d, 1, b, 1, 0, b, 1, 0, 1, 0, 0, 1, 0, 0, 0];
        var pat2 = [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1];
        var pat3 = [0, e];
        var pat4 = [0, f];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var block3 = Demand.kr(trig2, 0, Dseq(pat3, inf));
        var block4 = Demand.kr(trig2, 0, Dseq(pat4, inf));
        var sn = block4*0.3;
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var hh = Demand.kr(trig * block2, 0, Dseq([0.9, 1.1], inf));
        var scr = Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf));
        var sta = Demand.kr(t, 0, Dseq([1, 0, 0, 0], inf));
        var sto = Demand.kr(sta, 0, Dwrand([0, 1], [0.05, 0.95], inf));
        var si = 1 - sto * 0.5;
        var sig = MiPlaits.ar(
            pitch: 27 + [0, 12, 12, 24] + -24,
            engine: 9,
            harm: [0.25, 0.4, 0.4, 0.25],
            timbre: [1, 1, 1, 1],
            morph: 0.25 - [0, 0.2, 0, -0.1],
            trigger: (trig!3)++(trig2!1) *
            [block0, block1, block1, block2] +
            [trig2*block3,trig2*block4,trig2*block4,0] * trigGate * sto,
            decay: [0.9, 0.6+block4, 0.6+block4, hh] * 0.25 + (1 - sto),
            lpg_colour: [0.75, 0.75, 0.75, 1]*0.5,
            // fm_mod: -0.5,
            // timb_mod: 0.5
            morph_mod: -1
        ) * dd.lag(0.0125);
        var v = 1;
        var sig3;
        var sig2 = [sig[1][v], sig[2][v]] * 1.5 * Line.kr(0, 1, ~nT.beatDur * 2);
        sig = [sig[0][v] * 2 + (sig[3][v] * 0.15)]!2 + sig2;

        sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25 + (si*0.7), algo: 1, timb: 0.4 + si)[0]);
        sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25 + (si*0.7), algo: 1, timb: 0.4 + si)[0]);
        sig3 = [sig2, sig3] * 0.5;
        sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500) - 400, 0, 5) * 8;
        sig = sig + (sig3 * Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf)).lag(1));

        // sig = MiWarps.ar(sig, sig, 0.5, 1, 2, 1, osc:0, easteregg:1);
        sig = (sig*0.5)+~v.(sig, 1500,0,1);
        // sig = ~v.(sig,2000,0,5);
sig * 0.65 * dd.lag(0.0125);
    }.play(fadeTime: 0.01).register;
});
)


// Les toms en support aux toms qui enveniment.


(
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
            decay: [0.9, 0.6, 0.6, 0.9] * 0.5,
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
        // sig = VAKorg35.ar(sig, 4000, 0.125, 0.125, 0);
        // sig = ~v.(sig, 7000);
        // sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500), 0, 5) * 8;
        // sig = sig + (sig3 * Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf)).lag(1));
        sig * 1;
    }.play(fadeTime: 0.01).register;
});
)
