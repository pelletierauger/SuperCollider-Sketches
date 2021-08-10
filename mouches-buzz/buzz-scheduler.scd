

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

    ~met = {Impulse.ar(~nT.tempo) * 0.1!2}.play(fadeTime: 0);
    ~met2 = {
        var imp = Impulse.ar(~nT.tempo * 3) * 0.1;
        var dem = Demand.ar(imp, 0, Dseq([0, 0, 1], inf));
        imp * dem!2 * 0.5;
    }.play(fadeTime: 0);
});
)
~met.free; ~met2.free;
~granulator.set(\trigGate, 0);

(
var sections = [

    // --------------------------------------------------------------- //
    // Introduction
    // --------------------------------------------------------------- //
    [
        \name, "Introduction",
        \dur, 0,
        \delta, -0.05,
        \play, {
            // ~guitar.play;
            // ~bass.play;
            // ~metronome.set(\gate, 0, \fadeTime, 0);
            [~hellStrum].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});});

            ~stopAll.();
            // ~granulator.set(\trigGate, 1);

            ~buzzFragi2.();
            // ~met = {Impulse.ar(~nT.tempo) * 0.1!2}.play(fadeTime: 0);
            // ~leadSqueak.();
        },
    ],
    [
        \name, "Druuuums",
        \dur, 32,
        \delta, 0,
        \play, {~lowDrum.()}
    ],
    [
        \name, "Intro, sleep",
        \dur, 32,
        \delta, 0,
        \play, {
            // var d = 0.015; ~guitar.sleep(d); ~bass.sleep(d);
            // ~slideB.();
            /*            ~met = {Impulse.ar(~nT.tempo) * 0.1!2}.play(fadeTime: 0);
            ~met2 = {
            var imp = Impulse.ar(~nT.tempo * 3) * 0.1;
            var dem = Demand.ar(imp, 0, Dseq([0, 0, 1], inf));
            imp * dem!2 * 0.5;
            }.play(fadeTime: 0);*/
            ~crunchKick.();
        }
    ],
    [
        \name, "Druuuums",
        \dur, 32,
        \delta, 0,
        \play, {~trashSnare.()}
    ],

    /*    // --------------------------------------------------------------- //
    // Section A
    // --------------------------------------------------------------- //
    [
    \name, "Section A",
    \dur, 8,
    \play, {
    ~guitar.play;
    ~bass.play;
    ~drums.play;
    ~hats.play;
    }
    ],
    [
    \name, "Conclusion",
    \dur, 4,
    \play, {
    var d = 2;
    // ~bass.sleep(d);
    // ~guitar.sleep(d);
    // ~drums.sleep(d);
    // ~hats.sleep(d);
    [~bass, ~guitar, ~drums, ~hats].do({|i| i.sleep(d)});
    [~lead].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)})});
    }
    ],
    [
    \name, "Stop metronome",
    \dur, 0,
    \play, {
    ~met.free;
    }
    ]*/
];

~piece = Task {
    // {
    var totalDur = 0;
    sections.do({
        | s, i |
        var name = s[1], dur = s[3], delta = s[5], play = s[7], sleep = s[9];
        var separator = ["-"].stutter(30 - name.size).toString;
        ~nT.sched(~nT.timeToNextBeat(quant: 4) + delta, {
            (name ++ " " ++ separator ++ " Duration: " ++ dur).postln;
            play.();
        });
        dur.wait;
        // totalDur = totalDur + dur;

        // dur.wait;
    });
    // }.loop;
    "Done.".postln;
}.start(~nT);
)