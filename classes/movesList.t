unit
class movesList
    import Column in "Column.t", Foundation in "Foundation.t"
    export addStateF, removeStateF, getMove, load, getupper, drawState
    include "state.t"

    var fmoves : flexible array 1 .. 0 of ^fstate

    var upperbound : int := 0

    proc drawState (n : int)
	var winid : int := Window.Open ("graphics:1000;800,nocursor")
	put n
	for i : 1 .. 8
	    ^ ( ^ (fmoves (n)).stackArray (i)).draw
	end for
	for i : 1 .. 4
	    ^ ( ^ (fmoves (n)).cellArray (i)).draw
	    ^ ( ^ (fmoves (n)).foundationArray (i)).draw
	end for
	loop
	    exit when hasch
	end loop
	Window.Close (winid)
    end drawState

    proc addStateF (a : array 1 .. 8 of ^Column, b : array 1 .. 4 of ^Column, c : array 1 .. 4 of ^Foundation)
	upperbound += 1 %something here is wrong - the state gets loaded to both
	new fmoves, upperbound
	new fmoves (upperbound)
	var d : ^Column
	var e : ^Foundation
	new d
	new e
	for i : 1 .. 8
	    ^ (fmoves (upperbound)).stackArray (i) := d
	    for j : 1 .. ^ (a (i)).getupper
		^ ( ^ (fmoves (upperbound)).stackArray (i)).addCard ( ^ (a (i)).getCard (j))
		^ ( ^ (fmoves (upperbound)).stackArray (i)).setCentre ( ^ (a (i)).getcx, ^ (a (i)).getcy)
	    end for
	end for
	for i : 1 .. 4
	    ^ (fmoves (upperbound)).cellArray (i) := d
	    ^ (fmoves (upperbound)).foundationArray (i) := e
	    for j : 1 .. ^ (b (i)).getupper
		^ ( ^ (fmoves (upperbound)).cellArray (i)).addCard ( ^ (b (i)).getCard (j))
		^ ( ^ (fmoves (upperbound)).cellArray (i)).setCentre ( ^ (b (i)).getcx, ^ (b (i)).getcy)
	    end for
	    if ^ (c (i)).getupper > 0 then
		^ ( ^ (fmoves (upperbound)).foundationArray (i)).addCard ( ^ (c (i)).lastCard)
		^ ( ^ (fmoves (upperbound)).foundationArray (i)).setCentre ( ^ (c (i)).getcx, ^ (c (i)).getcy)
	    end if
	end for
    end addStateF

    proc removeStateF
	upperbound -= 1
	new fmoves, upperbound
    end removeStateF

    fcn getMove : ^fstate
	if upperbound > 0 then
	    result fmoves (upperbound)
	end if
	result nil
    end getMove

    proc load (var a : array 1 .. 8 of ^Column, var b : array 1 .. 4 of ^Column, var c : array 1 .. 4 of ^Foundation)

	for i : 1 .. 8
	    a (i) := ^ (fmoves (upperbound)).stackArray (i)
	end for
	for i : 1 .. 4
	    b (i) := ^ (fmoves (upperbound)).cellArray (i)
	    c (i) := ^ (fmoves (upperbound)).foundationArray (i)
	end for
    end load

    fcn getupper : int
	result upper (fmoves)
    end getupper

end movesList
