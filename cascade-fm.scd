/* Cascade FM example
   (C) Fernando Lopez-Lezcano 2007-2008
*/

// boot the server if you have not done so

s=Server.local.boot

// and boot the SwingOSC gui server

g = SwingOSC.default;
g.boot;

// and switch the GUI being used from the cocoa default to swing

GUI.swing;

// define the instrument we are using, an fm cascade modulation ins
//
// output will go to two audio busses, you can connect the main bus
// to the speaker and the auxiliary bus to, for example, the jaaa
// realtime spectrum analyzer (the auxiliary audio bus corresponds
// by default to channel number 5 in the SuperCollider Jack outputs)

(
SynthDef("cascadefm", { arg 
	freq = 440, carPartial = 1, 
	mod1Partial = 1, index1 = 3, 
	mod2Partial = 1, index2 = 0,
	amp = 0.05,
	// starts and stops the main envelope
	gate=1,
	// mutes the main audio output but not the scope output
	mute=1,
	// the main output bus, this is what we hear and can mute
	bus=0,
	// the auxiliary scope bus, this one is always on
	scopebus=4;

	var mod1, mod2, carrier;
	
	mod2 = SinOsc.ar(
		freq * mod2Partial, 
		0, 
		freq * index2
	);
	mod1 = SinOsc.ar(
		(freq * mod1Partial) + mod2, 
		0, 
		freq * index1
	);
	carrier = SinOsc.ar(
		(freq * carPartial) + mod1, 
		0, 
		amp
	);
	// this is what we listen to and can mute
	Out.ar(
		bus,
		carrier * 
		// this envelope is controlled by "mute", it eliminates clicks when
		// we mute and unmute the audio output, every time mute changes
		// state it either stops or starts the envelope
		EnvGen.kr(Env.adsr(0.1, 0.1, 1.0, 0.1, 1.0), mute) *
		// this is the real envelope, when it is done the instrument
		// is done and all resources are deallocated in the server
		EnvGen.kr(Env.adsr(0.3, 0.3, 1.0, 0.3, 1.0), gate, doneAction:2)
	);
	// this goes to the external spectrum analyzer, it is "on" all the time
	Out.ar(
		scopebus,
		carrier
	)
}).send(s);
)

// Set up a control window for tweaking parameters in realtime
//
// the interface is very simple, one button to start / stop the 
// synthesizer, another to mute / unmute audio output to the 
// speaker. Sliders control the central frequency, the frequency
// multiplier for the carrier and modulator, the modulation
// index and the overall amplitude of the generated sound.

(
var w, i, startButton, muteButton, freqControl, carPartial;
var mod1Partial, index1Control;
var mod2Partial, index2Control;
var ampControl, cmdPeriodFunc;

// create the window, make it visible and the front window
w = GUI.window.new("Simple FM control panel", Rect(20, 400, 440, 10*24));
w.front;
w.view.decorator = FlowLayout(w.view.bounds);

// add a button to start and stop the synthesizer
startButton = GUI.button.new(w, 75 @ 24);
startButton.states = [
	["Start", Color.black, Color.green],
	["Stop", Color.white, Color.red]
];
startButton.action = {|view|
		if (view.value == 1) {
			// start an instance of the synthdef
			i = Synth("cascadefm", ["freq", freqControl.value,
				"carPartial", carPartial.value,
				"mod1Partial", mod1Partial.value,
				"index1", index1Control.value,
				"mod2Partial", mod2Partial.value,
				"index2", index2Control.value,
				"amp", ampControl.value.dbamp,
			    "mute", muteButton.value]);
			// register the synth so we can query its state
			NodeWatcher.register(i);
		};
		if (view.value == 0) {
			i.set("gate", 0);
		};
};

// add a button to mute the main audio output
muteButton = GUI.button.new(w, 75 @ 24);
muteButton.states = [
	["Mute ON", Color.white, Color.red],
	["Mute OFF", Color.black, Color.green]
];
muteButton.action = {|view|
		if (view.value == 1) {
			// each time we change a parameter we check to see whether
			// the synth exists at all _and_ is running, this eliminates
			// warning messages that otherwise get posted to the sclang
			// output if we manipulate the gui while the synth has been
			// stopped
			if (i.notNil and: {i.isRunning}) { i.set("mute", 1) };
		};
		if (view.value == 0) {
			if (i.notNil and: {i.isRunning}) { i.set("mute", 0) };
		};
};

// create sliders for all synthesis parameters
w.view.decorator.nextLine;
freqControl = GUI.ezSlider.new(w, 400 @ 24, "Frequency", ControlSpec(100, 2000, \exp), 
	{|ez| if (i.notNil and: {i.isRunning}) { i.set("freq", ez.value) } }, 440);
	
w.view.decorator.nextLine;
carPartial = GUI.ezSlider.new(w, 400 @ 24, "C Partial", ControlSpec(0, 20, \lin), 
	{|ez| if (i.notNil and: {i.isRunning}) { i.set("carPartial", ez.value) } }, 1);
	
w.view.decorator.nextLine;
mod1Partial = GUI.ezSlider.new(w, 400 @ 24, "M1 Partial", ControlSpec(0, 20, \lin), 
	{|ez| if (i.notNil and: {i.isRunning}) { i.set("mod1Partial", ez.value) } }, 1);
	
w.view.decorator.nextLine;
index1Control = GUI.ezSlider.new(w, 400 @ 24, "M1 Index", ControlSpec(0, 30, \lin),
	{|ez| if (i.notNil and: {i.isRunning}) { i.set("index1", ez.value) } }, 0);
	
w.view.decorator.nextLine;
mod2Partial = GUI.ezSlider.new(w, 400 @ 24, "M2 Partial", ControlSpec(0, 20, \lin), 
	{|ez| if (i.notNil and: {i.isRunning}) { i.set("mod2Partial", ez.value) } }, 1);
	
w.view.decorator.nextLine;
index2Control = GUI.ezSlider.new(w, 400 @ 24, "M2 Index", ControlSpec(0, 30, \lin),
	{|ez| if (i.notNil and: {i.isRunning}) { i.set("index2", ez.value) } }, 0);
	
w.view.decorator.nextLine;
ampControl = GUI.ezSlider.new(w, 400 @ 24, "Amp", \db, 
	{|ez| if (i.notNil and: {i.isRunning}) { i.set("amp", ez.value.dbamp) } }, -6);

// set start button to zero upon a C-c C-s
cmdPeriodFunc = { startButton.value = 0; };
CmdPeriod.add(cmdPeriodFunc);

// stop the sound when window closes and remove cmdPeriodFunc.
w.onClose = {
	// see if the synth is still running before trying to free it
	if (i.notNil and: {i.isRunning}) {
		i.free;
	};
	CmdPeriod.remove(cmdPeriodFunc);
};

)
