proc reDraw (a : array 1 .. * of ^Column, b : array 1 .. * of ^Foundation, c : ^Foundation, d : ^Card)
    for i : 1 .. 7
	for j : 1 .. i
	    ^ (a (i)).setCentre (60 + (i - 1) * 145, 600)
	end for
	^ (a (i)).ksetFlipped
	^ (a (i)).draw
    end for

    if lastCard = false then
	^d.setCentre (60, 735)
	^d.draw
    end if

    for i : 1 .. 4
	^ (b (i)).setCentre (530 + i * 100, 735)
	^ (b (i)).draw
    end for
    ^c.setCentre (160, 735)
    ^c.draw
end reDraw
