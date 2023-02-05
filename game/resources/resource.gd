class_name CollectibleResource
extends Area2D

enum Type {
	RED,
	GREEN,
	BLUE,
}

## Which type of resource this is
@export
var type : Type = Type.RED

## The images
var _images : Array[String] = [
	"res://game/resources/sprites/red_triangle.png",
	"res://game/resources/sprites/green_square.png",
	"res://game/resources/sprites/blue_star.png",
]


func _ready() -> void:
	$Sprite.texture = load(_images[type])


func _on_body_entered(body: Node2D) -> void:
	var player := body as Player
	match type:
		Type.RED:
			player.r_resources += 1
		Type.GREEN:
			player.g_resources += 1
		Type.BLUE:
			player.b_resources += 1
	queue_free()
