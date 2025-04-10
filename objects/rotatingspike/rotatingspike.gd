extends Line2D

@export var distance = 70.0
@export var speed = 1.0
@export var max_rotation = 90.0
@export var damage = 1.0

func _ready() -> void:
	add_point(Vector2(0,distance))
	$Area2D.position = Vector2(0,distance)

func _physics_process(_delta: float) -> void:
	rotation_degrees+=speed
	if max_rotation:
		if (rotation_degrees >= max_rotation && speed > 0) || (rotation_degrees <= -max_rotation && speed < 0):
			speed *= -1

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.health_manager.take_damage(damage)
		body.knockback(sign(body.global_position.x-$Area2D.global_position.x))
		Global.camera.shake(1.2,0.2)
	if body.is_in_group("Enemys"):
		body.damage(damage)
		body.knockback(sign(body.global_position.x-$Area2D.global_position.x))
