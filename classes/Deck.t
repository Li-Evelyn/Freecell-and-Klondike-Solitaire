unit
class Deck
    import Card in "gameCard.t"
    export getDeckSize, discardCard, drawCard, getCard, shuffleDeck, addCard, lastCard

    var deck : flexible array 1 .. 0 of ^Card

    var storage : ^Card

    for i : 1 .. 4
	for j : 1 .. 13
	    new deck, (i - 1) * 13 + j
	    new deck ((i - 1) * 13 + j)
	    ^ (deck ((i - 1) * 13 + j)).setCard (i, j)
	end for
    end for

    fcn getDeckSize : int
	result upper (deck)
    end getDeckSize

    proc discardCard
	new deck, getDeckSize - 1
    end discardCard

    fcn drawCard : ^Card
	storage := deck (upper (deck))
	discardCard
	result storage
    end drawCard

    fcn getCard (i : int) : ^Card
	result deck (i)
    end getCard
    
    fcn lastCard : ^Card
	if upper(deck) > 0 then
	    result deck(upper(deck))
	end if
	result nil
    end lastCard

    proc shuffleDeck
	var s : ^Card
	var n, m : int
	for i : 1 .. 5000
	    n := Rand.Int (1, upper (deck))
	    m := Rand.Int (1, upper (deck))
	    s := deck (n)
	    deck (n) := deck (m)
	    deck (m) := s
	end for
    end shuffleDeck

    proc addCard (c : ^Card)
	var size : int := getDeckSize + 1
	new deck, size
	new deck (size)
	deck (size) := c
    end addCard

end Deck
