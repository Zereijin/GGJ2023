extends Control

@onready var quitButton:Button = $PanelContainer/MarginContainer/VBoxContainer/QuitButton
@onready var scoreLabel:Label = $PanelContainer/MarginContainer/VBoxContainer/ScoreLabel

func open():
	quitButton.grab_focus()
	scoreLabel.text = str(42069) #TODO calculate real score
	visible = true

func close():
	quitButton.release_focus()
	visible = false
