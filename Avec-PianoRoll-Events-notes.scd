(
v = Window.new.front;
o = TextField(v, Rect(~pr.sidebarWidth, view.bounds.height, 350, 20));
o.font = Font("Inconsolata", 16);
o.string = "hi there";
// a.action = {arg field; field.value.postln; };
// a.action = {arg field; field.value.compile.value; };
o.action = {
    arg field;
    var f = field.value.compile.value;
    if (f.isKindOf(Array), {
        if (e.size == 2, {
            ~pr.selected.do({|i|i[f[0]] = f[1]});
            ~pr.refresh;
        });
    });
};
)

'velocity'.isKindOf()
~pr.sequence.list.do({|i|i.postln})

~pr.selected.do({|i|i[e[0]] = e[1]});
~pr.selected.do({|i|i.velocity = 127});
~pr.sidebarWidth
e = ['velocity', 60]
e.isKindOf(Array)
e.size
u = ( 'beat': 5, 'midinote': 37, 'sustain': 1, 'velocity': 63 )

u['beat']
u[e[0]]
u['velocity']
Event

5@3