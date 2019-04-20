play{m=Impulse;n=8;u=Splay.ar({|i|i=i+1;o=1+ToggleFF.kr(m.kr((i*0.51)/n));Ringz.ar(OnePole.ar(m.ar(i/n)),o*777/i,o*4).sin;}!n).tanh;(u+GVerb.ar(0.5*u.mean,11,11,0)).sin}


(
play {
    m=Impulse;
    n=8;
    u=Splay.ar({|i|
        i=i+1;
        o=1+ToggleFF.kr(m.kr((i*0.51)/n));
        Ringz.ar(OnePole.ar(m.ar(i/n)),o*777/i,o*4).sin;
    }!n).tanh;
    (u+GVerb.ar(0.5*u.mean,11,11,0)).sin;
}
)

play{n=rrand(5,8);o={|i|(SinOsc.ar(34*((n-i)**2.2))*Decay2.ar(Impulse.ar(9/(i+1)),1e-4,0.1)*(i+1)).sin}!n;x=Convolution.ar(PinkNoise.ar(1!n),o*0.5,128)*SinOsc.kr(1/15,1.5pi).range(0.2,1);Limiter.ar(HPF.ar(Splay.ar((x+o).tanh),30)).sanitize}

(
play {
    n=rrand(5,8);
    o={|i|(SinOsc.ar(34*((n-i)**2.2))*Decay2.ar(Impulse.ar(9/(i+1)),1e-4,0.1)*(i+1)).sin}!n;
    x=Convolution.ar(PinkNoise.ar(1!n),o*0.5,128)*SinOsc.kr(1/15,1.5pi).range(0.2,1);
    Limiter.ar(HPF.ar(Splay.ar((x+o).tanh),30)).sanitize;
}
)