extends RigidBody2D




func _on_ready_area_body_entered(body):
	if body.name == "Player":
		$AnimationPlayer.play("Bomb")
	pass # Replace with function body.


func _on_attack_area_body_entered(body):
	if body.name == "Player":
		get_tree().reload_current_scene()
	pass # Replace with function body. 


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
	pass # Replace with function body.
