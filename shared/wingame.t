%win condition

fcn wingame (a : array 1 .. * of ^Foundation) : boolean
    for i : 1 .. upper(a)
	if ^(a(i)).getupper < 13 then
	    result false
	end if
    end for
    result true
end wingame
