proc freeCell
    var columnArray : array 1 .. 8 of ^Column %make the memory space for four columns
    var foundationArray : array 1 .. 4 of ^Foundation %make the memory space for four foundations
    var cellArray : array 1 .. 4 of ^Column
    var backButton : int
    var undoButton : int
    var deck : ^Deck
    new deck
    new moves, 0

    %actually make the cells, columns, and foundations (objects with the default fields)
    for i : 1 .. 8
	new columnArray (i)
    end for
    for i : 1 .. 4
	new foundationArray (i)
	new cellArray (i)
    end for
    %shuffle the deck
    ^deck.shuffleDeck

    %load the column array by dealing horizontally until the deck is empty
    var counter := 0
    loop
	exit when ^deck.getDeckSize = 0
	counter += 1
	^ (columnArray (counter)).addCard ( ^deck.drawCard)
	^(columnArray(counter)).setFlipped(true)
	if counter = 8 then
	    counter := 0
	end if
    end loop

    %flip everything face up
    for i : 1 .. 8
	^ (columnArray (i)).setFlipped (true)
	^ (columnArray (i)).setCentre (maxx div 9 * i, maxy * 2 div 3) %set the center of the top card of each column using this nifty formula
    end for

    for i : 1 .. 4
	^ (foundationArray (i)).setCentre (maxx + 30 - maxx div 9 * i, maxy * 6 div 7)     %set the center of each foundation using this similarly nifty formula
	^ (cellArray (i)).setCentre (maxx div 9 * i - 30, maxy * 6 div 7)     %i'll stop tooting my own horn now
    end for

    %play the game
    loop
	exit when wingame (foundationArray) = true or GUI.ProcessEvent or back = true
	background := Pic.FileNew ("pictures/gameback.jpg")
	Pic.Draw (background, -300, -200, picMerge)
	undo := false
	drawBoard (columnArray, foundationArray, cellArray)
	backButton := GUI.CreateButton (maxx - 100, 25, 50, "Back", backButtonPressed)
	undoButton := GUI.CreateButton (50, 25, 50, "Undo", backButtonPressed)
	selectStacks (columnArray, cellArray, foundationArray) %move things around
	Pic.Free (background)
    end loop

    GUI.Dispose (backButton)
    GUI.Dispose (undoButton)

end freeCell
