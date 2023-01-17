(
~tks = {
    |i = 0, gate = 1|
    // tr reads control rate impulse from ~cb.
    var tr = In.kr(~cb, 2) * gate;
    // d goes from 0 to 1 once the first downbeat plays.
    var d = Demand.kr(tr[0], 0, Dseq([1]));
    // t starts to send triggers once d is 1.
    var t = tr[i] * d;
    [t, d];
};
)


