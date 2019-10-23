%counts the number of empty cells = freecells

fcn countFreeCells (a : array 1 .. * of ^Column, b : array 1 .. * of ^Column) : int
    var counter := 0 %counter variable
    for i : 1 .. upper(a) %loop through all of the columns (8 stacks)
	if ^(a(i)).isEmpty = true then %if the cell is free then
	    counter += 1
	end if
    end for
    for i : 1 .. upper(b) %loop through all of the cells
	if ^(b(i)).isEmpty = true then %if the cell is free then
	    counter +=1
	end if
    end for
    result counter %return whatever the counter was
end countFreeCells
