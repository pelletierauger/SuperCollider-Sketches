
s.record;
s.stopRecording;

// No click when recording
{VadimFilter.ar(SinOsc.ar(), 500, 0, 1) * 0.1!2}.play;
{VadimFilter.ar(MiRings.ar(SinOsc.ar()), 500, 0, 1) * 0.1!2}.play;
{VASEM12.ar(SinOsc.ar(), 500, 0, 1) * 0.1!2}.play;
{LPF.ar(MiBraids.ar()) * 0.1!2}.play;
{LPF.ar(MiBraids.ar()) * 0.1!2}.play;
{LPF.ar(MiBraids.ar()) * 0.1!2 * EnvGen.kr(Env([0,0,1], [0.006,0.001]))}.play;
{LPF.ar(MiWarps.ar(SinOsc.ar())) * 0.1!2}.play;
{LPF.ar(Sanitize.ar(MiPlaits.ar()), 500) * 0.1!2}.play;


{CheckBadValues.ar(in: LPF.ar(MiBraids.ar()) * 0.1, post: 1)}.play;


// Click when recording
{MiBraids.ar() * 0.1!2}.play;
{MiPlaits.ar() * 0.1!2}.play;
{VadimFilter.ar(MiBraids.ar(20), SinOsc.kr(0.1).range(10, 2500), 0, 1) * 0.1!2 * EnvGen.kr(Env([0,0,1], [0.006,0.001]))}.play;
{VadimFilter.ar(MiPlaits.ar(), 500, 0, 1) * 0.4!2 * EnvGen.kr(Env([0,0,1], [0.006,0.001]))}.play;
{VadimFilter.ar(MiWarps.ar(SinOsc.ar()), 500, 0, 1) * 0.1!2 * EnvGen.kr(Env([0,0,1], [0.008,0.001]))}.play;
{VASEM12.ar(MiBraids.ar(), 500, 0, 1) * 0.1!2}.play;


{VadimFilter.ar(MiBraids.ar(110, 1, 1, 36), 12500, 0, 1) * 0.1!2 * EnvGen.kr(Env([0,0,1,1, 0], [0.001,0.006, 1, 0.1]), doneAction: 2)}.play;



Safety(s).disable;
Safety(s).enabled;
s.queryAllNodes; // gone
CmdPeriod.run; // -> no post after  cmd-.

// enable again
Safety(s).enable;