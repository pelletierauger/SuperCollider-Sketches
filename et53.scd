(1..10)
(0..9)*3

(0..100)/10


Scale

t = Tuning.et53
t.ratios[52]
t[[0, 5]]
t[[52]].midiratio


(
x.free;
x = {
    var t = Tuning.et53.ratios ++ (Tuning.et53.ratios + 1) ++ (Tuning.et53.ratios + 2);
    var ch = t[((0..5)*24)];
    var f = ~toFreq.("E2") * ch;
    MiBraids.ar(f.cpsmidi, timbre: 0.25, color: 0.5, model: 3).sum * 0.1!2;
}.play;
)


(
var t = Tuning.et53;
t[((0..5)*21)].midiratio;
// ch;
)