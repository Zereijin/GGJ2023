extends Control

@export var start_scene: PackedScene
var mainMenuFocusButton : Button

func _ready():
	mainMenuFocusButton = $MainMenuButtonContainer/PlayButton
	mainMenuFocusButton.grab_focus()
	get_tree().root.disable_3d = true

func _on_play_button_pressed():
	var error := get_tree().change_scene_to_packed(start_scene)
	if error != OK:
		print(error)
		get_tree().quit(1)

func _on_credits_button_pressed():
	mainMenuFocusButton = $MainMenuButtonContainer/CreditsButton
	get_node("CreditPanel").visible=true
	$CreditPanel/MarginContainer/VBoxContainer/CloseCreditsButton.grab_focus()

func _on_close_credits_button_pressed():
	get_node("CreditPanel").visible=false
	mainMenuFocusButton.grab_focus()

func _on_quit_button_pressed():
	get_tree().quit()

func _on_info_button_pressed():
	mainMenuFocusButton = $MainMenuButtonContainer/InfoButton
	get_node("InfoPanel").visible=true
	$InfoPanel/MarginContainer/VBoxContainer/CloseInfoButton.grab_focus()

func _on_close_info_button_pressed():
	get_node("InfoPanel").visible=false
	mainMenuFocusButton.grab_focus()


