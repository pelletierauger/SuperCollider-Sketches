~recordingFolder.openOS;


s.record;
s.stopRecording;

(
{
    var env = EnvGen.kr(Env([0, 1, 0], [0.01, 1], [0, -8]), doneAction: 2);
    var sig = MiBraids.ar() * env;
    sig = VadimFilter.ar(sig, 1500 * env + 100, 0, 1);
    sig * 0.1!2;
}.play;
)

