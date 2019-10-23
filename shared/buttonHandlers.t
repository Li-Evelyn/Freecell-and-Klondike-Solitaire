%button events

proc quitButtonPressed
    selected := 0
    quitgame := true
    GUI.Quit
    GUI.ResetQuit
end quitButtonPressed

proc klondikeButtonPressed
    selected := 1
    GUI.Quit
    GUI.ResetQuit
end klondikeButtonPressed

proc freecellButtonPressed
    selected := 2
    GUI.Quit
    GUI.ResetQuit
end freecellButtonPressed

proc backButtonPressed
    back := true
    selection := 0
    GUI.Quit
    GUI.ResetQuit
end backButtonPressed

proc kPlay
    selection := 1
    GUI.Quit
    GUI.ResetQuit
end kPlay

proc kInstructions
    selection := 2
    GUI.Quit
    GUI.ResetQuit
end kInstructions

proc fPlay
    selection := 3
    GUI.Quit
    GUI.ResetQuit
end fPlay

proc fInstructions
    selection := 4
    GUI.Quit
    GUI.ResetQuit
end fInstructions

proc playAgain
    playagain := true
    GUI.Quit
    GUI.ResetQuit
end playAgain

proc undoButtonPressed
    GUI.Quit
    GUI.ResetQuit
end undoButtonPressed





