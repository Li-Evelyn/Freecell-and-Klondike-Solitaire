%states of the game as a record
type fstate : record
    stackArray : array 1 .. 8 of ^Column
    cellArray : array 1 .. 4 of ^Column
    foundationArray : array 1 .. 4 of ^Foundation
end record

% type kstate : record
%     stackArray : array 1 .. 7 of ^Column
%     foundationArray : array 1 .. 4 of ^Foundation
%     deck : ^Deck
%     openedCards : ^Foundation
% end record
