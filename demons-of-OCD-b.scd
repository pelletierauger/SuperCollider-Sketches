
~nT.tempo = 70 / 60;



[0, 7, 2, 7, 8, 7, 8, 7]
[0, 0, 0, 0, 0, 0, 0, 0]


// note number, stuck or not, depth of stuck state
(
~reset = {
~notes = [
    [0, 0],
    [7, 0],
    [2, 0],
    [7, 0],
    [8, 0],
    [7, 0],
    [8, 0],
    [7, 0]
];
    ~buildMelody.();
};
~reset.();
)
(
~buildMelody = {
    ~melody = [];
    ~decim = [];
    ~bits = [];
    ~lpf = [];
    ~notes.do({|item, i|
        if (item[1] == 0, {
            ~melody = ~melody.add(item[0]);
            ~decim = ~decim.add(0);
            ~bits = ~bits.add(0);
        }, {
            (item[1]+1).do({ |jitem, j|
                ~melody = ~melody.add(item[0]);
                ~decim = ~decim.add(min(j, 32));
                ~bits = ~bits.add(min(j, 5));
            });
        });
        item.postln}
    );
    nil;
};
~buildMelody.();
)
~decim
~melody
(
~compulsion = {
    ~notes.do({|item, i|
        if (item[1] == 0, {
            if (rrand(0.0, 1.0) > 0.9, {
                item[1] = 1;
            });
        }, {
            if (rrand(0.0, 1.0) > 0.9, {
                item[1] = item[1] + 1;
            })
        });
    });
    ~buildMelody.();
    nil;
};
)
~compulsion.();
~buildMelody.();
rrand(0.0, 1.0)
~melody;
~decim
(
~printNotes = {

};
)
[0, 7, 2, 7, 8, 8, 8, 7, 7, 7, 8, 7]
[0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0]


~decim.size


(
{
    if(~drone2.isPlaying, {~drone2.set(\trigGate, 0, \gate, 0, \fadeTime, 2.1)});
    ~think.();


}.fork;
)

~reset.();
(
var run = 0;
~thinkTask = Task {
    {
        if(~drone2.isPlaying, {~drone2.set(\trigGate, 0, \gate, 0, \fadeTime, ~nT.beatDur*0.25)});
    ~think.();
        (~melody.size * (1/4)).wait;
        run = run + 1;
        if (run > 7, {~compulsion.();});
        run.postln;
    }.loop;
}.start(~nT, quant: [2]);
)
~thinkTask.stop;


(
~think = {
    ~drone2 = {
    | trigGate = 1|
    var t = In.kr(~cb, 2)[1] * trigGate;
    var rel = Demand.kr(t, 0, Dwrand([1, 2], [0.9, 0.1], inf));
    var e = EnvGen.kr(Env([0, 1, 0.5, 0], [0.01, 0.05, rel], [6, 0, -6, 'lin']), t);
    var a = (~melody + [0,12].stutter(3)).wrapExtend(~melody.size * 2);
    var b = ([0, 7, 1, 7, 8, 7, 8, 7] + [0,12].stutter(3)).wrapExtend(16);
    var mel = Demand.kr(t, 0, Dseq(a, inf));
    var decim = Demand.kr(t, 0, Dseq(~decim, inf));
    var bits = Demand.kr(t, 0, Dseq(~bits, inf));
    var tim = Demand.kr(t, 0, Dseq([0.63, 0.3].stutter(16), inf));
    var sig = MiBraids.ar(~toMidi.("D3") + mel,
        timbre: 0.63,
        color: 0.5,
        model: 6,
        resamp: 2, decim: decim, bits: bits, ws: 0
    );
        var peak = Demand.kr(t,0,Dwhite(0.0,1.0),inf);
    sig = MiWarps.ar(sig, sig, 0.9, 0.95, algo: 3, timb: 0.75)[0];
    sig = ~v.(sig, (700) * e + 10) + (~v.(sig, 1000, 0, 3)*e*0.025*peak*(bits+1*2));
    sig = ~v.(sig, 250, 0, 5) * 2 ! 2;
}.play().register;
};
)


