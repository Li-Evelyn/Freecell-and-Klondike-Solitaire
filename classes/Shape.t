unit %this is the superclass made in unit one
class Shape
    export setCentre, sethw, getCentreX, getCentreY, getWidth, getHeight, getColour, draw, erase
    
    var cx, cy, w, h, c : int
    
    cx := 320 %x coordinate of the center
    cy := 200 %y coordinate of the center
    w := 40 %width
    h := 50 %height
    c := 7 %colour (default set to black)
    
    %set the center of the shape
    proc setCentre (x, y : int)
	cx := x
	cy := y
    end setCentre
    
    %set the dimensions of the shape
    proc sethw(x, y : int)
	w := x
	h := y
    end sethw
    
    %find the x coordinate of the center
    fcn getCentreX : int
	result cx
    end getCentreX
    
    %find the y coordinate of the center
    fcn getCentreY : int
	result cy
    end getCentreY
    
    %find the width
    fcn getWidth : int
	result w
    end getWidth
    
    %find the height
    fcn getHeight : int
	result h
    end getHeight
    
    %find the colour
    fcn getColour : int
	result c
    end getColour
    
    %the purpose of deferring this procedure is to define the erase procedure at the bottom
    %since every class that inherits from this one will have a different draw procedure (but they all have the same erase procedure) we defer it to let turing know that it exists
    %thus, individual draw procedures are defined as body procedures in the inheriting classes
    deferred proc draw
    
    %temporarily sets the colour of the shape to the background colour and draws over it, then resets the colour of the shape
    proc erase
	var oc : int := getColour
	c := colourbg
	draw
	c := oc
    end erase    
    
end Shape
