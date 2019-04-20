(
~sigStack = {
    var h = 8;
    var stack = {|i| SinOsc.ar(55 * (1 + i)) * i.linlin(0, h - 1, 1, 0.5) * SinOsc.kr(rrand(0.1, 1.0));}!h;
    var stack2 = {|i| LFTri.ar(110 * 7.midiratio * (1 + i)) * i.linlin(0, h - 1, 1, 0.1) * SinOsc.kr(rrand(0.1, 1.0) * 0.1);}!h;
    var stack3 = {|i| LFTri.ar(110 * 16.midiratio * (1 + i)) * i.linlin(0, h - 1, 1, 0.5) * SinOsc.kr(rrand(0.1, 1.0) * 0.1);}!h;
    var bundle = Splay.ar(stack) + (Splay.ar(stack2) + (Splay.ar(stack3) * SinOsc.ar([110, 110.1] * 1.01)));
    LPF.ar(bundle * 0.4, 300 + (SinOsc.kr(0.125, 0.5, 0.5) * 400));
};
)

~sigStack.play;
~sigStack.free(10);