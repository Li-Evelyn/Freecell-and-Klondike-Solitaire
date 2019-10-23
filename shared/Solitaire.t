%more testing
include "shared/includesList.t" %include these files (starting off with imports)
    
loop
    if playagain = false and quitgame = false then %if the user decides not to play again or if this is the first session
	setInitialValues %sets the initial values
	mainMenu %runs the main menu
    end if
    playagain := false
    case (selected) of 
	label 0:
	    exit
	    
	label 1:
	    klondikeMenu
	
	label 2:
	    freecellMenu
	
    end case
    
    case (selection) of    
	label 1 : 
	    klondike
	
	label 2 :
	    kInstructionsWindow
	    
	label 3 : 
	    freeCell
	    
	label 4 :
	    fInstructionsWindow
	    
	label :
	
    end case
	
    if selection = 1 or selection = 3 then
	gameOverScreen
    end if

end loop

Window.Close(winID)
