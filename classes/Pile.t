unit
class Pile %superclass for foundation and column
    import Card in "gameCard.t"
    export setCentre, isInside, getcx, getcy, getCard, lastCard, getupper, addCard, removeCard, isEmpty, emptyPile, drawSelected, draw, setFlipped, validMove
    
    %similar to the deck class, we create a flexible array for holding the cards.
    var pile : flexible array 1 .. 0 of ^Card
    
    %default fields
    var u : int := 0 %upper bound to shorten the amount needed to type
    
    %default starting center of the "bottom" card of the stack
    var x := 500
    var y := 700
    
    %checks if a point (usually the mouse) is within the foundation - cards are 70x100
    fcn isInside (mx, my : int) : boolean
	if mx <= x + 35 and mx >= x - 35 and my <= y + 50 and my >= y - 50 then
	    result true
	end if
	result false
    end isInside
    
    %self explanatory (c = upper(column))
    fcn isEmpty : boolean
	if u = 0 then
	    result true
	end if
	result false
    end isEmpty

    %gets the center x of the topmost card of the stack
    fcn getcx : int
	result x
    end getcx

    %gets the center y of the topmost card of the stack
    fcn getcy : int
	result y
    end getcy

    %gets a card at a specific spot
    fcn getCard (i : int) : ^Card
	result pile (i)
    end getCard

    %gets the last card in the stack or nil if the stack if empty
    fcn lastCard : ^Card
	if u > 0 then
	    result pile (u)
	else
	    result nil
	end if
    end lastCard

    %gets the size of the deck
    fcn getupper : int
	result u
    end getupper
    
    %adds a card to the deck
    proc addCard (newCard : ^Card)
	u := u + 1
	new pile, u %increases the flexible array
	new pile (u) %creates an object in that array index
	%modifies the object's fields
	^ (pile(u)).setCard ( ^newCard.getSuit, ^newCard.getValue)
	^ (pile(u)).setFace (true)
	^ (pile(u)).setCentre (^newCard.getcx, ^newCard.getcy)
    end addCard
    
    %removes the top card of the foundation
    proc removeCard
	u := u - 1
	new pile, u
    end removeCard
    
    %setFace but for all of the cards in the pile
    proc setFlipped (b : boolean)
	if u > 0 then
	    for i : 1 .. u
		^(pile(i)).setFace(b)
	    end for
	end if
    end setFlipped
    
    %draws a blue box around the pile
    proc drawSelected
	Draw.Box(x - 35, y + 50, x + 35, ^(pile(u)).getcy - 50, 54)
	Draw.Box(x - 36, y + 51, x + 36, ^(pile(u)).getcy - 51, 54)
    end drawSelected
    
    %empty the column
    proc emptyPile
	new pile, 0
	u := 0
    end emptyPile
    
    deferred fcn validMove (newCard : ^Card) : boolean
    deferred proc draw
    deferred proc setCentre (nx, ny : int)
    
end Pile
