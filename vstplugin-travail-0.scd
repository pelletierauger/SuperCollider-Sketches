VSTPlugin


VSTPlugin.pluginList(s, sorted: false)

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

VSTPluginDesc('CHOWTapeModel.vst3').parameters


VSTPlugin.plugins(s)['CHOWTapeModel.vst3'].parameters[2];
VSTPlugin.plugins(s)['CHOWTapeModel.vst3'].parameters.size;


VSTPlugin.plugins(s)['ValhallaVintageVerb.vst3'].parameters[11];



VSTPlugin.readPlugins



(
// two FX in parallel:
SynthDef(\test, { arg bus;
    var sig = VSTPlugin.ar(Impulse.ar(1), 2, id: \verb);
    //     sig = VSTPlugin.ar(sig, 2, id: \chorus);
    Out.ar(0, sig);
}).add;
)

// There are two ways to control individual plugins:
// 1) get individual VSTPluginControllers
(
~synth = Synth(\test);
~verbb = VSTPluginController.new(~synth, \verb).open("ValhallaVintageVerb.vst3");
~chorus = VSTPluginController.new(~synth, \chorus).open("myChorus");
)