extends Control

var closeButton : Button

# Called when the node enters the scene tree for the first time.
func _ready():
	closeButton = $PanelContainer/MarginContainer/VBoxContainer/CloseButtonMarginContainer/CloseButton
	closeButton.grab_focus()
