extends Control

@export var player:Player

@onready var quitButton:Button = $PanelContainer/MarginContainer/VBoxContainer/QuitButton
@onready var scoreLabel:Label = $PanelContainer/MarginContainer/VBoxContainer/ScoreLabel

func open():
	get_tree().paused = true
	quitButton.grab_focus()
	scoreLabel.text = str(player.score)
	visible = true

func close():
	get_tree().paused = false
	quitButton.release_focus()
	visible = false
	var main_menu := ResourceLoader.load("res://main_menu/main_menu.tscn") as PackedScene
	var error := get_tree().change_scene_to_packed(main_menu)
	if error != OK:
		print(error)
		get_tree().quit(1)
