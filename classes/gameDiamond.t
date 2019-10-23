unit
class Diamond
    %inherits all of the methods found in the shape class
    inherit Shape in "Shape.t"

    %colour set to red, width and height specified for use in the cards
    c := 12
    w := 20
    h := 25
    
    %draws four lines and calls draw.fill on the center point
    body proc draw
	Draw.Line (cx + w div 2, cy, cx, cy + h div 2, c)
	Draw.Line (cx + w div 2, cy, cx, cy - h div 2, c)
	Draw.Line (cx - w div 2, cy, cx, cy + h div 2, c)
	Draw.Line (cx - w div 2, cy, cx, cy - h div 2, c)
	Draw.Fill (cx, cy, c, c)
    end draw
end Diamond
