extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.damage(1)
		body.knockback(sign(body.global_position.x-global_position.x))
		Global.camera.shake(1.2,0.2)
	if body.is_in_group("Enemys"):
		body.damage(1)
		body.knockback(sign(body.global_position.x-global_position.x))
