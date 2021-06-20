(
~nT.sched(~nT.timeToNextBeat(quant: 2) - 0.05, {

    if(~vibMelo.isPlaying, {~vibMelo.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});

    ~vibMelo = {
        | trigGate = 1 |
        var ff = 42;
        var trig = Impulse.ar(~nT.tempo * 1) * trigGate;
        var dem = Demand.ar(trig, 0, Dseq([0.4, 0.5].stutter(1), inf));
        var alt0 = trig * Demand.ar(trig, 0, Dseq([1, 0], inf));
        var alt1 = trig * Demand.ar(trig, 0, Dseq([0, 1], inf));
        var note0 = Demand.ar(trig * alt0, 0, ff + 12 +
            Dseq([-7, -9, -7, -12, -7, -9, -5, -12].stutter(2), inf));
        var note1 = Demand.ar(trig * alt1, 0, ff + 12 +
            Dseq([-9, -7, -12, -7, -9, -5, -12].stutter(2), inf));
        var sig = MiPlaits.ar([note0, note1],
            engine: 3,
            harm: 0.25,
            timbre: 0.0,
            morph: 0.5,
            trigger: [alt0, alt1],
            decay: 0.1,
            lpg_colour: 0,
            mul: 3);
        sig = [sig[0][0], sig[1][0]];
       sig = (sig * 0.15) + [MiRings.ar(sig[0],
            trig: 0,
            pit: [note0, note1],
            struct: 0.9,
            bright: dem,
            damp: 0.65 - (dem * 0.125),
            pos: 2,
            bypass: 0),
        MiRings.ar(sig[1],
            trig: 0,
            pit: [note0, note1],
            struct: 0.9,
            bright: dem,
            damp: 0.65 - (dem * 0.125),
            pos: 2,
            bypass: 0)];
        // sig = [sig[0] + sig[1], sig[0] + sig[1]];
        sig = sig * 0.5;
    }.play(fadeTime: 15).register;
});
)


// Petit air de piano pour accompagner.


(
var key = 42 + 12;
var notes = key + ([0, 3]);
~pianoRiff.stop;
~pianoRiff = Pbind(
    \type, \pianoEvent,
    \dur, Pseq(0.5!1 ++ (0.25!3) * 4, inf),
    \num, Pseq(notes, inf) + Pseq([0, 12, 0, 24].stutter(8), inf),
    \dyn, Pseq([0], inf),
    \amp, Pseq([0.5, 2, 2, 0.5] * 0.5, inf),
    \pan, Pwhite(-0.75, 0.75, inf),
    \rel, 4
).play(~nT, quant: [2, 0.2]);
)



(
var synths = [~crushedPerc2, ~kick, ~kick2, ~vibra0, ~vibra1, ~vibMelo, ~billes0, ~billes1];
// ~nT.sched(~nT.timeToNextBeat(quant: 1), {
    synths.do({|i| if(i.isPlaying,
    {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)}
)});
)


(
~pianoRiff.stop;
~guitareC.stop;
~guitareD.stop;
~guitareDB.stop;
)


(
~nT.sched(~nT.timeToNextBeat(quant: 2), {

    if(~vibMelo2.isPlaying, {~vibMelo2.set(\gate, 0, \fadeTime, 0.1)});

    ~vibMelo2 = {
        | trigGate = 1 |
        var ff = 42 + 24;
        var trig = Impulse.ar(~nT.tempo * 1) * trigGate;
        var dem = Demand.ar(trig, 0, Dseq([0.4, 0.5].stutter(1), inf));
        var alt0 = trig * Demand.ar(trig, 0, Dseq([1, 0], inf));
        var alt1 = trig * Demand.ar(trig, 0, Dseq([0, 1], inf));
        var note0 = Demand.ar(trig * alt0, 0, ff + 12 +
            Dseq([-7, -9, -7, -12, -7, -9, -5, -12].stutter(2), inf));
        var note1 = Demand.ar(trig * alt1, 0, ff + 12 +
            Dseq([-9, -7, -12, -7, -9, -5, -12].stutter(2), inf));
        var sig = MiPlaits.ar([note0, note1],
            engine: 3,
            harm: 0.25,
            timbre: 0.0,
            morph: 0.5,
            trigger: [alt0, alt1],
            decay: 0.1,
            lpg_colour: 0,
            mul: 3);
        sig = [sig[0][0], sig[1][0]];
       sig = (sig * 0.15) + [MiRings.ar(sig[0],
            trig: 0,
            pit: [note0, note1],
            struct: 0.9,
            bright: dem,
            damp: 0.25 - (dem * 0.125),
            pos: 2,
            bypass: 0),
        MiRings.ar(sig[1],
            trig: 0,
            pit: [note0, note1],
            struct: 0.9,
            bright: dem,
            damp: 0.25 - (dem * 0.125),
            pos: 2,
            bypass: 0)];
        // sig = [sig[0] + sig[1], sig[0] + sig[1]];
        sig = sig * 0.5;
    }.play(fadeTime: 0).register;
});
)

(
    [~vibMelo, ~vibra0, ~vibra1].do({|i| if(i.isPlaying,
    {i.set(\trigGate, 0, \gate, 0, \fadeTime, 4)}
)});
)


(
~sched = {
    |synth, clock, |
    a.postln;
    b.postln;
};
)

~sched.("ah", "bee")