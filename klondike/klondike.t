proc klondike
    var backButton : int
    var undoButton : int
    var deck : ^Deck %deck being used
    var column : array 1 .. 7 of ^Column %array of columns
    var card : ^Card %face down card for the pile
    var foundation : array 1 .. 4 of ^Foundation %array of foundations
    var pile : ^Foundation %the pile in the upper right
    new moves, 0
    lastCard := false
    flipped := false

    new deck %initialize the deck
    ^deck.shuffleDeck %shuffle it

    %initialize the columns
    for i : 1 .. 7
	new column (i)
    end for
    for i : 1 .. 7
	for j : 1 .. i
	    ^ (column (i)).addCard ( ^deck.drawCard)
	    ^(column(i)).setFlipped(false)
	end for
	^ (column (i)).ksetFlipped %flip the last card
    end for

    %initialize the lone card
    new card
    ^card.setFace(false)

    %initialize the foundations
    for i : 1 .. 4
	new foundation (i)
    end for
    
    %initialize the pile
    new pile

    %play the game
    loop
	exit when wingame (foundation) or GUI.ProcessEvent or back = true
	background := Pic.FileNew ("pictures/gameback.jpg")
	Pic.Draw (background, -300, -200, picMerge)
	undo := false
	flipped := false
	reDraw (column, foundation, pile, card)
	backButton := GUI.CreateButton (maxx - 100, 25, 50, "Back", backButtonPressed)
	undoButton := GUI.CreateButton (50, 25, 50, "Undo", undoButtonPressed)
	kselectStacks (column, foundation, card, deck, pile) %move things around
	Pic.Free (background)
    end loop

    GUI.Dispose (backButton)
    GUI.Dispose (undoButton)
    
    new deck

end klondike
