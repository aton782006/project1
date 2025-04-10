extends CharacterBody2D





func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.name == "Player" :
		$gun/AnimationPlayer.play("gun")
	pass # Replace with function body.





func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" :
		body.damage(1)
	pass # Replace with function body.


func _on_area_2d_2_body_exited(body: Node2D) -> void:
	if body.name == "Player" :
		$gun/AnimationPlayer.play("RESET")
	pass # Replace with function body.
