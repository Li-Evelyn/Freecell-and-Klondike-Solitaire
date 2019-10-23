%the procedure to move the stack
%a = array of the columns, b = array of the foundations
proc kselectStacks (a : array 1 .. * of ^Column, b : array 1 .. * of ^Foundation, cb : ^Card, deck : ^Deck, pile : ^Foundation)
    var x, y, bn, bud : int %some button variables
    var pc, pf, pd, pcard : int := 0 %placeholder for the first selection
    var pc1, pf1 : int := 0 %placeholder for the second selection
    var stackLength : int
    stackLength := kselect1(a, b, cb, deck, pile, pc, pf, pd, pcard)
    Mouse.ButtonWait("up", x, y, bn, bud)
    if undo = false and pd = 0 then
	kselect2 (a, b, pc1, pf1)
    end if
    if back = false then
	if kstoreMove(pc, pf, pd, pcard, pc1, pf1, stackLength, flipped, deck) = true then
	    kmoveStack(a, b, deck, pile)
	end if
    end if
end kselectStacks
