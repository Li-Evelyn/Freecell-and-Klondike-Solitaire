%freecell
%selects a stack and records the initial position plus the length of the stack (exact stack length is not necessary)
%takes a = column array, b = free cell array, and two variables.
fcn select1 (a : array 1 .. * of ^Column, b : array 1 .. * of ^Column, var pcolumn, pcell : int) : int
    var x, y, bn, bud : int %button variables
    var bool : boolean := false %checks if a stack has been selected
    var stacklength : int
    var c : ^Column := nil %column storage
    var ca : ^Card := nil %card storage (for saving space)
    new c
    new ca
    loop
	exit when bool = true
	Mouse.ButtonWait ("down", x, y, bn, bud) %wait until the mouse button is down.
	exit when back = true or GUI.ProcessEvent
	for i : 1 .. upper (a) %loop through the stack (read: through each column individually)
	    if ^ (a (i)).getupper > 0 then %if the column isn't empty, since you can't get something from nothing
		for j : 1 .. ^ (a (i)).getupper %loop through that column
		    ca := ^ (a (i)).getCard (j) %ca stores the particular card being checked - this is just to save, eyes, brain power, and parentheses
		    if ^ca.inTopOfCard (x, y) = true then
			^c.emptyPile
			for k : j .. ^ (a (i)).getupper %adds the new one
			    ^c.addCard ( ^ (a (i)).getCard (k))
			end for
			if ^c.isValidStack = true and ^c.getupper - 1 <= countFreeCells (a, b) then %if the mouse is in the top of the card (25 pixels) and it's a valid stack
			    bool := true %valid stack has been selected
			    ^c.setCentre ( ^ ( ^ (a (i)).getCard (j)).getcx, ^ ( ^ (a (i)).getCard (j)).getcy) %for drawselected
			    stacklength := ^c.getupper
			    pcolumn := i %stores the column that was modified
			    exit %no need to loop anymore
			end if
		    end if
		end for
		if bool = false and ^ ( ^ (a (i)).lastCard).inCard (x, y) = true then %if the mouse wasn't in the top 25 pixels of a card but still in the last card, then...
		    bool := true %valid "stack"
		    ^c.emptyPile
		    ^c.addCard ( ^ (a (i)).lastCard) %add the selected card
		    ^c.setCentre ( ^ ( ^ (a (i)).lastCard).getcx, ^ ( ^ (a (i)).lastCard).getcy)
		    stacklength := 1
		    pcolumn := i %stores the column that was modified
		    exit %no need to loop through the stack anymore
		end if
	    end if
	end for
	if bool = false then %if a column hasn't already been chosen
	    for i : 1 .. upper (b) %loops through the cell piles
		if ^ (b (i)).getupper > 0 then %if the cell is not empty, because otherwise lastCard will return nil
		    ca := ^ (b (i)).lastCard %set the card to lastCard (could be any, but this is easier)
		    if ^ca.inCard (x, y) = true then %checks if the cursor is within the card
			^c.emptyPile
			bool := true %valid "stack"
			^c.addCard ( ^ (b (i)).lastCard) %add that card to the "stack"
			^c.setCentre ( ^ ( ^ (b (i)).lastCard).getcx, ^ ( ^ (b (i)).lastCard).getcy)
			stacklength := 1
			pcell := i %remember the cell it was removed from
			exit
		    end if
		end if
	    end for
	end if
	if bool = false then %buttons don't work so we're cheating here a bit
	    if x <= maxx - 50 and x >= maxx - 100 and y <= 50 and y >= 25 then
		back := true
		result 0
	    end if
	    if x <= 100 and x >= 50 and y <= 50 and y >= 25 then
		undo := true
		result 0
	    end if
	end if
    end loop
    ^c.drawSelected
    result stacklength
end select1

%finds the destination stack or doesn't
proc select2 (a : array 1 .. * of ^Column, b : array 1 .. * of ^Foundation, c : array 1 .. * of ^Column, stackLength : int, var pcolumn1, pfoundation1, pcell1 : int)
    var x, y, bn, bud : int     %button variables
    var bool : boolean := false
    Mouse.ButtonWait ("down", x, y, bn, bud)     %wait until the mouse is clicked again - there's a Mouse.ButtonWait("up" ...) before this
    %case: adding the column to another existing stack. this goes first because the one-card column is universal between the two cases.
    for i : 1 .. upper (a)    %similar to the first select procedure - loops through each stack to see if a valid placement has been made
	if ^ (a (i)).getupper > 0 then     %if the column is *not* empty
	    if ^ ( ^ (a (i)).lastCard).inCard (x, y) = true then     %checks if the mouse selected the last card of a stack and if it's a valid move
		pcolumn1 := i
		bool := true
		exit
	    end if
	else     %if the column *is* empty
	    if ^ (a (i)).isInside (x, y) = true then
		%if the mouse is within the empty stack's box, add the card to the empty column (FREECELL). Klondike will only allow Kings, so implement accordingly (see above case).
		pcolumn1 := i
		bool := true
		exit
	    end if
	end if
    end for
    if bool = false then
	%checks if the "column" is just one card. if so, check if it can be added to a foundation
	if stackLength = 1 then
	    for i : 1 .. upper (b) %loops through the array of foundations
		%if the mouse is within the foundation borders and a valid move is made, then
		if ^ (b (i)).isInside (x, y) = true then
		    pfoundation1 := i
		    exit
		end if
	    end for
	    for i : 1 .. upper (c) %loops through the cells
		%if the mouse is in the cell and the cell is empty then
		if ^ (c (i)).isInside (x, y) = true and ^ (c (i)).isEmpty = true then
		    pcell1 := i
		    exit
		end if
	    end for
	end if
    end if
end select2
