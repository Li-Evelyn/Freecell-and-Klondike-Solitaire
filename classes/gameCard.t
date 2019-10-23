unit
class Card %similar to the card made in unit 1, but has more methods and uses "different" suits
    import Heart in "gameHeart.t", Diamond in "gameDiamond.t", Spade in "gameSpade.t", Club in "gameClub.t"
    export setCard, setCentre, getcx, getcy, getSuit, getValue, draw, erase, setFace, getFace, inCard, inTopOfCard

    %declares a bunch of small suits and creates each object
    var smolspade : ^Spade
    var smolheart : ^Heart
    var smolclub : ^Club
    var smoldiamond : ^Diamond
    new smolspade
    new smolheart
    new smolclub
    new smoldiamond

    %center x and center y variables, which can be changed
    var cax : int := 150
    var cay : int := 100
    
    %card width and height. cannot be changed (these cards were made for the specific purpose of these games)
    const caw : int := 70
    const cah : int := 100
    
    %suit: 1 = spade, 2 = heart, 3 = club, 4 = diamond
    %value: 1 = "A", 2 = "2" .. 11 = "J", 12 = "Q", 13 = "K"
    %face: true = face up, false = face down
    %default card: face down Ace of Spades
    var suit : int := 1
    var value : int := 1
    var face : boolean := false

    %sets each small suit to these sizes so that they fit within the cards
    ^smolspade.sethw (10, 12)
    ^smolheart.sethw (10, 12)
    ^smolclub.sethw (10, 12)
    ^smoldiamond.sethw (10, 12)

    %sets the card suit and value
    proc setCard (cardsuit, num : int)
	suit := cardsuit
	value := num
    end setCard

    %sets the center of the cards as well as the suit in the upper left (which is later rotated)
    proc setCentre (x, y : int)
	cax := x
	cay := y
	^smolspade.setCentre (cax - (cah * 0.7 div 2) + 10, cay + (cah div 2) - 27)
	^smolheart.setCentre (cax - (cah * 0.7 div 2) + 10, cay + (cah div 2) - 27)
	^smolclub.setCentre (cax - (cah * 0.7 div 2) + 10, cay + (cah div 2) - 27)
	^smoldiamond.setCentre (cax - (cah * 0.7 div 2) + 10, cay + (cah div 2) - 27)
    end setCentre
    
    %get the center x value
    fcn getcx : int
	result cax
    end getcx
    
    %get the center y value
    fcn getcy : int
	result cay
    end getcy
    
    %there were originally getw and geth methods here, but since they're static constants, there is no need for them
    
    %get the suit of the card
    fcn getSuit : int
	result suit
    end getSuit

    %get the value of the card
    fcn getValue : int
	result value
    end getValue

    %draw the card
    proc draw
	var c : int %text colour (for the number/letter)
	var f : int := Font.New ("Times New Roman:12") %the objectively best font
	if face = true then %if the card is face up, then
	    Draw.FillBox (cax - 35, cay - 50, cax + 35, cay + 50, 0) %white inside of the card
	    Draw.Box (cax - 35, cay - 50, cax + 35, cay + 50, 7) %black outline of the card
	    %drawing the initial small suit and setting the text colour. diamond/heart = red, club/spade = black
	    case suit of
		label 1 :
		    c := 7
		    ^smolspade.draw
		label 2 :
		    c := 12
		    ^smolheart.draw
		label 3 :
		    c := 7
		    ^smolclub.draw
		label 4 :
		    c := 12
		    ^smoldiamond.draw
	    end case
	    %drawing text (different cases based on value because of character size differences)
	    case value of
		label 1 : 
		    Draw.Text ("A", cax - 30, cay + 34, f, c)
		label 10 :
		    Draw.Text ("10", cax - 33, cay + 34, f, c) %this one is moved over substantially (x coordinate) due to it having two characters instead of one
		label 11 :
		    Draw.Text ("J", cax - 28, cay + 34, f, c)
		label 12 :
		    Draw.Text ("Q", cax - 31, cay + 34, f, c)
		label 13 :
		    Draw.Text ("K", cax - 30, cay + 34, f, c)
		label :
		    Draw.Text (intstr(value), cax - 29, cay + 34, f, c)                    
	    end case
	    %for the text/suit in the bottom right corner
	    var p := Pic.New(cax - 35, cay, cax + 35, cay + 50) %a picture is made of the top half
	    var pf := Pic.Rotate(p, 180, -1, -1) %a new picture is made of the 180 rotation of the above picture
	    Pic.Draw(pf, cax - 35, cay - 50, picMerge) %the second picture is drawn below the first picture (starting from the bottom left corner)
	    Pic.Free(p) %so the storage doesn't go boom
	    Pic.Free(pf) %see above
	else %if the card is face down
	    Draw.FillBox (cax - 35, cay - 50, cax + 35, cay + 50, 0) %white card "outline"
	    Draw.FillBox (cax - 25, cay - 40, cax + 25, cay + 40, 30) %grey card inside
	    Draw.Box (cax - 35, cay - 50, cax + 35, cay + 50, 7) %black card outline
	    %drawing the X
	    Draw.Line (cax - 8, cay - 12, cax + 8, cay + 12, 28)
	    Draw.Line (cax + 8, cay - 12, cax - 8, cay + 12, 28) 
	    %c's and s's
	    Draw.Text ("c", cax - 20, cay + 25, f, 28) 
	    Draw.Text ("s", cax + 14, cay + 25, f, 28)
	    Draw.Text ("c", cax + 14, cay - 34, f, 28)
	    Draw.Text ("s", cax - 20, cay - 34, f, 28)
	end if
    end draw

    %i could have just inherited from the shape class and saved myself about 30 seconds, but nah
    %erases the card by drawing a background-coloured box on top of it
    proc erase
	Draw.FillBox (cax - 35, cay - 50, cax + 35, cay + 50, colourbg)
    end erase

    %sets the flipped state of the card (face up or face down)
    proc setFace (b : boolean)
	face := b
    end setFace

    %tells you if the card is face up or face down
    fcn getFace : boolean
	result face
    end getFace
    
    %tells you if a point (hint: you generally pass the mouse's coordinates through here) is inside the card
    fcn inCard (x, y : int) : boolean
	if x <= cax + 35 and x >= cax - 35 and y <= cay + 50 and y >= cay - 50 then
	    result true
	end if
	result false
    end inCard

    %tells you if a point (generally the mouse's coordinates) is in the top (visible) part of the card (see: Column)
    fcn inTopOfCard(x, y : int) : boolean
	if x <= cax + 35 and x >= cax - 35 and y <= cay + 50 and y >= cay + 25 then
	    result true
	end if
	result false
    end inTopOfCard

end Card


