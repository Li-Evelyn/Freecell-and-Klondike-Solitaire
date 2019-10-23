%move the stack
proc kmoveStack (a : array 1 .. * of ^Column, b : array 1 .. * of ^Foundation, deck : ^Deck, pile : ^Foundation)
    var c : ^Column
    new c
    %get information from the stored move
    var s : string := moves (upper (moves))
    var m : int := strint (s (2))
    var n : int := strint (s (4))
    var o : int := strint (s (5 .. 6))
    var bool : boolean := false
    if s (1) = "C" then
	for i : ^ (a (m)).getupper - o + 1 .. ^ (a (m)).getupper
	    ^c.addCard ( ^ (a (m)).getCard (i))
	end for
    elsif s (1) = "F" then
	^c.addCard ( ^ (b (m)).lastCard)
    elsif s (1) = "D" then
	if ^deck.getDeckSize > 0 then
	    ^pile.addCard ( ^deck.drawCard)
	    bool := true
	else
	    if ^pile.getupper > 0 then
		for decreasing i : ^pile.getupper .. 1
		    ^deck.addCard ( ^pile.getCard (i))
		end for
		bool := true
		^pile.emptyPile
	    end if
	end if
    else
	if s = "c0D000f" then %undo = true here but it's a special case
	    for i : 1 .. ^deck.getDeckSize
		^pile.addCard(^deck.drawCard)
	    end for
	    new moves, upper(moves) - 1
	    bool := true
	elsif s = "c0D001f" then
	    ^deck.addCard(^pile.lastCard)
	    ^pile.removeCard
	    new moves, upper(moves) - 1
	    bool := true
	end if
	if ^pile.getupper > 0 then
	    ^c.addCard ( ^pile.lastCard)            
	end if
    end if
    %cases: if undo = true, validmove does not need to be checked
    if bool = false then
	if undo = true then
	    case (s (3)) of
		label "C" :
		    if s (*) = "t" then
			^ ( ^ (a (n)).lastCard).setFace (false)
		    end if
		    for i : 1 .. o
			^ (a (n)).addCard ( ^c.getCard (i))
		    end for
		label "F" :
		    ^ (b (n)).addCard ( ^c.getCard (1))
		label "D" :
		    for i : 1 .. ^c.getupper
			^deck.addCard ( ^c.getCard (i))
		    end for
		label :
		    ^pile.addCard ( ^c.getCard (1))
	    end case
	    new moves, upper (moves) - 1
	    bool := true
	else
	    case (s (3)) of
		label "C" :
		    if ^ (a (n)).isEmpty = false then
			if ^ (a (n)).validMove ( ^c.getCard (1)) = true then
			    for i : 1 .. o
				^ (a (n)).addCard ( ^c.getCard (i))
			    end for
			    bool := true
			else
			    new moves, upper (moves) - 1
			end if
		    else
			if ^ ( ^c.getCard (1)).getValue = 13 then
			    for i : 1 .. o
				^ (a (n)).addCard ( ^c.getCard (i))
			    end for
			    bool := true
			else
			    new moves, upper (moves) - 1
			end if
		    end if
		label "F" :
		    if o = 1 and ^ (b (n)).validMove ( ^c.getCard (1)) = true then
			^ (b (n)).addCard ( ^c.getCard (1))
			bool := true
		    else
			new moves, upper (moves) - 1
		    end if
	    end case
	end if
	if bool = true then
	    case (s (1)) of
		label "C" :
		    for i : 1 .. o
			^ (a (m)).removeCard
		    end for
		label "F" :
		    ^ (b (m)).removeCard
		label "D" :
		    ^deck.discardCard
		label :
		    ^pile.removeCard
	    end case
	end if
    end if
end kmoveStack
