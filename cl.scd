s.record;
s.stopRecording;
~recFolder.openOS



~cl = TempoClock.new(68 / 60).permanent_(true);


(
~x.free;
~x = {
    Impulse.ar(~cl.tempo * 2) * 0.1!2;
}.play;
)