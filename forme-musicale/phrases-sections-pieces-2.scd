
// ------------------------------------------------------------------- //
// Meilleure solution que je peux imaginer pour le moment.
// ------------------------------------------------------------------- //

~nT = TempoClock.new(1.39 * 1.25 * 1.075).permanent_(true);

(
~guitar = Environment.make.know_(true);
~bass = Environment.make.know_(true);
~drums = Environment.make.know_(true);
~hats = Environment.make.know_(true);

[~guitar, ~bass, ~drums, ~hats].do({
    | item, i |
    item.play = {
        | envir |
        envir.use({~synth = ~foo.play});
    };
    item.sleep = {
        | envir, fade = 5 |
        envir.use({~synth.set(\gate, 0, \fadeTime, fade)});
    };
    item.foo = {SinOsc.ar(220 + (55 * i)) * 0.2!2}
});
)

(
var sections = [

    // --------------------------------------------------------------- //
    // Introduction
    // --------------------------------------------------------------- //
    [
        \name, "Introduction",
        \dur, 3.25 - 0.015 + 4,
        \play, {
            ~guitar.play;
            ~bass.play;
            ~met = {Impulse.ar(~nT.tempo) * 0.1!2}.play(fadeTime: 0);
        },
    ],
    [
        \name, "Intro, sleep",
        \dur, 0.75 + 0.015,
        \play, {var d = 0.015; ~guitar.sleep(d); ~bass.sleep(d);}
    ],

    // --------------------------------------------------------------- //
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
            ~bass.sleep(d);
            ~guitar.sleep(d);
            ~drums.sleep(d);
            ~hats.sleep(d);
        }
    ],
    [
        \name, "Stop metro",
        \dur, 0,
        \play, {
            ~met.free;
        }
    ]
];

~piece = Task {
    sections.do({
        | s, i |
        var name = s[1], dur = s[3], play = s[5], sleep = s[7];
        name.postln;
        play.();
        dur.postln;
        dur.wait;
    });
    "Done.".postln;
}.start(~nT, quant: [4]);
)




// ------------------------------------------------------------------- //
// Recherche
// ------------------------------------------------------------------- //


(
var sections = [
    [
        \name, "Introduction",
        \bars, 4,
        \play, {~guitar.play; ~bass.play;},
        \sleep, {|d| ~guitar.sleep(d); ~bass.sleep(d);}
    ],
    [
        \name, "Section A",
        \bars, 4,
        \play, {
            ~guitar.play;
            ~bass.play;
            ~drums.play;
        },
        \sleep, {|d| ~bass.sleep(d); ~guitar.sleep(d); ~drums.sleep(d)}
    ]
].wrapExtend(4);

~piece = Task {
    sections.do({
        | s, i |
        var name = s[1], bars = s[3], play = s[5], sleep = s[7];
        name.postln;
        play.();
        bars.postln;
        bars.wait;
        sleep.(0.1);
    });
    "Done.".postln;
    nil;
}.start(~nT, quant: [4]);
)



[[1, 2],[1, 2]].stutter(2)
Array




(
a = [\freq -> 452, \amp -> 0.2];
a[0].value;
)



(
var sections = [
    [
        \name, "introduction",
        \bars, 4,
        \play, {"ah!".postln; ~guitar.play; ~bass.play;},
        \sleep, {|d| d.postln; ~guitar.sleep(d); ~bass.sleep(d);}
    ],
    [
        \name, "a",
        \bars, 4,
        \play, {~guitar.play; ~bass.play; ~drums.play},
        \sleep, {|d| ~bass.sleep(d); ~guitar.sleep(d); ~drums.sleep(d)}
    ]
];
sections[0][\name]
// s
)











(
var sections = [
    [
        \name, "introduction",
        \bars, 4,
        \play, {"ah!".postln; ~guitar.play; ~bass.play;},
        \sleep, {|d| d.postln; ~guitar.sleep(d); ~bass.sleep(d);}
    ],
    [
        \name, "a",
        \bars, 4,
        \play, {~guitar.play; ~bass.play; ~drums.play},
        \sleep, {|self, d| ~bass.sleep.(d); ~guitar.sleep.(d); ~drums.sleep.(d)}
    ]
];
var dict = ();
(sections.size / 2).do({
    |item, i|
    dict.put(sections[i * 2], sections[i * 2 + 1]);
});
// sections[1][\play].();
~piece = Task {
    sections.do({
        | s, i |
        // if (i > 0, {sections[i - 1][\sleep].(0.01)});
        s[5].();
        s[3].postln;
        s[3].wait;
        s[7].(0.01);
        /*        ~nT.sched(~nT.timeToNextBeat(quant: 4) - ~nT.beatDur, {
        s[\sleep].();
        });*/
    });
    // sections
    /*    ~sections.wrapExtend(7).do({
    | s, i |
    // i.postln;
    // if (i > 0, {~sections[i - 1].do({|item| item.sleep;})});
    s.do({|item| item.play});
    // ~sections[i % ~sections.size].postln;
    durations[i].wait;
    s.do({|item| item.sleep(0.1)});
    });*/
    "Done.".postln;
    nil;
}.start(~nT, quant: [4]);
)
