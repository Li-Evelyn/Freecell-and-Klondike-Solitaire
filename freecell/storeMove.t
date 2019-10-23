%so instead of using an entirely new class to do this, we're storing each move (instead of state)
%this'll make sense if you think about it
%objectives were to get the undo working and optimize the program
%so this gets read by a universal readstack procedure so it's all good (hopefully)  
%this stores strings instead of arrays of arrays so it's much faster to load
fcn storeMove (pcolumn, pcell, pcolumn1, pfoundation1, pcell1, stackLength : int) : boolean
    if pcolumn1 = 0 and pfoundation1 = 0 and pcell1 = 0 then
	if undo = true and upper (moves) > 0 then
	    moves (upper (moves)) := moves (upper (moves)) (3 .. 4) + moves (upper (moves)) (1 .. 2) + moves (upper (moves)) (5 .. *)
	    result true
	end if
    else
	new moves, upper (moves) + 1
	if pcolumn1 > 0 then
	    if pcolumn > 0 then
		moves (upper (moves)) := "C" + intstr (pcolumn)
	    else
		moves (upper (moves)) := "c" + intstr (pcell)
	    end if
	    moves (upper (moves)) += "C" + intstr (pcolumn1)
	elsif pfoundation1 > 0 then
	    if pcolumn > 0 then
		moves (upper (moves)) := "C" + intstr (pcolumn)
	    else
		moves (upper (moves)) := "c" + intstr (pcell)
	    end if
	    moves (upper (moves)) += "F" + intstr (pfoundation1)
	else
	    if pcolumn > 0 then
		moves (upper (moves)) := "C" + intstr (pcolumn)
	    else
		moves (upper (moves)) := "c" + intstr (pcell)
	    end if
	    moves (upper (moves)) += "c" + intstr (pcell1)
	end if
	moves (upper (moves)) += intstr (stackLength)
	result true
    end if
    result false
end storeMove
