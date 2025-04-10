extends Node2D



var bat_path = preload("res://Characters/Bat/bat.tscn")
func _on_timer_timeout():
	var bat = bat_path.instantiate()
	get_tree().current_scene.add_child(bat)
	bat.position = position
	pass # Replace with function body.
