(
var win, pr;
win = Window("Seq");
pr = PianoRoll(win, win.view.bounds).resize_(5);
~pr = pr;
win.front;
)

~pr.zoomIn
~pr.zoomOut
~pr.halveQuant
~pr.doubleQuant
~pr.play
~pr.playPause(nil, nil, true)
~pr.playPause;

~pr.sequence.list[0]
~pr.sequence.asPattern


~pr.sequence.list.do({|i|i.postln})
~pr.selected


s.record;
~pr.playPause(nil, nil, true);
~pr.playPause;
(
{{~pr.sequence.list.do({|i|
    {
        var note = i.midinote;
        var dyn = 0;
        (i.beat*0.75).wait;
        if (note < 52, {note = note - 12});
        if (note > 65, {dyn = 1});
        // if (note < 52, {dyn = 1});
        (type: \pianoEvent, num: note+24, dyn:dyn).play;
        // ~toNote.(note+24).postln;
    }.fork;
});
(6*0.75).wait;}.loop;
}.fork;
)

(
{{~pr.sequence.list.do({|i|
    {
        var note = i.midinote;
        var dyn = 0;
        (i.beat*0.75).wait;
        if (note < 52, {note = note - 12});
        if (note > 65, {dyn = 1;note = note - 24;});
        // if (note < 52, {dyn = 1});
        (type: \pianoEvent, num: note+24 * -1 + 150, dyn:dyn).play;
        /*    {
        0.5.wait;
        (type: \pianoEvent, num: note+24, dyn:dyn).play;

        }.fork;*/
        // ~toNote.(note+24).postln;
    }.fork;
});
(6*0.75).wait;}.loop;
}.fork;
)

~pr.sequence.list = ~seq;
~pr.sequence;
~pr.refresh;
(
~seq = [
    ( 'beat': 0, 'midinote': 58, 'sustain': 1 ),
    ( 'beat': 0.75, 'midinote': 61, 'sustain': 1 ),
    ( 'beat': 1, 'midinote': 58, 'sustain': 1 ),
    ( 'beat': 1.5, 'midinote': 65, 'sustain': 1 ),
    ( 'beat': 1.75, 'midinote': 61, 'sustain': 1 ),
    ( 'beat': 0.5, 'midinote': 65, 'sustain': 1 ),
    ( 'beat': 2, 'midinote': 54, 'sustain': 1 ),
    ( 'beat': 2.5, 'midinote': 56, 'sustain': 0.5 ),
    ( 'beat': 0.75, 'midinote': 70, 'sustain': 0.5 ),
    ( 'beat': 1.75, 'midinote': 68, 'sustain': 0.5 ),
    ( 'beat': 3, 'midinote': 58, 'sustain': 1 ),
    ( 'beat': 3.75, 'midinote': 61, 'sustain': 1 ),
    ( 'beat': 4, 'midinote': 58, 'sustain': 1 ),
    ( 'beat': 4.5, 'midinote': 65, 'sustain': 1 ),
    ( 'beat': 4.75, 'midinote': 61, 'sustain': 1 ),
    ( 'beat': 3.5, 'midinote': 65, 'sustain': 1 ),
    ( 'beat': 5, 'midinote': 54, 'sustain': 1 ),
    ( 'beat': 5.5, 'midinote': 56, 'sustain': 0.5 ),
    ( 'beat': 3.75, 'midinote': 73, 'sustain': 0.5 ),
    ( 'beat': 4.75, 'midinote': 72, 'sustain': 0.5 ),
    ( 'beat': 0, 'midinote': 46, 'sustain': 1 ),
    ( 'beat': 1, 'midinote': 49, 'sustain': 1 ),
    ( 'beat': 2, 'midinote': 51, 'sustain': 1 ),
    ( 'beat': 3, 'midinote': 42, 'sustain': 1 ),
    ( 'beat': 4, 'midinote': 39, 'sustain': 1 ),
    ( 'beat': 5, 'midinote': 37, 'sustain': 1 )
];
)

