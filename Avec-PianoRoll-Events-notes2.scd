~g = ( 'beat': 0, 'midinote': 58, 'sustain': 1, 'velocity': 127 )

~h = ( 'beat': 0, 'midinote': 58, 'sustain': 1, 'velocity': 127 )
a.isKindOf(Event)
~g.isKindOf(Event)
~h.isKindOf(Event)

~g = (beat: 0, midinote: 58, sustain: 1, velocity: 127 )
~g.type

a = (x: 6, y: 7, play: { (~x * ~y).postln });
a.play; // returns 6 * 7
~p = (type: \pianoEvent, num: 60, dyn: 1);
~p.play;
~q = ~p.contentsCopy
~q
~p.num = 45
~p
~p.type
(
~g = (
    'beat': 0,
    'midinote': 58,
    'sustain': 1,
    'velocity': 127,
    play: {(~velocity*1e3).postln},
    color: Color(0.5, 0.3, 0.2)
);
)
~pr.translate.x
~g.play
~g.color.blue