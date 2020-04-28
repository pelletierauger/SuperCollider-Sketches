OSWrap4è



{ Clipper4.ar(SinOsc.ar(MouseX.kr(200, 5000), 0, 2), -0.2, 0.2) }.play
{ Clipper8.ar(SinOsc.ar(MouseX.kr(200, 5000), 0, 2), -0.2, 0.2) }.play
{ SinOsc.ar(MouseX.kr(200, 5000), 0, 2).clip2(0.2) }.play

{ OSWrap4.ar(SinOsc.ar(MouseX.kr(200, 5000), 0, 2), -0.2, 0.2) }.play
{ OSWrap8.ar(SinOsc.ar(220 * 1!2, 0, 2), -0.2, 0.2) }.play
{ SinOsc.ar(MouseX.kr(200, 5000), 0, 2).wrap2(0.2) }.play

{ OSFold4.ar(SinOsc.ar(MouseX.kr(200, 5000), 0, 2), -0.2, 0.2) }.play
{ OSFold8.ar(SinOsc.ar(220 * 1!2, 0, 2), -0.2, 0.2) }.play
{ SinOsc.ar(MouseX.kr(200, 5000), 0, 2).fold2(0.2) }.play

{ OSTrunc4.ar(SinOsc.ar(MouseX.kr(200, 5000), 0, 2), 0.2) }.play
{ OSTrunc8.ar(SinOsc.ar(55 * 1!2, 0, 2), 0.2) }.play
{ SinOsc.ar(MouseX.kr(200, 5000) * 1!2).trunc(0.2) }.play