extends Node2D




func _on_player_die_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://Levels/level_3.tscn")
	pass # Replace with function body.
