(
Ndef(\modulated_chen, {|amp=0.5|
    var chenspeedMax = 0.01;
    var chen = Chen.ar(LFCub.kr(0.1).range(0.001,chenspeedMax));
    var minfreq = 20.0, maxfreq=2500.0;
    var sig = SinOsc.ar(chen.linexp(0.0,1.0,minfreq,maxfreq));

    // Chen returns an array of values sot the ugen above is multi channel expanded
    amp * Splay.ar(sig, spread: chen[0]);
}).play
)

// See it on a scope
(
Ndef(\scoped, {
    var x, y, z;
    #x,y,z = Chen.ar(0.000092);

    [x,y,z]
}).scope;
)

(
Ndef(\torn, {|amp=0.5|
    var chenspeedMax = 0.009;
    var chen = Chen.ar(LFCub.kr(LFNoise2.kr(chenspeedMax * 2) * 0.1).range(0.001,chenspeedMax), 0.192, LFCub.kr(0.35).unipolar, 0.22);
    var minfreq = 40.0, maxfreq=500.0;
    var sig = VarSaw.ar(chen.linexp(0.0,1.0,minfreq,maxfreq), width: chen.reverse.lag);
    sig = sig + FreqShift.ar(sig, chen.scramble.lag3 * 1.0) * 0.5;

    // Chen returns an array of values sot the ugen above is multi channel expanded
    amp * Splay.ar(sig, spread: chen.sum / 4.0);
}).play
)


{ LFCub.ar(LFCub.kr(LFCub.kr(0.2,0,8,10),0, 400,800),0,0.4)!2 }.play
{ LFCub.ar(LFCub.kr(0.2, 0, 400,800),0,0.1) }.play
{ LFCub.ar(220 * LFCub.ar(110).range(0, 1) * 4, 0, 0.4)!2 }.play
{ LFCub.ar(XLine.kr(100,8000,30),0,0.1) }.play


(
{
    var t = Impulse.ar(1);
    var t2 = Impulse.ar(2);
    var d = Demand.ar(t, 0, Dseq([1, 2, 4, 2], inf)).lag(0.1);
    var d2 = Demand.ar(t2, 0, Dseq([1, 2, 4, 2], inf)).lag(0.1);
    var dd = (1 + ((t * 100000).lag(1))) * 0.25;
    LFCub.ar(220 * LFCub.ar(110 * d2).range(0, 1) * d, 0, 0.4)!2

}.play
)