(
SynthDef.new(\pluckOCD , {
    | trigGate = 1, pitch = 36 |
    var e = EnvGen.kr(Env([0, 1, 0.5, 0], [0.01, 0.05, 1], [6, 0, -6, 'lin']), doneAction: 2);
    var sig = MiBraids.ar(
        pitch: pitch,
        timbre: 0.63,
        color: 0.5,
        model: 6,
        resamp: 2, decim: 0, bits: 0, ws: 0
    );
    sig = MiWarps.ar(sig, sig, 0.9, 0.95, algo: 3, timb: 0.75)[0];
    sig = ~v.(sig, 700 * e + 10);
    sig = ~v.(sig, 250, 0, 5) * 2 ! 2;
    Out.ar(0, sig);
}).add;
)

(
~mel.stop;
~mel = Pbind(
    \instrument, \pluckOCD,
    \dur, Pseq([0.25], inf),
    \pitch, Pseq(~toMidi.("D3") + (~melody + [0,12].stutter(3)).wrapExtend(16), inf),
    \amp, 1
).play(~nT, quant: 2);
)




(
~think = {
    ~drone2 = {
    | trigGate = 1|
    var t = In.kr(~cb, 2)[1] * trigGate;
    var rel = Demand.kr(t, 0, Dwrand([1, 2], [0.9, 0.1], inf));
    var e = EnvGen.kr(Env([0, 1, 0.5, 0], [0.01, 0.05, rel], [6, 0, -6, 'lin']), t);
    var a = (~melody + [0,12].stutter(3)).wrapExtend(~melody.size * 2);
    var b = ([0, 7, 1, 7, 8, 7, 8, 7] + [0,12].stutter(3)).wrapExtend(16);
    var mel = Demand.kr(t, 0, Dseq(a, inf));
    var decim = Demand.kr(t, 0, Dseq(~decim, inf));
    var bits = Demand.kr(t, 0, Dseq(~bits, inf));
    var tim = Demand.kr(t, 0, Dseq([0.63, 0.3].stutter(16), inf));
    var sig = MiBraids.ar(~toMidi.("D3") + mel,
        timbre: 0.63,
        color: 0.5,
        model: 6,
        resamp: 2, decim: decim, bits: bits, ws: 0
    );
    sig = MiWarps.ar(sig, sig + (WhiteNoise.ar()*\wn.kr(0)), 0.9, 0.95, algo: 3, timb: 0.75)[0];
    sig = ~v.(sig, (700 + min(10000, decim * 300)) * e + 10 + (\lpf.kr(0)));
    sig = ~v.(sig, 250, 0, 5) * 2 ! 2;
        // sig = sig + ~v.(CombN.ar(sig, 4, (~nT.beatDur/[3].choose) * [1, 1.01], Rand(1.0, 3.0)) * Rand(0.0, 0.25),3000);
}.play().register;
};
)
~think.()
~drone2.set(\wn, 1)
~drone2.set(\lpf, 440)


(
~think = {
    ~drone2 = {
    | trigGate = 1|
    var t = In.kr(~cb, 2)[1] * trigGate;
    var rel = Demand.kr(t, 0, Dwrand([1, 2], [0.9, 0.1], inf));
    var e = EnvGen.kr(Env([0, 1, 0.5, 0], [0.01, 0.05, rel], [6, 0, -6, 'lin']), t);
    var a = (~melody + [0,12].stutter(3)).wrapExtend(~melody.size * 2);
    var b = ([0, 7, 1, 7, 8, 7, 8, 7] + [0,12].stutter(3)).wrapExtend(16);
    var mel = Demand.kr(t, 0, Dseq(a, inf));
    var decim = Demand.kr(t, 0, Dseq(~decim, inf));
    var bits = Demand.kr(t, 0, Dseq(~bits, inf));
    var tim = Demand.kr(t, 0, Dseq([0.63, 0.3].stutter(16), inf));
    var sig = MiBraids.ar(~toMidi.("D3") + mel,
        timbre: 0.63,
        color: 0.5,
        model: 6,
        resamp: 2, decim: decim, bits: bits, ws: 0
    );
    sig = MiWarps.ar(sig, DelayN.ar(sig, 1, ~nT.beatDur/64), 0.9, 0.95, algo: 3, timb: 0.75)[0];
    sig = ~v.(sig, (700 + min(10000, decim * 300)) * e + 10 + (\lpf.kr(0)));
    sig = ~v.(sig, 250, 0, 5) * 2 ! 2;
        // sig = sig + ~v.(CombN.ar(sig, 4, (~nT.beatDur/[3].choose) * [1, 1.01], Rand(1.0, 3.0)) * Rand(0.0, 0.25),3000);
}.play().register;
};
)