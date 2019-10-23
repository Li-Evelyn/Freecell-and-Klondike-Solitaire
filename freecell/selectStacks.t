proc selectStacks (a : array 1 .. * of ^Column, b : array 1 .. * of ^Column, c : array 1 .. * of ^Foundation)
    %button variables (mouse x, mouse y, button number, buttonupdown)
    %for use with Mouse.ButtonWait()
    var mx, my, bn, bud : int 
    %short for placeholder-column and placeholder-foundation, stores the initial location of the selected column
    var pcolumn, pcell : int := 0 
    %see above, but for the desired location
    var pcolumn1, pfoundation1, pcell1 : int := 0
    %number of cards in the selection
    var stackLength : int
    %selects a stack from one of the "columns" and records its length and initial position
    stackLength := select1(a, b, pcolumn, pcell)
    %waits for the mouse to be released to avoid flickering
    Mouse.ButtonWait("up", mx, my, bn, bud)
    %checks if the undo button was clicked. if not, select a destination
    if undo = false then    
	select2 (a, c, b, stackLength, pcolumn1, pfoundation1, pcell1)
    end if
    %store the move made (encompasses undo as well) if the back button hasn't been pressed
    %this isn't combined in the above if statement because if undo is true, this also gets executed (storeMove will just reverse and remove the last move)
    if back = false then
	if storeMove(pcolumn, pcell, pcolumn1, pfoundation1, pcell1, stackLength) = true then
	    moveStack(a, b, c)
	end if
    end if
end selectStacks

%note to self: you've removed the resulting of a column from select1
%as such, you can no longer check for a valid move in select2, so this has to be done in storeMove (which makes sense anyways)
%this isn't done yet, so remember to do it!
