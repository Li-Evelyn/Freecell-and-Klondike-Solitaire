%move the stacks
%only gets executed if storeMove returned true (i.e. a valid move was made)
proc moveStack (a : array 1 .. * of ^Column, b : array 1 .. * of ^Column, c : array 1 .. * of ^Foundation)
    var col : ^Column
    new col
    %get information from the stored move
    var s : string := moves (upper (moves))
    var m : int := strint (s (2))
    var n : int := strint (s (4))
    var o : int := strint (s (5 .. *))
    var bool : boolean := false
    %gets the selected stack
    if s (1) = "C" then
	for i : ^ (a (m)).getupper - o + 1 .. ^ (a (m)).getupper
	    ^col.addCard ( ^ (a (m)).getCard (i))
	end for
    elsif s(1) = "F" then
	^col.addCard ( ^ (c (m)).lastCard)
    else
	^col.addCard(^(b(m)).lastCard)
    end if
    %cases: if undo = true, the valid move function does not need to be called
    if undo = true then
	case (s (3)) of
	    label "C" :
		for i : 1 .. o
		    ^ (a (n)).addCard ( ^col.getCard (i))
		end for
	    label "c" :
		^ (b (n)).addCard ( ^col.getCard (1))
	    label "F" :
		^ (c (n)).addCard ( ^col.getCard (1))
	end case
	%remove the undone move from the array
	new moves, upper (moves) - 1
	%remove the cards from the original array
	case (s (1)) of
	    label "C" :
		for i : 1 .. o
		    ^ (a (m)).removeCard
		end for
	    label "F" :
		^ (c (m)).removeCard
	    label "c" :
		^ (b (m)).removeCard
	end case
    else
	case (s (3)) of
	    label "C" :
		if ^(a(n)).isEmpty = true and ^col.getupper <= countFreeCells(a, b) then
		    for i : 1 .. o
			^(a(n)).addCard(^col.getCard(i))
		    end for
		    bool := true
		elsif ^ (a (n)).validMove ( ^col.getCard (1)) = true then
		    for i : 1 .. o
			^ (a (n)).addCard ( ^col.getCard (i))
		    end for
		    bool := true
		else
		    %remove the invalid move from the array
		    new moves, upper (moves) - 1
		end if
	    label "c" :
		if ^ (b (n)).validMove ( ^col.getCard (1)) = true then
		    ^ (b (n)).addCard ( ^col.getCard (1))
		    bool := true
		else
		    new moves, upper (moves) - 1
		end if
	    label "F" :
		if ^ (c (n)).validMove ( ^col.getCard (1)) = true then
		    ^ (c (n)).addCard ( ^col.getCard (1))
		    bool := true
		else
		    new moves, upper (moves) - 1
		end if
	end case
	if bool = true then
	    case (s (1)) of
		label "C" :
		    for i : 1 .. o
			^ (a (m)).removeCard
		    end for
		label "F" :
		    ^ (c (m)).removeCard
		label "c" :
		    ^ (b (m)).removeCard
	    end case
	end if
    end if
end moveStack
