
~nT = TempoClock.new(1.39).permanent_(true);

s.sendMsg(\b_allocRead, 10, "/Users/guillaumepelletier/Desktop/0001 7-Audio-1-mono.wav");


// Devant le grand mur des obstacles

(
~nT.sched(~nT.timeToNextBeat(quant: 5), {

    if(~bass.isPlaying, {~bass.set(\gate, 0, \fadeTime, 0.1)});

    ~bass = {
        var f = 33;
        var lfo = SinOsc.kr(0.1).range(0.1, 0.12);
        var trig = Impulse.ar(~nT.beatDur.reciprocal * 4);
        var dem = Demand.ar(trig, 0, Dseq(Pseries(0, 0.025, 16).asStream.nextN(16), inf));
        var lfo2 = SinOsc.kr(0.1, pi / 2).range(0.6, 0.6) - 0.00025;
        var dem2 = Demand.ar(trig, 0, Dseq([-7].stutter(20), inf));
        var alg = 1;
        var sig = MiPlaits.ar(
            pitch: f + dem2,
            engine: 1,
            harm: lfo,
            morph: lfo2,
            trigger: trig
        )[0]!2 * 0.8;
        LPF.ar(sig, SinOsc.kr(0.1).range(800, 4000)) * 3 * 1;
    }.play.register;

    if(~snare.isPlaying, {~snare.set(\gate, 0, \fadeTime, 0.1)});

    ~snare = {
        | trigGate = 1 |
        var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
        var dem = Demand.ar(trig, 0, Dseq([1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0], inf));
        var sig = MiPlaits.ar(
            pitch: 30,
            engine: 9,
            harm: 0.95,
            timbre: 1,
            morph: 0.25,
            trigger: trig * dem * trigGate,
            decay: 0.8,
            lpg_colour: 0
        )[1]!2;
        sig = HPF.ar(sig, 200);
        sig = sig * 3.6;
    }.play(fadeTime: 0).register;

        if(~snare2.isPlaying, {~snare2.set(\gate, 0, \fadeTime, 0.1)});

    ~snare2 = {
        | trigGate = 1 |
        var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
        var dem = Demand.ar(trig, 0, Dseq([0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0], inf));
        var note = Demand.ar(trig, 0, 42 + 12 + Dseq([0].stutter(5), inf));
        var sig = MiPlaits.ar(42 - 36,
            engine: 9,
            harm: 0.95,
            timbre: 0.9,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.25,
            trigger: trig * dem * trigGate,
            decay: 0.85,
            lpg_colour: 0,
            mul: 3);
        sig = HPF.ar(sig, 400);
        sig = sig * 1.5 * 2.25;
        sig[1]!2;
    }.play(fadeTime: 0).register;

    if(~kick.isPlaying, {~kick.set(\gate, 0, \fadeTime, 0.1)});

    ~kick = {
        | trigGate = 1 |
        var trig, sig, block;
        trig = Impulse.kr(1 / ~nT.beatDur * 1);
        block = Demand.kr(trig, 0, Dseq([1, 0, 0, 0, 0], inf));
        sig = MiPlaits.ar(2,
            engine: 9,
            harm: 0.9,
            timbre: 1,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.0,
            trigger: trig * trigGate,
            decay: 0.7,
            lpg_colour: 0,
            mul: 3)[1]!2 * 1.5;
    sig = LPF.ar(sig, 2400);
    }.play(fadeTime: 0).register;


        if(~kick2.isPlaying, {~kick2.set(\gate, 0, \fadeTime, 0.1)});

    ~kick2 = {
        | trigGate = 1 |
        var trig, sig, block;
        trig = Impulse.kr(1 / ~nT.beatDur * 1);
        block = Demand.kr(trig, 0, Dseq([1, 0, 0, 0, 0], inf));
        sig = MiBraids.ar(
            pitch: 72 - 24,
            timbre: 0.7,
            color: 0.5,
            model: 34,
            trig: trig * trigGate,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        );
        sig = LPF.ar(sig, 200);
        sig!2 * 0.25 * 8;
    }.play(fadeTime: 0).register;

    if(j.isPlaying, {j.set(\gate, 0, \fadeTime, 1)});

    j = {
        | low = 1, high = 1.0, pitch = -2, trigGate = 1 |
        var sig, b = 10, trate, dur, clk, pos, pan, dem, beat, melody;
        beat = Impulse.kr(0.25);
        melody = Demand.kr(beat, 0, Dseq([-5].midiratio, inf));
        trate = 16.8561;
        dur = 12 / trate;
        clk = Impulse.kr(trate * 4);
        dem = Demand.kr(clk, 0, Dseq([1, 0.5], inf)) * TRand.kr(low, high, clk);
        pos = 33.3614 + TRand.kr(0, 0.01, clk);
        pan = WhiteNoise.kr(1);
        sig = TGrains2.ar(
            numChannels: 2,
            trigger: clk * trigGate,
            bufnum: b,
            rate: dem * pitch.midiratio * melody,
            centerPos: pos,
            dur: dur,
            pan: pan,
            amp: 0.1,
            att: dur * 0.3,
            dec: dur * 8,
            interp: 4
        );
        LPF.ar(sig, 18000) * 4;
    }.play(fadeTime: 0.1).register;

    // [~hat0, ~hat1].do({|i| if(i.isPlaying, {i.set(\gate, 0, \fadeTime, 0.1)});});
    //
    // ~hat0 = {
    //     | trigGate = 1 |
    //     var t = Impulse.kr(~nT.beatDur.reciprocal * 4) * trigGate;
    //     var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
    //     var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
    //     var sig = MiBraids.ar(
    //         pitch: 72 + 140,
    //         timbre: 0.7,
    //         color: 0.1 + [0, 0.01],
    //         model: 43,
    //         resamp: 0,
    //         decim: 32,
    //         bits: 6,
    //         ws: 1
    //     ) * env;
    //     sig = LPF.ar(sig, 6000);
    //
    //     sig * 0.125 * 0.5 * 4;
    // }.play(fadeTime: 0).register;
    //
    // ~hat1 = {
    //     | trigGate = 1 |
    //     var t = Impulse.kr(~nT.beatDur.reciprocal * 4 * 0.5) * trigGate;
    //     var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 8], [2, -8, 'lin']), t);
    //     var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
    //     var sig = MiBraids.ar(
    //         pitch: 72 + 140 - 24,
    //         timbre: 0.7,
    //         color: 0.1 + [0, 0.01],
    //         model: 43,
    //         resamp: 0,
    //         decim: 32,
    //         bits: 6,
    //         ws: 1
    //     ) * env;
    //     sig = LPF.ar(sig, 6000);
    //
    //     sig * 0.125 * 0.125 * 4 * 1.5 * 2;
    // }.play(fadeTime: 0).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 1), {

    if(~noise0.isPlaying, {~noise0.set(\gate, 0, \fadeTime, 0.1)});

    ~noise0 = {
        var trig = Impulse.ar((1 / (~nT.beatDur)));
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0, 0], inf));
        var notes = Demand.ar(trig * block, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.ar(trig * block, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.ar(trig * block, 0, Dseq([0, 0.99], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 30 + [0, 0.01],
            timbre: 0.45 + lfo,
            color: 0.0 + dem2,
            model: 4,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        );
        sig = LPF.ar(sig, 2000);
        sig * 0.65625 * 2;
    }.play(fadeTime: 10).register;

    if(~noise1.isPlaying, {~noise1.set(\gate, 0, \fadeTime, 0.1)});

    ~noise1 = {
        var trig = Impulse.ar((1 / (~nT.beatDur)));
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0, 0], inf));
        var notes = Demand.ar(trig * block, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.ar(trig * block, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.ar(trig * block, 0, Dseq([0, 0.8], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 42 + 12 + [0, 0.01],
            timbre: 0.01 + lfo,
            color: 0.0 + dem2,
            model: 4,
            resamp: 2,
            decim: 32,
            bits: 6,
            ws: 0.4
        );
        sig = HPF.ar(sig, 1000);
        sig * 0.065625 * 2;
    }.play(fadeTime: 10).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 1), {

    if(~hat2.isPlaying, {~hat2.set(\gate, 0, \fadeTime, 0.1)});

    ~hat2 = {
        var trig = Impulse.kr(1 / (~nT.beatDur) * 4);
        var notes = Demand.kr(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.kr(trig, 0, Dseq([1, 0, 1, 0].rotate(0), inf));
        var env = EnvGen.kr(Env.new([0, 1, 1, 0], [0.005, 0.35 * 0.125, 0.005]), gate: dem);
        var sig = MiBraids.ar(
            pitch: 48 - 36,
            timbre: 0.1 * 0.5,
            color: 0.0 + 0.1 + [0, 0.01],
            model: 4,
            resamp: 2,
            decim: 16,
            bits: 4,
            ws: 0
        );
        sig = LPF.ar(sig, 4000) * 0.075 * env * 64;
    }.play(fadeTime: 0.0).register;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 1), {

    [~hat0, ~hat1].do({|i| if(i.isPlaying, {i.set(\gate, 0, \fadeTime, 0.1)});});

    ~hat0 = {
        var t = Impulse.kr(~nT.beatDur.reciprocal * 4);
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
        var sig = MiBraids.ar(
            pitch: 72 + 140,
            timbre: 0.7,
            color: 0.1 + [0, 0.01],
            model: 43,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        ) * env;
        sig * 0.125 * 0.5;
    }.play(fadeTime: 0).register;

    ~hat1 = {
        var t = Impulse.kr(~nT.beatDur.reciprocal * 4 * 0.5);
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 4], [2, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
        var sig = MiBraids.ar(
            pitch: 72 + 140 - 24,
            timbre: 0.7,
            color: 0.1 + [0, 0.01],
            model: 43,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        ) * env;
        sig * 0.125 * 0.125 * 4;
    }.play(fadeTime: 0).register;
});
)


(
var synths = [~kick, ~snare, ~bass,
    ~noise0, ~noise1, ~hat0, ~hat1, ~hat2,
    q, t, ~pul3, j,
];
synths.do({|i| if(i.isPlaying, {i.set(\gate, 0, \fadeTime, 5)})});
)




// ------------------------------------------------------------
// Arrivée dans la fumeuse ronde mystique
// ------------------------------------------------------------

(
~nT.sched(~nT.timeToNextBeat(quant: 5), {

    var synths = [
        ~noise0, ~noise1, ~bass, ~noLowB,
        // ~pul3, ~snare, ~snare2, ~hat2,
        // ~hat0, ~hat1,
        q, t
    ];

    if(j.isPlaying, {j.set(\gate, 0, \fadeTime, 1)});

    j = {
        | low = 1, high = 1.0, pitch = -2, trigGate = 1 |
        var sig, b = 10, trate, dur, clk, pos, pan, dem, beat, melody;
        beat = Impulse.kr(0.25);
        melody = Demand.kr(beat, 0, Dseq([-5].midiratio, inf));
        trate = 16.8561;
        dur = 12 / trate;
        clk = Impulse.kr(trate * 4);
        dem = Demand.kr(clk, 0, Dseq([1, 0.5], inf)) * TRand.kr(low, high, clk);
        pos = 60.3614 + TRand.kr(0, 0.01, clk);
        pan = WhiteNoise.kr(1);
        sig = TGrains2.ar(
            numChannels: 2,
            trigger: clk * trigGate,
            bufnum: b,
            rate: dem * pitch.midiratio * melody,
            centerPos: pos,
            dur: dur,
            pan: pan,
            amp: 0.1,
            att: dur * 0.3,
            dec: dur * 8,
            interp: 4
        );
        LPF.ar(sig, 18000) * 0.25 * 16 * 1.5 * 1.5;
    }.play(fadeTime: 0.1).register;

    if(~snare2.isPlaying, {~snare2.set(\gate, 0, \fadeTime, 0.1)});

    ~snare2 = {
        | trigGate = 1 |
        var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
        var dem = Demand.ar(trig, 0, Dseq([0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0], inf));
        var note = Demand.ar(trig, 0, 42 + 12 + Dseq([0].stutter(5), inf));
        var sig = MiPlaits.ar(42 - 36,
            engine: 9,
            harm: 0.95,
            timbre: 0.9,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.25,
            trigger: trig * dem * trigGate,
            decay: 0.85,
            lpg_colour: 0,
            mul: 3);
        sig = HPF.ar(sig, 400);
        sig = sig * 1.5 * 2;
        sig[1]!2;
    }.play(fadeTime: 0).register;

    if(~snare.isPlaying, {~snare.set(\gate, 0, \fadeTime, 0.1)});

    ~snare = {
        | trigGate = 1 |
        var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
        var dem = Demand.ar(trig, 0, Dseq([1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0], inf));
        var sig = MiPlaits.ar(
            pitch: 30,
            engine: 9,
            harm: 0.95,
            timbre: 1,
            morph: 0.25,
            trigger: trig * dem * trigGate,
            decay: 0.8,
            lpg_colour: 0
        )[1]!2;
        sig = HPF.ar(sig, 200);
        sig = sig * 2.2;
    }.play(fadeTime: 0).register;

    if(~kick.isPlaying, {~kick.set(\gate, 0, \fadeTime, 0.1)});

    ~kick = {
        | trigGate = 1 |
        var trig, sig, block;
        trig = Impulse.kr(1 / ~nT.beatDur * 1);
        block = Demand.kr(trig, 0, Dseq([1, 0, 0, 0, 0], inf));
        sig = MiPlaits.ar(2,
            engine: 9,
            harm: 0.9,
            timbre: 1,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.0,
            trigger: trig * trigGate,
            decay: 0.85,
            lpg_colour: 0,
            mul: 3)[1]!2 * 0.25;
    sig = LPF.ar(sig, 2400);
    }.play(fadeTime: 0).register;

    [~hat0, ~hat1].do({|i| if(i.isPlaying, {i.set(\gate, 0, \fadeTime, 0.1)});});

    ~hat0 = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.beatDur.reciprocal * 4) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
        var sig = MiBraids.ar(
            pitch: 72 + 140,
            timbre: 0.7,
            color: 0.1 + [0, 0.01],
            model: 43,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        ) * env;
    sig = LPF.ar(sig, 6000);
        sig * 0.125 * 1.5;
    }.play(fadeTime: 0).register;

    ~hat1 = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.beatDur.reciprocal * 4 * 0.5) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 8], [2, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
        var sig = MiBraids.ar(
            pitch: 72 + 140 - 24,
            timbre: 0.7,
            color: 0.1 + [0, 0.01],
            model: 43,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        ) * env;
    sig = LPF.ar(sig, 6000);
        sig * 0.125 * 0.125 * 16 * 0.75;
    }.play(fadeTime: 0).register;

    synths.do({|i| if(i.isPlaying, {i.set(\gate, 0, \fadeTime, 0.1)})});
});
)


