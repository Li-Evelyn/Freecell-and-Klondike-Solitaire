unit 
class Stack1
    import Card in "Card.t"
    export 
    
    var a : flexible array 1 .. 0 of ^Card
    
    %Default center variables
    var x := 0
    var y := 0
    
    %Get the center x coordinate of the top card
    fcn getX : int
	result x
    end getx
    
    %Get the center y coordinate of the top card
    fcn getY : int
	result y
    end gety
    
    %Get a specific card in the stack
    fcn getC (i : int) : int
	result a(i)
    end getc

    %Get the upperbound of the array
    fcn getStackUpper : int
	result upper(a)
    end getStackUpper
    
    fcn lastCard : ^Card
	result a(upper(a))
    end lastCard
    
    %Add a card to the stack
    proc addCard (nc : ^Card)
	new a, upper(a) + 1
	new a (upper(a))
	^lastCard.setCard(^nc.getSuit, ^nc.getValue)
	^lastCard.setCentre(^nc.getcx, ^nc.getcy)
	^lastCard.setFace(true)
    end addCard
    
    %Remove the top card
    proc removeCard
	new a, upper(a) - 1
    end removeCard
    
    %Set all cards flipped to the same boolean value
    proc setAllFlipped (tf : boolean)
	if upper(a) > 0 then
	    for i : 1 .. upper(a)
		^(a(i
    end setAllFlipped
    
    
    
end Stack1
