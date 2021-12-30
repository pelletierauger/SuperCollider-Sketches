~reverb = Bus.audio(s, 2);

VSTPlugin.pluginList(s, sorted: false);

(
VSTPlugin.search(
    server: s,
    dir: "/Library/Audio/Plug-Ins/VST3/",
    // options: options,
    verbose: true,
    wait: -1,
    // action: action
);
)

(
SynthDef(\xx, {
    | trigGate = 1, relGate = 0 |
    var sig = In.ar(~reverb, 2);
    sig = VSTPlugin.ar(sig, 2,
        bypass: 0,
        // info: 'ValhallaVintageVerb.vst3'
        info: 'ValhallaPlate.vst3',
        // info: 'CHOWTapeModel.vst3'
    );
    // p[dem].poll;
    Out.ar(0, sig);
}).add;
// ~t.sched(~t.timeToNextBeat(quant: 4), {
    // ~x.synth.set(\trigGate, 0, \relGate, 1);
    // ~x = Synth(\xx);
    ~x = VSTPluginController(Synth(\xx)).open;
// });
)
VSTPlugin.plugins(s)['CHOWTapeModel.vst3'].parameters[45];
VSTPlugin.plugins(s)['ValhallaPlate.vst3'].parameters[1];
~x.set(0, 0.4); // Mix
~x.set(1, 0.01); // PreDelay
~x.set(2, 0.8); // Decay
~x.set(3, 0.2); // Size
~x.set(4, 0.25); // Width
~x.set(6, 0.8); // ModDepth
~x.set(9, 0.8); // HighEQFreq
~x.set(10, 0); // HighEQGain
~x.get(1, {arg f; f.postln;});



(
~t.sched(~t.timeToNextBeat(quant: 4), {
    ~w.free;
    // ~x = Synth(\xx);
    ~w = {Impulse.ar(~t.tempo) * 0.25;}.play;
});
)


~bus1 = Bus.control;
~x.set(0, 0.9)
~x.set(5, 0.25)
~x.map(5, ~bus1)
~x.get(45, {arg f; f.postln;});
~x.set(45, 1);
~x.set(46, 0.25);
~x.set(47, 0.1);
~x.get(8)
~x.set(3, 100.04)
~x.set(9, 0.5)

~z.free;
~z = {var sig = SinOsc.kr(6).range(0, 1); Out.kr(~bus1, sig)}.play;


~x.set(10, 1.5)
~fx.set(11, 6) // ModRate
~fx.set(12, 0) // ModDepth
~fx.set(15, 1) // ColorMode
~fx.set(16, 2) // ReverbMode