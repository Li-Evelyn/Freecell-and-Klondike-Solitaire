unit
class Foundation %foundation piles in both klondike and freecell as well as the open pile in klondike
    inherit Pile in "Pile.t"

    %sets the center of the foundation
    body proc setCentre (nx, ny : int)
	x := nx
	y := ny
	if u > 0 then
	    for i : 1 .. u
		^(pile(i)).setCentre(x, y)
	    end for
	end if
    end setCentre
    
    %determines if a card can be added to the foundation
    %stipulation #1: value of the card must be one higher than the previous (also known as the upper limit on the array)
    %stipulation #2: suit must be the same, unless the foundation is empty, in which case any suit may be assigned.
    body fcn validMove (newCard : ^Card) : boolean
	if ^newCard.getValue = u + 1 then %first checks value
	    if u > 0 and ^newCard.getSuit = ^lastCard.getSuit then
		result true
	    end if
	    if u = 0 then
		result true
	    end if
	end if
	result false
    end validMove

    %draws the top card or an empty box (other cards are layered underneath, but since these are perfect piles, they're not visible from the bird's eye view)
    %if you want to do a three-card-flip mode klondike, modify this accordingly (if you want help, you can look at the column setCentre procedure - it's probably similar, but horizontally)
    body proc draw
	if isEmpty = false then
	    ^lastCard.draw
	else
	    var p1 := Pic.New(-70, -100, 0, 0)
	    var p2 := Pic.New(x - 35, y - 50, x + 35, y + 50)
	    var p3 := Pic.Blend(p1, p2, 20)
	    Pic.Draw(p3, x - 35, y - 50, picCopy)
	    Pic.Free(p1)
	    Pic.Free(p2)
	    Pic.Free(p3)
	    Draw.Box (x - 35, y - 50, x + 35, y + 50, 0)
	end if
    end draw
    
end Foundation
