%global variables
var winID := Window.Open ("graphics:1000;800,nocursor")
var selected, selection : int := -1 %menu selection variables
var back : boolean %checks if the back button has been pressed
var KorF : boolean %checks which gamemode is selected
var quitgame : boolean := false
var playagain : boolean := false %if the user decides to play the same gamemode again
var won : boolean := false
var undo : boolean := false
var background := Pic.FileNew ("../pictures/gameBack.jpg")
var title := Pic.FileNew("../pictures/solitiare.jpg")
var moves : flexible array 1 .. 0 of string
var lastCard : boolean := false
var flipped : boolean := false

%picture variables here

proc setInitialValues
    back := false
    playagain := false
    selected := -1
    selection := -1
end setInitialValues
