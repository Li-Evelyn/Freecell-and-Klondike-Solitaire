%menus and instructions
%a.k.a. non-game screens

proc mainMenu
    background := Pic.FileNew ("pictures/titlescreen.jpg")
    %Pic.Draw (background, -300, -200, picMerge)
    Pic.Draw(background, 0, 0, picMerge)
    %buttons
    var klondikeButton := GUI.CreateButton (maxx div 2 - 64, maxy div 2 + 50, 0, "Klondike Solitaire", klondikeButtonPressed)
    var freecellButton := GUI.CreateButton (maxx div 2 - 64, maxy div 2, 128, "FreeCell Solitaire", freecellButtonPressed)
    var closeButton := GUI.CreateButton (maxx div 2 - 64, maxy div 2 - 50, 128, "Exit Program", quitButtonPressed)

    %wait until a button is pressed
    loop
	exit when GUI.ProcessEvent or selected > -1
    end loop

    %buttons are disposed of accordingly
    GUI.Dispose (closeButton)
    GUI.Dispose (klondikeButton)
    GUI.Dispose (freecellButton)

    Pic.Free (background)

end mainMenu

proc klondikeMenu
    background := Pic.FileNew ("pictures/klondikemenu.jpg")
    Pic.Draw (background, 0, 0, picMerge)
    %more buttons
    var playButton := GUI.CreateButton (maxx div 2 - 50, maxy div 2 + 50, 100, "Play", kPlay)
    var instructionsButton := GUI.CreateButton (maxx div 2 - 50, maxy div 2, 100, "Instructions", kInstructions)
    var backButton := GUI.CreateButton (maxx div 2 - 50, maxy div 2 - 50, 100, "Back", backButtonPressed)

    %wait until a button is pressed
    loop
	exit when GUI.ProcessEvent or selection > -1 or back = true
    end loop

    %bye buttons
    GUI.Dispose (backButton)
    GUI.Dispose (playButton)
    GUI.Dispose (instructionsButton)

    Pic.Free (background)

end klondikeMenu

proc freecellMenu
    background := Pic.FileNew ("pictures/freecell menu.jpg")
    Pic.Draw (background, 0, 0, picMerge)
    %surprising absolutely no one, more buttons!
    var playButton := GUI.CreateButton (maxx div 2 - 50, maxy div 2 + 50, 100, "Play", fPlay)
    var instructionsButton := GUI.CreateButton (maxx div 2 - 50, maxy div 2, 100, "Instructions", fInstructions)
    var backButton := GUI.CreateButton (maxx div 2 - 50, maxy div 2 - 50, 100, "Back", backButtonPressed)

    %wait until a button is pressed
    loop
	exit when GUI.ProcessEvent or selection > -1 or back = true
    end loop

    %see ya buttons
    GUI.Dispose (backButton)
    GUI.Dispose (playButton)
    GUI.Dispose (instructionsButton)

    Pic.Free (background)

end freecellMenu

proc kInstructionsWindow

    %this is maybe temporary - if there's time, do a slideshow
    colourback(black)
    colour(47)
    cls
    var stream : int
    open : stream, "instructions/klondikeinstructions.txt", get
    if stream > 0 then
	var lines : string
	loop
	    exit when eof (stream)
	    get : stream, lines : *
	    put lines
	end loop
    else
	put "File not found."
    end if
    close : stream

    var backButton := GUI.CreateButton (maxx - 100, 25, 0, "Back", backButtonPressed)

    %wait until a button is pressed
    loop
	exit when GUI.ProcessEvent or back = true
    end loop

    %bye button
    GUI.Dispose (backButton)
    
    colourback(white)
    colour(black)

end kInstructionsWindow

proc fInstructionsWindow

    colourback(black)
    colour(47)
    %this is maybe temporary - if there's time, do a slideshow
    cls
    var stream : int
    open : stream, "instructions/freecellinstructions.txt", get
    if stream > 0 then
	var lines : string
	loop
	    exit when eof (stream)
	    get : stream, lines : *
	    put lines
	end loop
    else
	put "File not found."
    end if
    close : stream

    var backButton := GUI.CreateButton (maxx - 100, 25, 0, "Back", backButtonPressed)

    %wait until a button is pressed
    loop
	exit when GUI.ProcessEvent or back = true
    end loop

    %see ya
    GUI.Dispose (backButton)
    
    colourback(white)
    colour(black)

end fInstructionsWindow


proc gameOverScreen
    background := Pic.FileNew ("pictures/wingamescreen.jpg")
    Pic.Draw (background, 0, 0, picMerge)

    if won = true then

    else

    end if
    
    %more buttons!
    var playAgainButton := GUI.CreateButton (maxx div 2 - 55, maxy div 2 + 50, 110, "Play Again", playAgain)
    var menuButton := GUI.CreateButton (maxx div 2 - 55, maxy div 2, 110, "Back to Menu", backButtonPressed)
    var quitButton := GUI.CreateButton (maxx div 2 - 55, maxy div 2 - 50, 110, "Exit Program", quitButtonPressed)
    
    loop
	exit when GUI.ProcessEvent or back = true or playagain = true or selected = 0
    end loop
    
    GUI.Dispose(playAgainButton)
    GUI.Dispose(menuButton)
    GUI.Dispose(quitButton)
    
    Pic.Free (background)

end gameOverScreen
