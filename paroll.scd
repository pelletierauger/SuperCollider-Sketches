(
~pr.sequence
)


(
var loop=true;
var pat = Plazy({
    var pr = ~pr;
    var pattern = pr.sequence.asPattern;
    var pbeats = pr.sequence.dur;
    Pchain(
        Pbind(\instrument, \gliSynth, \__, Pfunc({
            | e |
            pr.notePlay(e);
        })),
        Psync(pattern, pbeats, pbeats),
    );
});
Pdef(\__pianoRoll, if(loop, Pn(pat), pat));
Pdef(\__pianoRoll).play;
)