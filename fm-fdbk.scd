~sine = {SinOsc.ar(220)};

(
{
    SinOsc.ar(440, ~sine * 16);
}.play;
)





(
{
    var in = LocalIn.ar(2);
    var lfo = SinOsc.ar(0.1).range(0.1, 1);
    var sig = SinOsc.ar(220 * 1!2, in * lfo * 8);
    var deltimes = 0.01;
    var delSig = DelayC.ar(sig.lag(0.01), deltimes, deltimes);
    LocalOut.ar(delSig);
    // (sig[0] - sig[1]);
    sig;
}.play;
)

(
{
    var in = LocalIn.ar(4);
    var lfo = SinOsc.ar(0.1).range(0.1, 1);
    var lfo2 = SinOsc.ar(6).range(0.1, 1);
    var sig = SinOsc.ar(220 * 1!2, [in[0], in[1]] * lfo * 4 + ([in[2], in[3]] * lfo2));
    var sig2 = SinOsc.ar((880 * 0.125)!2);
    var deltimes = 0.01;
    var delSig = DelayC.ar([sig[0].lag(0.01), sig[1].lag(0.01), sig2[0], sig2[1]], deltimes, deltimes);
    LocalOut.ar(delSig);
    // (sig[0] - sig[1]);
    sig;
}.play;
)



// Grillons
(
x.free;
x = {
    var in = LocalIn.ar(2);
    var lfo = SinOsc.ar(0.1).range(0.8, 1.05);
    var sig = SinOsc.ar((880 * 2)!2, in * lfo * 25 * 2);
    LocalOut.ar(sig.lag(0.05));
    sig * 0.2;
}.play;
)

(
x.free;
x = {
    var in = LocalIn.ar(2);
    var lfo = SinOsc.ar(0.1).range(0.95, 1.05);
    var sig = SinOsc.ar((440 * 2)!2, in * lfo * 25 * 1);
    LocalOut.ar(sig.lag(0.05));
    sig;
}.play;
)


(
x.free;
x = {
    var in = LocalIn.ar(2);
    var lfo = SinOsc.ar(1).range(0.95, 1.05);
    var sig = SinOsc.ar((220 * 2)!2, in * lfo * 25 * 16);
    LocalOut.ar(sig.lag(0.1));
    sig;
}.play;
)

// Insectes
(
y.free;
y = {
    var in = LocalIn.ar(2);
    var lfo = SinOsc.ar(0.1).range(0.8, 1.05) * 650;
    var sig = SinOsc.ar((220 * 0.0625 * 0.75)!2, in * lfo);
    LocalOut.ar(sig);
    sig;
}.play;
)

(
z.free;
z = {
    var in = LocalIn.ar(2);
    var lfo = SinOsc.ar(0.1).range(0.8, 1.05) * 1650 * 16;
    var sig = SinOsc.ar((220 * 0.0625 * 0.75 * 0.5)!2, in * lfo);
    LocalOut.ar(sig.lag(0.2));
    sig * 8;
}.play;
)


(
y.free;
y = {
    var in = LocalIn.ar(2);
    var lfo = SinOsc.ar(0.1).range(0.8, 1.05) * 650;
    var sig = SinOsc.ar((220 * 0.0625 * 0.75)!2, in * lfo);
    LocalOut.ar(sig);
    sig;
}.play;
)

(
z.free;
z = {
    var in = LocalIn.ar(2);
    var lfo = SinOsc.ar(0.1).range(0.8, 1.05) * 150;
    var sig = SinOsc.ar((220 * 0.0625 * 0.5 * 0.5)!2, in.pow(0.25) * lfo);
    LocalOut.ar(sig);
    sig * 4;
}.play;
)


(
z.free;
z = {
    var in = LocalIn.ar(2);
    var lfo = SinOsc.ar(0.1).range(0.8, 1.05) * 150;
    var sig = SinOsc.ar((220 * 0.5)!2, in.pow(0.25) * lfo);
    LocalOut.ar(sig);
    sig * 4;
}.play;
)


// Animal plaintif
(
z.free;
z = {
    var in = LocalIn.ar(2);
    var lfo = SinOsc.ar(0.1).range(0.9, 1) * 150;
    var sig = SinOsc.ar((220 * 0.0625 * 0.0625 * 0.1)!2, in.pow(2) * lfo);
    LocalOut.ar(sig.lag(0.05));
    sig * 4;
}.play;
)


(
z.free;
z = {
    var in = LocalIn.ar(2);
    var lfo = SinOsc.ar(20).range(0.9, 1) * 15;
    var sig = SinOsc.ar((220 * 0.0625 * 0.0625 * 0.0625)!2, in.pow(4) * lfo);
    LocalOut.ar(LPF.ar(sig, 110));
    // sig * 4;
    SinOsc.ar(220, sig * 2) * 16;
}.play;
)

// Grillons
(
x.free;
x = {
    var in = LocalIn.ar(2);
    var lfo = SinOsc.ar(0.1).range(0.8, 1.05);
    var sig = SinOsc.ar((880 * 2)!2, in * lfo * 25 * 2);
    var lfo2 = SinOsc.ar(0.5).range(0.045, 0.05);
    LocalOut.ar(sig.lag(lfo2));
    sig * 0.2;
}.play;
)


(
x.free;
x = {
    var in = LocalIn.ar(2);
    var lfo = SinOsc.ar(0.1).range(0.8, 1.05) * 600;
    var sig = SinOsc.ar((440 * 5.midiratio)!2 + (in * lfo));
    LocalOut.ar(sig);
    sig * 0.5;
}.play;
)

(
x.free;
x = {
    var in = LocalIn.ar(2);
    var imp = Impulse.ar(1);
    var dem = Demand.ar(imp, 0, Dseq([0, 7, 12, 19, 24].midiratio, inf));
    var lfo = SinOsc.ar(4).range(0.8, 1.05) * 600 * dem;
    var sig = SinOsc.ar((440 * 5.midiratio)!2 + (in * lfo));
    LocalOut.ar(sig.lag(0.01));
    Out.ar(~reverbBus, sig * 0.5);
}.play;
)


(
x.free;
x = {
    var in = LocalIn.ar(2);
    var imp = Impulse.ar(1);
    var dem = Demand.ar(imp, 0, Dseq([0, 7, 12, 19].midiratio, inf));
    var lfo = SinOsc.ar(2).range(0.8, 1.05) * 600 * dem;
    var sig = SinOsc.ar((220 * 5.midiratio)!2 + (in * lfo));
    LocalOut.ar(sig.lag(0.01));
    sig * 0.5;
}.play;
)