(
var win, pr;
win = Window("Seq", Rect(0,700-10, 400, 400), border: true);
pr = PianoRoll(win, win.view.bounds).resize_(5);
~pr = pr;
win.front;
~seq = [
    ( 'beat': 0, 'midinote': 58, 'sustain': 1, 'velocity': 127, 'color': Color.red ),
    ( 'beat': 0.75, 'midinote': 61, 'sustain': 1, 'velocity': 63, 'color': Color.red ),
    ( 'beat': 1, 'midinote': 58, 'sustain': 1, 'velocity': 63, 'color': Color.red ),
    ( 'beat': 1.5, 'midinote': 65, 'sustain': 1, 'velocity': 63, 'color': Color.red ),
    ( 'beat': 1.75, 'midinote': 61, 'sustain': 1, 'velocity': 63, 'color': Color.red ),
    ( 'beat': 0.5, 'midinote': 65, 'sustain': 1, 'velocity': 63, 'color': Color.red ),
    ( 'beat': 2, 'midinote': 54, 'sustain': 1, 'velocity': 63, 'color': Color.red ),
    ( 'beat': 2.5, 'midinote': 56, 'sustain': 0.5, 'velocity': 63, 'color': Color.red ),
    ( 'beat': 0.75, 'midinote': 70, 'sustain': 0.5, 'velocity': 63, 'color': Color.red ),
    ( 'beat': 1.75, 'midinote': 68, 'sustain': 0.5, 'velocity': 63, 'color': Color.red ),
    ( 'beat': 3, 'midinote': 58, 'sustain': 1, 'velocity': 63, 'color': Color.red ),
    ( 'beat': 3.75, 'midinote': 61, 'sustain': 1, 'velocity': 63, 'color': Color.red ),
    ( 'beat': 4, 'midinote': 58, 'sustain': 1, 'velocity': 63, 'color': Color.red ),
    ( 'beat': 4.5, 'midinote': 65, 'sustain': 1, 'velocity': 63, 'color': Color.red ),
    ( 'beat': 4.75, 'midinote': 61, 'sustain': 1, 'velocity': 63, 'color': Color.red ),
    ( 'beat': 3.5, 'midinote': 65, 'sustain': 1, 'velocity': 63, 'color': Color.red ),
    ( 'beat': 5, 'midinote': 54, 'sustain': 1, 'velocity': 63, 'color': Color.red ),
    ( 'beat': 5.5, 'midinote': 56, 'sustain': 0.5, 'velocity': 63, 'color': Color.red ),
    ( 'beat': 3.75, 'midinote': 73, 'sustain': 0.5, 'velocity': 63, 'color': Color.red ),
    ( 'beat': 4.75, 'midinote': 72, 'sustain': 0.5, 'velocity': 63, 'color': Color.red ),
    ( 'beat': 0, 'midinote': 46, 'sustain': 1, 'velocity': 63, 'color': Color.red ),
    ( 'beat': 1, 'midinote': 49, 'sustain': 1, 'velocity': 63, 'color': Color.red ),
    ( 'beat': 2, 'midinote': 51, 'sustain': 1, 'velocity': 63, 'color': Color.red ),
    ( 'beat': 3, 'midinote': 42, 'sustain': 1, 'velocity': 63, 'color': Color.red ),
    ( 'beat': 4, 'midinote': 39, 'sustain': 1, 'velocity': 63, 'color': Color.red ),
    ( 'beat': 5, 'midinote': 37, 'sustain': 1, 'velocity': 63, 'color': Color.red )
];
~pr.sequence.list = ~seq; ~pr.refresh;
~prt = TextField(win, Rect(~pr.sidebarWidth, 5, 750, 30));
~prt.font = Font("Inconsolata", 16);
~prt.background = Color.gray(0.5, 0);
~prt.stringColor = Color.white;
~prt.focusColor = Color.gray(0,0);
// o.border = Color.gray(0,0);
~prt.string = "'velocity', 127";
// a.action = {arg field; field.value.postln; };
// a.action = {arg field; field.value.compile.value; };
~prt.action = {
    arg field;
    var f = ("[" ++ field.value ++ "]").compile.value;
    if (f.isKindOf(Array), {
        if (f.size % 2 == 0, {
            (f.size/2).do({
               |j|
                ~pr.selected.do({|i|i[f[j*2]] = f[j*2+1]});
            });
            ~pr.refresh;
        });
    });
    f.postln;
};
b = Button(win, Rect(5, 5, 50, 30))
        .states_([
            ["Note", Color.white, Color.gray(0.5)],
            ["Vel", Color.white, Color.gray(0.5)]
        ])
        .action_({ arg butt;
    if (butt.value == 0,{~pr.propDisplay = 'midinote'});
    if (butt.value == 1,{~pr.propDisplay = 'velocity'});
    ~pr.refresh;
});
b.font = Font("Inconsolata", 16);
b.backgroundColor = Color.gray(0.5, 1);
b.focusColor = Color(0,0,0,1);
b.canFocus = false;
)
~pr.view.bounds.height
o.border
k = Color.red.blend(Color.black, 0.5)
k = Color(1.0)
k.green
k.green
o.doAction
o.borderColor
o.canFocus
o.focusColor = Color.gray(0,0)
o
= Color.gray(0,0)
(
~seq2 = [];
~seq.do({
    |i|
    var note = i.midinote;
    if (note < 52, {note = note - 12});
    ~seq2 = ~seq2.add(('beat': i.beat, 'midinote': note, 'sustain': i.sustain));
});
)

