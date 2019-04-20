s.boot;

(
var notesPerMz = 10;
var freqArr = Array.fill(notesPerMz, {rrand(100,800)});
p = Pbind(
\freq, Pn(Plazy({
var pat = Pseq(freqArr.postln, 1);
freqArr = freqArr + Array.fill(freqArr.size, {
rrand(-100, 100) * 0.5.coin.asInteger
});
pat;
}), inf),
\dur, 0.1
).play;
)




