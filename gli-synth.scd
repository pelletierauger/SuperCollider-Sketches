MIDIClient.init;
MIDIIn.connect;

(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    ~playedNotes[num - 20].do({
        | item, i |
        if (item.isNil == false, {
            item.set(\releaseGate, 1);
        });
    });
    ~playedNotes[num][0] = Synth.new(\gliSynth, [pitch: num, vel: vel / 128]);

};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)


(
MIDIIn.removeFuncFrom(\noteOff, ~noteOff);
~noteOff = {
    arg src, chan, num, vel;
    ~playedNotes[num].do({
        | item, i |
        if (item.isNil == false, {
            item.set(\releaseGate, 1);
        });
    });
};
MIDIIn.addFuncTo(\noteOff, ~noteOff);
)

~playedNotes = Array.fill(200, {Array.fill(3)});



(
SynthDef(\gliSynth, {
    | trigGate = 1, releaseGate = 0, pitch = 60, vel = 1 |
    var env = EnvGen.kr(
        Env(
            levels: [1, 1, 0],
            times: [0.001, 2],
            curve: ['lin', -8],
            releaseNode: 1
        ),
        gate: Trig.kr(releaseGate),
        doneAction: 2
    );
    var sig = MiBraids.ar(
        pitch: pitch,
        timbre: env,
        color: [0.8, 0.95] - 0.2,
        model: 37,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    ) * 2!2;
    sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 100 + (4700 * env * (0.1 + vel)), 0, 1) * 1 * env!2;
    Out.ar(0, sig * 0.1);
}).add;
)




~trigBus = Bus.control(s, 1);


(
~nT.sched(~nT.timeToNextBeat(quant: 12), {
    y.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    y = {
        | trigGate = 1 |
        var eg = EnvGate.new();
        // var t = Impulse.kr(~nT.tempo) * trigGate;
        var t = In.kr(~trigBus, 1);
        var b = t;
        var d = Demand.kr(b, 0, Dseq([0.15, 0.15, 0.15, 0.5].rotate(1), inf));
        var d2 = Demand.kr(b, 0, Dseq([0, 500].reverse.stutter(4), inf));
        var d3 = Demand.kr(b, 0, Dseq([2, 1], inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, ~nT.beatDur * d3], [0, 6]), b);
        var se = EnvGen.kr(Env([0, 0, 1], [0.1, 0.1]));
        var sig = MiBraids.ar(
            pitch: 20 + 5,
            timbre: 0.25,
            color: [0.8, 0.95] - 0.2,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        ) * 2!2 * e;
        sig = (Decimator.ar(sig, 1000, 2) * 0.4);
        sig = VadimFilter.ar(sig, 500 + d2, 0, 5);
        sig = VadimFilter.ar(sig, 1700, 0.25, 1) * 3 * se * eg;
        Out.ar(0, sig);
    }.play(fadeTime: 0);
});
)


(
SynthDef(\gliSynth, {
    | trigGate = 1, releaseGate = 0, pitch = 60, vel = 1 |
    var env = EnvGen.kr(
        Env(
            levels: [1, 1, 0],
            times: [0.001, 2],
            curve: ['lin', -8],
            releaseNode: 1
        ),
        gate: Trig.kr(releaseGate),
        doneAction: 2
    );
    var sig = MiBraids.ar(
        pitch: pitch,
        timbre: env,
        color: [0.8, 0.95] - 0.2,
        model: 37,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    ) * 2!2;
    sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 100 + (2700 * env * (0.1 + vel)), 0, 1) * 1 * env!2;
    Out.ar(0, sig * 0.1);
}).add;
)



(
SynthDef(\gliSynth, {
    | trigGate = 1, releaseGate = 0, pitch = 60, vel = 1 |
    var env = EnvGen.kr(
        Env(
            levels: [1, 1, 0],
            times: [0.001, 2],
            curve: ['lin', -8],
            releaseNode: 1
        ),
        gate: Trig.kr(releaseGate),
        doneAction: 2
    );
    var sig = MiBraids.ar(
        pitch: pitch,
        timbre: env,
        color: [0.8, 0.95] - 0.1,
        model: 37,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    ) * 2!2;
    sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 100 + (2700 * env * (0.1 + vel)), 0, 1) * 1 * env!2;
    Out.ar(0, sig * 0.1);
}).add;
)



(
SynthDef(\gliSynth, {
    | trigGate = 1, releaseGate = 0, pitch = 60, vel = 1 |
    var env = EnvGen.kr(
        Env(
            levels: [1, 1, 0],
            times: [0.001, 2],
            curve: ['lin', -8],
            releaseNode: 1
        ),
        gate: Trig.ar(releaseGate),
        doneAction: 2
    );
    var sig = MiBraids.ar(
        pitch: pitch,
        timbre: env,
        color: [0.8, 0.95] + 0.5 * Line.kr(1, 0.5, 2),
        model: 37,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    ) * 2!2;
    sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 100 + (2700 * env * (0.1 + vel)), 0, 1) * 1 * env!2;
    Out.ar(0, sig * 0.05);
}).add;
)



(
SynthDef(\gliSynth, {
    | trigGate = 1, releaseGate = 0, pitch = 60, vel = 1 |
    var env = EnvGen.kr(
        Env(
            levels: [1, 1, 0],
            times: [0.001, 2],
            curve: ['lin', -8],
            releaseNode: 1
        ),
        gate: Trig.ar(releaseGate),
        doneAction: 2
    );
    var sig = MiBraids.ar(
        pitch: pitch,
        timbre: env,
        color: [0.8, 0.95] + 0.5,
        model: 37,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    ) * 2!2;
    sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    sig = VadimFilter.ar(sig, 100 + (2700 * env * (0.1 + vel)), 0, 1) * 1 * env!2;
    Out.ar(0, sig * 0.05);
    Out.ar(~reverb, sig * 0.05);
}).add;
)