(
~seq2 = [];
~seq.do({
    |i|
    var note = i.midinote;
        if (note < 52, {note = note - 12});
        if (note > 65, {note = note - 24;});
    note = note+24 * -1 + 150;
    ~seq2 = ~seq2.add(('beat': i.beat, 'midinote': note, 'sustain': i.sustain));
});
)
~seq2
~pr.sequence.list = ~seq2; ~pr.refresh;
~pr.sequence.list = ~seq; ~pr.refresh;
~seq2[0].midinote
(
{{~seq.do({|i|
    {
        var note = i.midinote;
        var dyn = 0;
        (i.beat*0.75).wait;
        if (note < 52, {note = note - 12});
        if (note > 65, {dyn = 1});
        // if (note < 52, {dyn = 1});
        (type: \pianoEvent, num: note+24, dyn:dyn).play;
        // ~toNote.(note+24).postln;
    }.fork;
});
(6*0.75).wait;}.loop;
}.fork;
)
(
{{~seq.do({|i|
    {
        var note = i.midinote;
        var dyn = 0;
        (i.beat*0.75).wait;
        if (note < 52, {note = note - 12});
        if (note > 65, {dyn = 1; note = note - 24;});
        // if (note < 52, {dyn = 1}).;
        (type: \pianoEvent, num: note+24 * -1 + 150, dyn:dyn).play;
    }.fork;
});
(6*0.75).wait;}.loop;
}.fork;
)

(
~seq = [
    ( 'beat': 0, 'midinote': 53, 'sustain': 1 ),
    ( 'beat': 1, 'midinote': 56, 'sustain': 1 ),
    ( 'beat': 1.75, 'midinote': 58, 'sustain': 1 ),
    ( 'beat': 0, 'midinote': 46, 'sustain': 1 ),
    ( 'beat': 1.5, 'midinote': 48, 'sustain': 1 ),
    ( 'beat': 2.5, 'midinote': 49, 'sustain': 0.5 ),
    ( 'beat': 2, 'midinote': 55, 'sustain': 1 )
];
)


~pr.propDisplay == 'velocity'
~pr.propDisplay = 'midinote';
~pr.refresh;
~pr.propDisplay
'velocity'.isKindOf(Symbol)

~pr.selected[0].prop.isKindOf(Symbol)
~toNote.(note[this.propDisplay])[0];

(
var str = ~pr.selected[0].asString;
if (~pr.selected[0].isKindOf(Event), {
    var st = str.replace("( ", "");
    st = st.replace(" )", "");
    o.string = st;
});
)
~pr.selected[0].prop = 'velocity'
~pr.selected[0][~pr.selected[0].prop]
~pr.selected[0]['velocity']