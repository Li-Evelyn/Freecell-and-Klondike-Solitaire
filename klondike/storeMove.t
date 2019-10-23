%stores moves
fcn kstoreMove (pc, pf, pd, pcard, pc1, pf1, stackLength : int, flipped : boolean, deck : ^Deck) : boolean
    if pc1 = 0 and pf1 = 0 then
	if undo = true and upper (moves) > 0 then
	    moves (upper (moves)) := moves (upper (moves)) (3 .. 4) + moves (upper (moves)) (1 .. 2) + moves (upper (moves)) (5 .. *)
	    result true
	elsif pd > 0 then
	    new moves, upper (moves) + 1
	    if ^deck.getDeckSize > 1 then
		moves (upper (moves)) := "D0c001f"
	    else
		moves (upper (moves)) := "D0c000f"
	    end if
	    result true
	end if
    else
	new moves, upper (moves) + 1
	if pc1 > 0 then
	    if pc > 0 then
		moves (upper (moves)) := "C" + intstr (pc)
	    elsif pf > 0 then
		moves (upper (moves)) := "F" + intstr (pf)
	    elsif pd > 0 then
		moves (upper (moves)) := "D0"
	    else
		moves (upper (moves)) := "c0"
	    end if
	    moves (upper (moves)) += "C" + intstr (pc1)
	else
	    if pc > 0 then
		moves (upper (moves)) := "C" + intstr (pc)
	    elsif pf > 0 then
		moves (upper (moves)) := "F" + intstr (pf)
	    elsif pd > 0 then
		moves (upper (moves)) := "D0"
	    else
		moves (upper (moves)) := "c0"
	    end if
	    moves (upper (moves)) += "F" + intstr (pf1)
	end if
	if stackLength < 10 then
	    moves (upper (moves)) += "0" + intstr (stackLength)
	else
	    moves (upper (moves)) += intstr (stackLength)
	end if
	if flipped = true then
	    moves (upper (moves)) += "t"
	else
	    moves (upper (moves)) += "f"
	end if
	result true
    end if
    result false
end kstoreMove
