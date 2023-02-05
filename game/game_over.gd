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
	var main_menu := ResourceLoader.load("res://main_menu/main_menu.tscn") as PackedScene
	var error := get_tree().change_scene_to_packed(main_menu)
	if error != OK:
		print(error)
		get_tree().quit(1)
