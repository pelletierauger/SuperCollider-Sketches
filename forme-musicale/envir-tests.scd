a = Passage.new;


a.addSynth({SinOsc.ar(110)!2 * 0.2})
a.addSynth(3)
a.play;
a.stop;


(
a.addSynth({
   var t = Impulse.kr(6);
   var dem = Demand.kr(t, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0], inf));
   var env = EnvGen.kr(Env([0, 1, 0], [0.0125, 0.5], [2, -8, 'lin']), t * dem);
   SinOsc.ar(440)!2 * 0.2 * env;
});
)

a.setBeatsArr([1, 0, 0, 1, 0, 0, 1, 0]);



(
~riff = Environment.make({
    ~a = 100;
    ~b = 200;
    ~c = 300;
    ~synths = [];
    ~addSynth = {
        | foo |
        ~synths = ~synths.add(foo);
    };
    ~play = {
        ~synths.do({|item, i| item.play});
    };
    ~free = {
        ~synths.do({|item, i| item.free});
    }
});
a.postln;
)

a.use({~a.postln;});

~riff.use({~arr = [1, 0, 0, 1, 0, 0, 1, 0]});
(
~riff.use({~addSynth.({
   var t = Impulse.kr(6);
   var dem = Demand.kr(t, 0, Dseq(~arr, inf));
   var env = EnvGen.kr(Env([0, 1, 0], [0.0125, 0.5], [2, -8, 'lin']), t * dem);
   SinOsc.ar(110)!2 * 0.2 * env;
})});
)

~riff.use({~play.()});
a.use({~synths.postln});
a.use({~synth = ~synth.play});
a.use({~synth.free});


(
a = [1, 2];
a.add(15)
)


(
e = Environment[
    'someVariable' -> 5,
    'printMe' -> { |self, string| string.postln }
];
)

e.know = true;
e.someVariable
e.test = "4"
e.test
e.use({~test.postln})
e.use({~myBeautifulSynth = {"La beauté du monde me foudroie.".postln}})
e.myBeautifulSynth.()


e = (someVariable: 5, printMe: { |self, string| string.postln });
e.test = "4"
e.test
e.myBeautifulSynth = {"La beauté du monde me foudroie.".postln};
e.myBeautifulSynth
e.use({~myBeautifulSynth.()})
e.foo = {SinOsc.ar(220) * 0.2!2}
e.foo
e.use({~play = {~foo.play}})
e.use({~foo.play})
e.play
e.use({~play.()})

(
e.myBeautifulSynth = {
    (10 * 50).postln;
    "La beauté du monde me foudroie.".postln;
    ~foo.play;
};
)
e.myBeautifulSynth
e.use({~myBeautifulSynth.()})


//  ----

e = Environment.make;
e.know = true;
e.foo = {SinOsc.ar(110) * 0.2!2};

e.foo; // returns [ a BinaryOpUGen, a BinaryOpUGen ]

e.use({~foo.play}); // this works

e.foo.play; // ERROR: Message 'play' not understood.


// Trying to make a play method.

(
e.play = {
    | envir |
    // "Is this gonna play?".postln;
    envir.use({~synth = ~foo.play});
};
)
(
e.sleep = {
    | envir, fade = 5 |
    // "Is this gonna stop?".postln;
    envir.use({~synth.set(\gate, 0, \fadeTime, fade)});
};
)
e.play; // This prints the text but doesn't play the Synth. No errors. Returns nil.
e.use({~synth.set(\gate, 0, \fadeTime, 5)});
e.sleep(1.1);
e.use({~stop = {| envir | "oh!".postln; envir.use({~sleep.()})}});
e.stop;
e.degrade = {"Ah!".postln};
e.degrade;
e.use({~degrade.()})
e.use({~play.(e)}) // This prints the text and plays the Synth. Returns the Synth.

~riff = Environment.make.know_(true);
~riff.a = "ah!";
~riff.a;
~riff.a = {(50 * 12).postln};
~nT = TempoClock.new(1.39).permanent_(true);




