(
s.waitForBoot({

var scale, width, height, n, space, w, cells, cellCreator, clearFunc;

// sound source
SynthDef(\blip, {|freq|
	var rel = TRand.kr(0.05,4,1);
	var s = SinOsc.ar(freq*[0.9,0.99,1,1.01,1.1], mul:[0.05,0.2,1,0.2,0.05]).mean;
	var e = EnvGen.ar(Env.perc(0.005,rel,1.75), 1, doneAction:2) ** 4;
	Out.ar(0, s*e!2);
}).add;

s.sync;

scale = (12*[3,4,5,6] +.x Scale.egyptian.degrees.flatten).midicps;

// GUI
width = 600;
height = width;
n = 13;
space = width/n;

// make a new window
w = Window.new("automata", Rect(100,100,width,height));

// make empty data structure to hold program state
cells = [];

cellCreator = {|row, col, id|
	var x = ();
	x.id = id;
	x.pos = [row, col];
	x.dir = [0,1];

	x.updateCell = {|self|
		// reverse direction if at boundary
		if( self.pos[0]==n && self.dir[0]==1, {
			self.dir[0] = -1;
			Synth(\blip, [\freq, scale.wrapAt(self.pos[1]-1)]);
		});
		if( self.pos[1]==n && self.dir[1]==1, {
			self.dir[1] = -1;
			Synth(\blip, [\freq, scale.wrapAt(12*self.pos[0]-1)]);
		});
		if( self.pos[0]==1 && self.dir[0] == -1, {
			self.dir[0] = 1;
			Synth(\blip, [\freq, scale.wrapAt(24*self.pos[1]-1)]);
		});
		if( self.pos[1]==1 && self.dir[1] == -1, {
			self.dir[1] = 1;
			Synth(\blip, [\freq, scale.wrapAt(36*self.pos[0]-1)]);
		});

		// advance position
		self.pos = self.pos + self.dir;
	};

	x.changeDir = {|self|
		switch(self.dir,
			[1,0], {self.dir = [0,-1]},
			[-1,0], {self.dir = [0,1]},
			[0,1], {self.dir = [-1,0]},
			[0,-1], {self.dir = [1,0]}
		);
	};

	x;
};

clearFunc = {
	n.do{|i|
		n.do{|j|
			b[i][j].value=0;
		};
	};
};


// fill window with buttons
b =
n.collect{|i|
	n.collect{|j|
		Button(w, Rect(space*i, space*j, space, space))
		.states_([["", Color.black, Color.gray], ["", Color.black, Color.red]])
		.action_({|x|
			if(x.value == 1, {
				cells = cells ++ [cellCreator.value(i+1, j+1, cells.size)];
			})
		});
	}
};

w.drawFunc = Routine{
	loop{
		var ncells = cells.size;

		clearFunc.();

		// update cells
		cells.do{ |x|
			x.updateCell;
			b[x.pos[0]-1][x.pos[1]-1].value = 1;
		};

		// check for collision paths
		(ncells-1).do{|i|
			(ncells-i-1).do{|j|
				var k = j+i+1;
				if( (cells[i].pos == cells[k].pos) && (cells[i].dir == (-1*cells[k].dir)),
					{
						cells[i].changeDir;
						cells[k].changeDir;
					}
				)
			}
		};
		//"------------------".postln;
		0.yield;
	}
};

{ while { w.isClosed.not } { w.refresh; 0.125.wait; } }.fork(AppClock);

w.front;

}.fork(AppClock);
);

)