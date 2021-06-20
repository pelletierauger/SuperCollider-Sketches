~nT.tempo
~nT.tempo = 1.39;
~nT.tempo = 1.65;

(
~drumsF = {
~nT.sched(~nT.timeToNextBeat(quant: 5), {
    if(~snare.isPlaying, {~snare.set(\gate, 0, \fadeTime, 0.1)});

    ~snare = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * 4);
        var block0 = Demand.ar(trig, 0, Dseq([1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0], inf));
        var block1 = Demand.ar(trig, 0, Dseq([0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0], inf));
        var sig = MiPlaits.ar(
            pitch: 30,
            engine: 9,
            harm: 0.95,
            timbre: 1,
            morph: 0.45 - [0, 0.2],
            trigger: trig * [block0, block1] * trigGate,
            decay: 0.72 + [0, 0.1],
            lpg_colour: 0
        );
        sig = [sig[0][1] + sig[1][1]]!2;
        sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 3.6;
    }.play(fadeTime: 0).register;

    if(~kick2.isPlaying, {~kick2.set(\gate, 0, \fadeTime, 0.1)});

    ~kick2 = {
        | trigGate = 1 |
        var trig, sig, block;
        trig = Impulse.kr(~nT.tempo);
        block = Demand.kr(trig, 0, Dseq([1, 1, 1, 1], inf));
        sig = MiBraids.ar(
            pitch: 72 - 24,
            timbre: 0.85,
            color: 0.9,
            model: 34,
            trig: trig * trigGate * block,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        );
        sig = LPF.ar(sig, 200);
        // sig = sig + ((sig * 100).clip(-1, 1) * 0.15);
        // sig = LPF.ar(sig, 2000);
        sig!2 * 0.25 * 8 * 1.5 * 1.25;
    }.play(fadeTime: 0).register;
});
};
)

(
~bassF = {
~nT.sched(~nT.timeToNextBeat(quant: 5), {

    if(~bass.isPlaying, {~bass.set(\gate, 0, \fadeTime, 0.1)});

    ~bass = {
        | trigGate = 1 |
        var f = 33;
        var lfo = SinOsc.kr(0.1).range(0.1, 0.12);
        var trig = Impulse.ar(~nT.tempo * 4) * trigGate;
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
        LPF.ar(sig, SinOsc.kr(0.1).range(800, 4000)) * 3 * 2;
    }.play.register;
});
};
)

[~snare, ~kick2, ~bass, ~grainDrone].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});


(
[~snare, ~kick2].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});
~nT.sched(~nT.timeToNextBeat(quant: 5) + (~nT.beatDur * 2), {
    [~bass].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

});
)


s.sendMsg(\b_allocRead, 10, "/Users/guillaumepelletier/Desktop/0001 7-Audio-1-mono.wav");

(
~grainF = {
~nT.sched(~nT.timeToNextBeat(quant: 5), {
    if(~grainDrone.isPlaying, {~grainDrone.set(\trigGate, 0, \gate, 0, \fadeTime, 3)});

    ~grainDrone = {
        | low = 1, high = 1.0, pitch = -2, trigGate = 1 |
        var trig, deem, sig, b = 10, trate, dur, clk, pos, pan, dem, beat, melody;
        trig = Impulse.kr(~nT.tempo * 1 * 1 * 0.2 * 0.25) * trigGate;
        deem = Demand.kr(trig, 0, Dseq([60, 66] + 0.3614, inf));
        deem = Demand.kr(trig, 0, Dseq([29.6, 33].reverse + 0.3614, inf));
        beat = Impulse.kr(0.25);
        melody = Demand.kr(beat, 0, Dseq([-5].midiratio, inf));
        trate = 16.8561;
        dur = 12 / trate;
        clk = Impulse.kr(trate * 4);
        dem = Demand.kr(clk, 0, Dseq([1, 0.5], inf)) * TRand.kr(low, high, clk);
        pos = deem + TRand.kr(0, 0.01, clk);
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
        LPF.ar(sig, 18000) * 8;
    }.play(fadeTime: 0.1).register;
});
};
)

[~drumsF, ~bassF, ~grainF].do({|i| i.()});

[~snare, ~kick2, ~bass, ~grainDrone].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

