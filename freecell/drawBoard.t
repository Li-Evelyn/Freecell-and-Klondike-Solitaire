proc drawBoard (a : array 1 .. 8 of ^Column, b : array 1 .. 4 of ^Foundation, c : array 1 .. 4 of ^Column)
    for i : 1 .. 8
	^ (a (i)).setCentre (maxx div 9 * i, maxy * 2 div 3)     %set the center of the top card of each column using this nifty formula
	^ (a (i)).draw     %draw the columns
    end for
    for i : 1 .. 4     %there are four columns and foundations, so this is convenient
	^ (b (i)).setCentre (maxx + 30 - maxx div 9 * i, maxy * 6 div 7)     %set the center of each foundation using this similarly nifty formula
	^ (c (i)).setCentre (maxx div 9 * i - 30, maxy * 6 div 7)     %i'll stop tooting my own horn now
	^ (b (i)).draw     %draw the foundations
	^ (c (i)).draw
    end for
end drawBoard