// Les complications dans la ronde, les répercussions des blessures
// qui restent dans l'âme et dans le corps.

(
~nT.sched(~nT.timeToNextBeat(quant: 1), {

    if(j.isPlaying, {j.set(\gate, 0, \fadeTime, 1)});

    j = {
        | low = 1, high = 1.0, pitch = -2, trigGate = 1 |
        var sig, b = 10, trate, dur, clk, pos, pan, dem, beat, melody;
        beat = Impulse.kr(0.25);
        melody = Demand.kr(beat, 0, Dseq([-5].midiratio, inf));
        trate = 16.8561;
        dur = 12 / trate;
        clk = Impulse.kr(trate * 4);
        dem = Demand.kr(clk, 0, Dseq([1, 0.5], inf)) * TRand.kr(low, high, clk);
        pos = 63.3614 + TRand.kr(0, 0.01, clk);
        pan = WhiteNoise.kr(1);
        sig = TGrains2.ar(
            numChannels: 2,
            trigger: clk * trigGate,
            bufnum: b,
            rate: dem * pitch.midiratio * melody,
            centerPos: pos,
            dur: dur,
            pan: pan,
            amp: 0.1,
            att: dur * 0.3,
            dec: dur * 8,
            interp: 4
        );
        LPF.ar(sig, 18000) * 4 * 1.5 * 1.5;
    }.play(fadeTime: 0.1).register;
});
)


