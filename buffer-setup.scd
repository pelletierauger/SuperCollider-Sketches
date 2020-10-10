(
var path = PathName.new(thisProcess.nowExecutingPath).parentPath ++ "audio/";
)


(
a = {SinOsc.ar(220!2) * 0.1}.play;
)
a.set(\gate, 0, \fadeTime, 5);