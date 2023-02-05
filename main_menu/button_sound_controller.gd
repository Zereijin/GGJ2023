extends Node

@export var button_hover_audio_stream_player : AudioStreamPlayer
@export var button_press_audio_stream_player : AudioStreamPlayer

func _on_pressed():
	button_press_audio_stream_player.play()


func _on_mouse_entered():
	button_hover_audio_stream_player.play()