// La guérison

(
~nT.sched(~nT.timeToNextBeat(quant: 5), {

    var synths = [
        // ~noise0, ~noise1, ~bass,
        ~pul3, ~snare, ~snare2, ~hat2,
        // ~hat0, ~hat1,
        // q, t
    ];

    if(j.isPlaying, {j.set(\gate, 0, \fadeTime, 1)});

    j = {
        | low = 1, high = 1.0, pitch = -2, trigGate = 1 |
        var sig, b = 10, trate, dur, clk, pos, pan, dem, beat, melody;
        beat = Impulse.kr(0.25);
        melody = Demand.kr(beat, 0, Dseq([-5].midiratio, inf));
        trate = 16.8561;
        dur = 12 / trate;
        clk = Impulse.kr(trate * 4);
        dem = Demand.kr(clk, 0, Dseq([1, 0.5], inf)) * TRand.kr(low, high, clk);
        pos = 66.3614 + TRand.kr(0, 0.01, clk);
        pan = WhiteNoise.kr(1);
        sig = TGrains2.ar(
            numChannels: 2,
            trigger: clk * trigGate,
            bufnum: b,
            rate: dem * pitch.midiratio * melody,
            centerPos: pos,
            dur: dur,
            pan: pan,
            amp: 0.1,
            att: dur * 0.3,
            dec: dur * 8,
            interp: 4
        );
        LPF.ar(sig, 18000) * 4 * 1.5 * 1.5;
    }.play(fadeTime: 0.1).register;

    synths.do({|i| if(i.isPlaying,
        {i.set(\trigGate, 0, \gate, 0, \fadeTime, 4)})})});
)

(
var synths = [~kick, ~kick2, ~snare, ~bass,
    ~noise0, ~noise1, ~hat0, ~hat1, ~hat2,
    q, t, ~pul3, j,
];
synths.do({|i| if(i.isPlaying, {i.set(\gate, 0, \fadeTime, 0.25)})});
)


(
var synths = [~kick, ~kick2, ~hat0, ~hat1, j];
synths.do({|i| if(i.isPlaying,
    {i.set(\trigGate, 0, \gate, 0, \fadeTime, 4)}
)});
)