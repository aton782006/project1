extends Node


@onready var canvas_modulate: CanvasModulate = $CanvasModulate
@onready var player: CharacterBody2D = get_parent().get_node("Player")



func _physics_process(delta: float) -> void:
	var player_x = player.position.x
	var new_light_value: float = 1.0 - ((player_x / 2000.0) * (1.0 - 0.1))
	new_light_value = clamp(new_light_value, 0.5, 1)
	canvas_modulate.color = Color(new_light_value, new_light_value, new_light_value,1)
	$ParallaxBackground
	print(canvas_modulate.modulate)
