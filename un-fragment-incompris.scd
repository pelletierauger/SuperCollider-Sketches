(
play{
    m=Impulse;
    n=8;
    u=Splay.ar({
        |i|i=i+1;
        o=1+ToggleFF.kr(m.kr((i*0.51)/n));
        Ringz.ar(OnePole.ar(m.ar(i/n)),o*777/i,o*4).sin;
}!n).tanh;
    (u+GVerb.ar(0.5*u.mean,11,11,0)).sin
}
)

(
play{
    m = Impulse;
    n = 8;
    u = Splay.ar({
        |i| i = i + 1;
        o = 1 + ToggleFF.kr(m.kr((i * 0.51) / n));
        Ringz.ar(OnePole.ar(m.ar(i / n)),o * 777 / i, o * 4).sin;
    }!n);
    u + GVerb.ar(0.5 * u.mean, 11, 11, 0);
    // (u).sin;
}
)

(
{
	var a;
	a = Line.ar(-pi, pi, 0.01);
    // a.tanh
}.plot;
)

