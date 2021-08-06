

~sections = ["A", "B", "C"];
~sections;
~sections.size
~sections.mirror
(a = ~sections; (a[0] ++ a[1] ++ a[0] ++ a[2] ++ a[0]));
(
// ~pit = 1;
~piece = Task {
    ~sections.wrapExtend(6).do({
        | item, i |
        // i.postln;
        ~sections[i % ~sections.size].postln;
        4.wait;
    });
    "Done.".postln;
    nil;
}.start(~nT, quant: [4]);
)

~piece.stop;


(
~guitar = Environment.make.know_(true);
~bass = Environment.make.know_(true);
~drums = Environment.make.know_(true);
~hats = Environment.make.know_(true);
)

(
[~guitar, ~bass, ~drums, ~hats].do({
    | item, i |
    // item = Environment.make.know_(true);
    item.play = {
        | envir |
        // "Is this gonna play?".postln;
        envir.use({~synth = ~foo.play});
    };
    item.sleep = {
        | envir, fade = 5 |
        // "Is this gonna stop?".postln;
        envir.use({~synth.set(\gate, 0, \fadeTime, fade)});
    };
    item.foo = {SinOsc.ar(220 + (55 * i)) * 0.2!2}
});
)

~guitare.play;
~guitare.sleep(0.1);

(
~sections = [
    [~guitare],
    [~guitare, ~basse],
    [~guitare, ~basse, ~drums, ~hats]
];
)

(
~piece = Task {
    var durations = [16, 8, 8, 16, 8, 8, 4];
    ~sections.wrapExtend(7).do({
        | s, i |
        // i.postln;
        // if (i > 0, {~sections[i - 1].do({|item| item.sleep;})});
        s.do({|item| item.play});
        // ~sections[i % ~sections.size].postln;
        durations[i].wait;
        s.do({|item| item.sleep(0.1)});
    });
    "Done.".postln;
    nil;
}.start(~nT, quant: [4]);
)

~piece.stop;


(
var sections = [
    [{~guitar.play}, 0],
    [{~basse.play}, 4],
    [{~drums.play}, 0],
    [{~basse.sleep}, 4],
];
)

IdentityDictionary

(
var sections = [
    [
        "introduction",
        4,
        {~guitar.play; ~basse.play;},
        {~basse.sleep;}
    ]
];
)
topEnvironment.use({ ~guitar.play; ~bass.play;});
~guitar
(
var sections = [
    (
        name: "introduction",
        bars: 4,
        play: {"oh!".postln; ~guitar.play; ~bass.play;},
        sleep: {|self, d| d.postln; ~guitar.sleep(d); ~bass.sleep(d);}
    ),
    (
        name: "a",
        bars: 4,
        play: {~guitar.play; ~bass.play; ~drums.play},
        sleep: {|self, d| ~bass.sleep(d); ~guitar.sleep(d); ~drums.sleep(d)}
    )
];
// sections[1][\play].();
~piece = Task {
    sections.do({
        | s, i |
        // if (i > 0, {sections[i - 1][\sleep].(0.01)});
        s.play;
        s.bars.postln;
        s.bars.wait;
        topEnvironment.use(s.sleep(0.01));
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


a = IdentityDictionary(know: true);
a.put(\foo, { | x, y | "--".postln; ("x:" ++ x).postln;  ("y:" ++ y).postln; y.squared });
a.foo(-10.01);

(
a = (
    foo: { | x, y = 10 | "--".postln; ("x:" ++ x).postln;  ("y:" ++ y).postln; y.squared }
);
)
a.foo