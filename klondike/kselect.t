%select stack (of length 1 or greater, up to the number of uncovered cards in a column)
%takes n = upper(a), a, and two variables.
fcn kselect1 (a : array 1 .. * of ^Column, b : array 1 .. * of ^Foundation, cb : ^Card, deck : ^Deck, pile : ^Foundation, var pc, pf, pd, pcard : int) : int
    var x, y, bn, bud : int %button variables
    var bool : boolean := false %checks if a stack has been selected
    var deckclick : boolean := false
    var stackLength : int := 1
    var c : ^Column := nil %column storage
    var ca : ^Card := nil %card storage (for saving space)
    new c
    new ca
    loop
	exit when bool = true %when a stack has been selected
	Mouse.ButtonWait ("down", x, y, bn, bud) %wait until the mouse button is down. MAYBE IMPLEMENT MULTIBUTTON?
	for i : 1 .. upper (a) %loop through the stack (read: through each column individually)
	    if ^ (a (i)).getupper > 0 then %if the column isn't empty, since you can't get something from nothing
		for j : 1 .. ^ (a (i)).getupper %loop through that column
		    ca := ^ (a (i)).getCard (j) %ca stores the particular card being checked - this is just to save, eyes, brain power, and parentheses
		    if ^ca.inTopOfCard (x, y) = true and ^ca.getFace = true then %if the mouse is in the top of the card (25 pixels) and it's already face up
			bool := true %valid stack has been selected
			%add each card to the c column
			if j - 1 > 0 and ^(^(a(i)).getCard(j-1)).getFace = false then
			    flipped := true
			end if
			for k : j .. ^ (a (i)).getupper
			    ^c.addCard ( ^ (a (i)).getCard (k))
			end for
			^c.setCentre ( ^ ( ^ (a (i)).getCard (j)).getcx, ^ ( ^ (a (i)).getCard (j)).getcy) %for drawselected
			stackLength := ^c.getupper
			pc := i %stores the column that was modified
			exit %no need to loop anymore
		    end if
		end for
		if bool = false and ^ ( ^ (a (i)).lastCard).inCard (x, y) = true then %if the mouse wasn't in the top 25 pixels of a card but still in the last card, then...
		    bool := true %valid "stack"
		    if ^(a(i)).getupper > 1 and ^(^(a(i)).getCard(^(a(i)).getupper - 1)).getFace = false then
			flipped := true
		    end if
		    ^c.addCard ( ^ (a (i)).lastCard) %add the selected card
		    ^c.setCentre ( ^ ( ^ (a (i)).lastCard).getcx, ^ ( ^ (a (i)).lastCard).getcy) %again, for drawselected
		    stackLength := 1
		    pc := i %stores the column that was modified
		    exit %no need to loop through the stack anymore
		end if
	    end if
	end for
	if bool = false then %if a column hasn't already been chosen
	    for i : 1 .. upper (b) %loops through the foundation piles
		if ^ (b (i)).getupper > 0 then %if the foundation is not empty, because otherwise lastCard will return nil
		    ca := ^ (b (i)).lastCard %set the card to lastCard (could be any, but this is easier)
		    if ^ca.inCard (x, y) = true then %checks if the cursor is within the card
			bool := true %valid "stack"
			^c.addCard ( ^ (b (i)).lastCard) %add that card to the "stack"
			^c.setCentre ( ^ ( ^ (b (i)).lastCard).getcx, ^ ( ^ (b (i)).lastCard).getcy) %again, for drawselected
			stackLength := 1
			pf := i %remember the foundation it was removed from
			exit
		    end if
		end if
	    end for
	end if
	if bool = false and ^cb.inCard (x, y) = true and (^deck.getDeckSize > 0 or ^pile.getupper > 0) then
	    if ^deck.getDeckSize > 1 then %if there's more than one card in the deck
		^c.addCard ( ^deck.lastCard)
		stackLength := 1
	    elsif ^deck.getDeckSize = 1 then
		^c.addCard ( ^deck.lastCard)
		stackLength := 1
		lastCard := true
	    elsif ^deck.getDeckSize = 0 then
		lastCard := false
		stackLength := 0
	    end if
	    deckclick := true
	    pd := 1
	    exit
	end if
	%if none of that was executed, check the pile
	if bool = false and ^pile.isInside (x, y) = true and ^pile.getupper > 0 then
	    ^c.addCard ( ^pile.lastCard)
	    ^c.setCentre (160, 735)
	    pcard := 1
	    stackLength := 1
	    exit
	end if
	if bool = false then %buttons don't work so we're cheating here a bit
	    if x <= maxx - 50 and x >= maxx - 100 and y <= 50 and y >= 25 then
		back := true
		result 0
	    end if
	    if x <= 100 and x >= 50 and y <= 50 and y >= 25 and upper(moves) > 0 then
		undo := true
		result 0
	    end if
	end if
    end loop
    if deckclick = false then
	^c.drawSelected
    end if
    result stackLength
end kselect1

%finds the destination stack or doesn't
proc kselect2 (a : array 1 .. * of ^Column, b : array 1 .. * of ^Foundation, var pc1, pf1 : int)
    var x, y, bn, bud : int     %button variables
    var bool : boolean := false
    Mouse.ButtonWait ("down", x, y, bn, bud)     %wait until the mouse is clicked again - there's a Mouse.ButtonWait("up" ...) before this
    %case: adding the column to another existing stack. this goes first because the one-card column is universal between the two cases.
    for i : 1 .. upper (a)    %similar to the first select procedure - loops through each stack to see if a valid placement has been made
	if ^ (a (i)).getupper > 0 then     %if the column is *not* empty
	    if ^ ( ^ (a (i)).lastCard).inCard (x, y) = true then %checks if the mouse selected the last card of a stack
		bool := true
		pc1 := i
		exit
	    end if
	else     %if the column *is* empty
	    if ^ (a (i)).isInside (x, y) = true then
		pc1 := i
		bool := true
		exit
	    end if
	end if
    end for
    %checks if the "column" is just one card. if so, check if it can be added to a foundation
    if bool = false then
	for i : 1 .. upper (b)     %loops through the array of foundations
	    %if the mouse is within the foundation borders and a valid move is made, then
	    if ^ (b (i)).isInside (x, y) = true then
		pf1 := i
		exit
	    end if
	end for
    end if
end kselect2
