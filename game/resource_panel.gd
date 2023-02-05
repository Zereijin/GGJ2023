extends Control

@export var player:Player

@onready var _r_label:Label = $ResourceMarginContainer/ResourceHBoxContainer/RResourceMarginContainer/HBoxContainer/Label
@onready var _g_label:Label = $ResourceMarginContainer/ResourceHBoxContainer/GResourceMarginContainer2/HBoxContainer/Label
@onready var _b_label:Label = $ResourceMarginContainer/ResourceHBoxContainer/BResourceMarginContainer3/HBoxContainer/Label

func _ready():
	if (player):
		_on_player_update_resources()
	else:
		print("ResourcePanel: No player found")

func _on_player_update_resources():
	_r_label.text = str(player.r_resources)
	_g_label.text = str(player.g_resources)
	_b_label.text = str(player.b_resources)
