{Saw.ar(MouseX.kr(100, 1000))}.freqscope
{LFSaw.ar(MouseX.kr(100, 1000))}.freqscope


(
f = {
    ({arg i;
        var j = i * 2 + 1;
        SinOsc.ar(300 * j, 0,  j.reciprocal * 0.5);
    } ! 30).sum // we sum this function 30 times
    !2}; // and we make it a stereo signal
)

f.plot; // let's plot the wave form
f.play; // listen to it
f.freqscope; // view and listen to it


// Square
(
f = {
    ({
    |i|
    var j = i * 2 + 1;
    SinOsc.ar(300 * j, 0, j.reciprocal * 0.5);
}!30).sum!2};
f.plot;
)

// Triangle
(
f = {
    ({
    |i|
    var j = i * 2 + 1;
    SinOsc.ar(300 * j, pi/2, 0.7/j.squared);
}!30).sum!2};
f.plot;
)