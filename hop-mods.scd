x.free;x = {~v.(MiBraids.ar(27+12, 0.5, ~lfo.(0.1), model: 6),2000) * 0.1 ! 2}.play;
x.free;x = {~v.(MiBraids.ar(27+12, 0.5, ~lfo.([3,3.1],0.5,0.55), model: 14),1000) * 0.3 }.play;

~lfo = {|f,b=0,e=1|SinOsc.kr(f).unipolar.linlin(0,1,b,e)};
~v = {|in,f=500,r=0,t=1|VadimFilter.ar(in,f,r,t)};

y.free;y = {~v.(MiBraids.ar(27-2, 0.5, ~lfo.([3,3.5]*0.1,0.5,1), model: 18),4000) * 0.3 }.play;

y.free;

s.record;


(
x.free;
x = {
    var safeEnv = EnvGen.kr(Env([0,0,1], [0.009,0.001]));
    var sig = MiBraids.ar(27+12, 0.5, ~lfo.([3,3.1],0.5,0.55), model: 14);
    ~v.(sig,1000) * 0.3 * Line.kr(0,1,0.125) * safeEnv;
}.play;
)