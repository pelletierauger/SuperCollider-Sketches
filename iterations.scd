(
[12, 14, 16, 18].do{
	arg item, count;
	[count, item.squared].postln;
}
)

x = Array.newClear(5);
x;

(
[0, 1, 2, 3, 4].do{
	arg count;
	x[count] = count + 10;
}
)

x;