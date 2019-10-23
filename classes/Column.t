unit
class Column %these are the columns we see in klondike and freecell solitaire. it could also be used for spider solitaire, but no one likes spider solitaire
    inherit Pile in "Pile.t"
    export ksetFlipped, isValidStack

    %sets the center of the topmost card (also known as the card in array index 1)
    body proc setCentre (nx, ny : int)
	x := nx
	y := ny
	%setting the centers of the rest of the cards in the stack (25 pixels of card are visible for the partially-covered cards)
	if u > 0 then
	    for i : 1 .. u
		^ (pile(i)).setCentre (x, y - 25 * (i - 1))
	    end for
	end if
    end setCentre

    %checks if a newCard can be added to a card - should be incorporated into the addCard procedure
    %in terms of the last card in the stack, basically checks if the colour is different (mod 2, so 1 or 3 vs 2 or 4) and if the number is one less
    %this gets called in the select card procedures - not in the addCard, because the initial "dealing" also uses addCard and would very likely not deal out the full configuration of cards
    %note that another clause must be added for klondike (in the body code, not here) in which if c = 0, ^newCard.getValue = 13 since you can only place Kings on empty columns
    body fcn validMove (newCard : ^Card) : boolean
	if u = 0 or ( ^newCard.getSuit mod 2 ~= ^lastCard.getSuit mod 2 and ^newCard.getValue + 1 = ^lastCard.getValue) then
	    result true
	end if
	result false
    end validMove

    %draws each card based on setCentre
    body proc draw
	if u > 0 then
	    for i : 1 .. u
		^ (pile(i)).draw %draws each column - a cascading effect is created because of the setCentre procedure
	    end for
	else
	    var p1 := Pic.New (-70, -100, 0, 0)
	    var p2 := Pic.New (x - 35, y - 50, x + 35, y + 50)
	    var p3 := Pic.Blend (p1, p2, 20)
	    Pic.Draw (p3, x - 35, y - 50, picCopy)
	    Pic.Free (p1)
	    Pic.Free (p2)
	    Pic.Free (p3)
	    Draw.Box (x - 35, y - 50, x + 35, y + 50, 0)
	end if
    end draw

    %flips the last card of the column (regardless of its current state).
    proc ksetFlipped
	if u > 0 then
	    ^ (pile (u)).setFace (true)
	end if
    end ksetFlipped

    %checks if a selected stack is valid
    %this is more effectively used in freecell, because one can just check for face-up cards in a stack for klondike
    fcn isValidStack : boolean
	if u > 1 then
	    var s := ^ (pile (1)).getSuit
	    var v := ^ (pile (1)).getValue
	    for i : 1 .. u
		if ^ (pile (i)).getSuit mod 2 ~= s mod 2 then
		    result false
		end if
		if ^ (pile (i)).getValue ~= v then
		    result false
		end if
		v -= 1
		if s = 1 then
		    s := 4
		else
		    s -= 1
		end if
	    end for
	else
	    result false
	end if
	result true
    end isValidStack
end Column
